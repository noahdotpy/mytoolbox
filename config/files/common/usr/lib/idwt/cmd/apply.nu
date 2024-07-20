#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *
use ../group.nu *
use ../config.nu *

def "apply block-flatpak-networking" [
    --config = $config_file: path,
    --as_user: string,
] {
    mut user = ($env.USER)
    if $as_user != null {
        $user = $as_user
    }

    let overrides_dir = $"/home/($user)/.local/share/flatpak/overrides"
    let flatpaks_list = open $config | get block-flatpak-networking

    for file in (ls $"($overrides_dir)") {
        let file_name = echo $file | get name | path basename
        let override_file = $"($overrides_dir)/($file_name)"
        if ((open $override_file) =~ "# IDWT_REPLACEABLE" and ($file_name in $flatpaks_list) == false) {
            chattr -i $override_file
            rm $override_file
        }
    }

    for flatpak in $flatpaks_list {
        let file_contents = "# IDWT_REPLACEABLE: Remove line if you want this file to not be automatically overwritten\n[Context]\nshared=!network;"
        let override_file = $"($overrides_dir)/($flatpak)"
        if ($override_file | path exists) == false or ((open $override_file) =~ "# IDWT_REPLACEABLE") {
            chattr -i $override_file
            echo $file_contents | save --force $override_file
            chattr +i $override_file
        } else {
            echo $"Skipping overwriting ($override_file)"
        }
    }
}

def "apply block-hosts" [
    --config = $config_file: path,
    --hosts_file: path,
] {
    let hosts_file = "/etc/hosts.d/idwt-blocked.conf"
    
    echo "## THIS FILE MAY BE REPLACED AT ANY TIME AUTOMATICALLY ##" | save --force $hosts_file

    let hosts = open $config | get block-hosts
    for host in $hosts {
        echo $"\n0.0.0.0 ($host)" | save --append $hosts_file
    }
}

def "apply user-networking" [
    --config = $config_file: path,
] {
    let blocked_group = "idwt-networking-blocked"
    let nowifi_users = open $config | get user-networking.users
    let schedules = open $config | get user-networking.schedules

    groupadd $blocked_group --force
    iptables -A OUTPUT -m owner --gid-owner $blocked_group -j DROP --suppl-groups
    ip6tables -A OUTPUT -m owner --gid-owner $blocked_group -j DROP --suppl-groups

    for username in ($nowifi_users | columns) {
        let user = $nowifi_users | get $username
        let mode = $user | get mode
        if $mode == "allow" {
            group_remove $username $blocked_group
        } else if $mode == "block" {
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
                group_remove $username $blocked_group
            } else {
                group_add $username $blocked_group
            }
        }
    }
}

def "main apply" [
    --config = $config_file: path,
    --force(-f)
    --as_user: string,
] {
    mut real_as_user = "$env.USER"
    if $as_user != null {
        $real_as_user = $as_user
    }
    if (is_column_populated $config block-hosts) {
        apply block-hosts
    }
    if (is_column_populated $config block-flatpak-networking) {
        apply block-flatpak-networking --as_user $real_as_user
    }
    if (is_column_populated $config user-networking) {
        apply user-networking
    }
}
