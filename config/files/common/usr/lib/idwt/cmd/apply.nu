#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *
use ../group.nu *
use ../config.nu *

def "apply block-flatpak-networking" [] {
    echo "## Applying: block-flatpak-networking ##"

    let users_affected = open $config_file | get block-flatpak-networking.users_affected
    for user in $users_affected {
        let overrides_dir = $"/home/($user)/.local/share/flatpak/overrides"
        let flatpaks_list = open $config_file | get block-flatpak-networking.apps
        for file in (ls $"($overrides_dir)") {
            let file_name = echo $file | get name | path basename
            let override_file = $"($overrides_dir)/($file_name)"
            if ((open $override_file) =~ "# IDWT_REPLACEABLE" and ($file_name in $flatpaks_list) == false) {
                chattr -i $override_file
                rm $override_file
                echo $"INFO: Removed redundant flatpak override at '($override_file)'"
            }
        }

        if not (is_column_populated $config_file block-flatpak-networking) {
            echo "INFO: No flatpaks listed, skipping"
            return
        }
    
        for flatpak in $flatpaks_list {
            let file_contents = "# IDWT_REPLACEABLE: Remove line if you want this file to not be automatically overwritten\n[Context]\nshared=!network;"
            let override_file = $"($overrides_dir)/($flatpak)"
            if ($override_file | path exists) == false or ((open $override_file) =~ "# IDWT_REPLACEABLE") {
                chattr -i $override_file
                echo $file_contents | save --force $override_file
                chattr +i $override_file
                echo $"INFO: Created flatpak override at '($override_file)'"
            } else {
                echo $"INFO: Skipping overwriting ($override_file)"
            }
        }
    }
}

def "apply block-hosts" [] {
    echo "## Applying: block-hosts ##"
    
    let hosts_file = "/etc/hosts.d/idwt-blocked.conf"

    rm $hosts_file
    echo "## THIS FILE MAY BE REPLACED AT ANY TIME AUTOMATICALLY ##" | save --force $hosts_file
    echo $"INFO: Saving hosts file at '($hosts_file)'"

    if not (is_column_populated $config_file block-hosts) {
        echo "INFO: No hosts listed, skipping"
        return
    }
    
    let hosts = open $config_file | get block-hosts
    for host in $hosts {
        echo $"INFO: Added '($host)' to hosts file"
        echo $"\n0.0.0.0 ($host)" | save --append $hosts_file
    }
}

def "apply user-networking" [] {
    echo "## Applying: user-networking ##"

    let blocked_group = "idwt-networking-blocked"
    let nowifi_users = open $config_file | get user-networking.users
    let schedules = open $config_file | get user-networking.schedules
    
    echo $"INFO: Creating group '($blocked_group)'"
    groupadd $blocked_group --force
    echo $"INFO: Adding iptables rule to block internet for users with group '($blocked_group)'"
    iptables -A OUTPUT -m owner --gid-owner $blocked_group -j DROP --suppl-groups
    ip6tables -A OUTPUT -m owner --gid-owner $blocked_group -j DROP --suppl-groups

    for username in ($nowifi_users | columns) {
        let user = $nowifi_users | get $username
        let mode = $user | get mode
        if $mode == "allow" {
            echo $"INFO: Allowing internet connection for user '($username)'"
            group_remove $username $blocked_group
        } else if $mode == "block" {
            echo $"INFO: Blocking internet connection for user '($username)'"
            group_add $username $blocked_group
        } else if $mode == "schedule" {
            let schedule_name = $user | get schedule
            let schedule = $schedules | get $schedule_name

            let days_allowed = $schedule | get days_allowed | each { |day| $day | str downcase }
            let time_start = $schedule | get time_start
            let time_end = $schedule | get time_end

            let current_day = ^date +%A | str downcase
            let current_time = ^date +%H:%M
            if ($current_day in $days_allowed) and (current_time >= $time_start) and (current_time < $time_end) {
                echo $"INFO: Blocking internet connection for user '($username)'"
                group_remove $username $blocked_group
            } else {
                echo $"INFO: Allowing internet connection for user '($username)'"
                group_add $username $blocked_group
            }
        }
    }
}

def "main apply" [] {
    apply block-hosts
    apply block-flatpak-networking
    apply user-networking
    
}
