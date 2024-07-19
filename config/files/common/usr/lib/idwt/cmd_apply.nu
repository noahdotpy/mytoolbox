#!/usr/bin/env nu

# I Don't Want To (IDWT)

source /usr/lib/idwt/constants.nu
source /usr/lib/idwt/group.nu

def "main apply block flatpak-networking" [
    --config = $config_file: path,
    --overrides_dir = "~/.local/share/flatpak/overrides": path,
] {
    let flatpaks_list = open $config | get block.flatpak-networking

    for file in (ls $"($overrides_dir)") {
        let file_name = echo $file | get name | path basename
        let override_file = $"($overrides_dir)/($file_name)"
        if (open $override_file) =~ "# IDWT_REPLACEABLE" and ($file_name in $flatpaks_list) == false {
            chattr -i $override_file
            rm $override_file
        }
    }

    for flatpak in $flatpaks_list {
        let file_contents = "# IDWT_REPLACEABLE: Remove line if you want this file to not be automatically overwritten\n[Context]\nshared=!network;"
        let override_file = $"($overrides_dir)/($flatpak)"
        if (open $override_file) =~ "# IDWT_REPLACEABLE" {
            echo $file_contents | save --force $override_file
            chattr +i $override_file
        } else {
            echo $"Skipping overwriting ($override_file)"
        }
    }
}

def "main apply block hosts" [
    --config = $config_file: path,
    --hosts_file: path,
] {
    let hosts_file = "/etc/hosts.d/idwt-blocked.conf"
    
    echo "## THIS FILE MAY BE REPLACED AT ANY TIME AUTOMATICALLY ##" | save --force $hosts_file

    let hosts = open $config | get block.hosts
    for host in $hosts {
        echo $host
        echo $"\n0.0.0.0 ($host)" | save --append $hosts_file
    }
}

def "main apply block user-networking" [
    --config = $config_file: path,
] {
    let blocked_group = "idwt-networking-blocked"
    let nowifi_users = open $config | get user-networking.users
    let schedules = open $config | get user-networking.schedules

    # iptables -A OUTPUT -m owner --gid-owner $blocked_group -j DROP
    # ip6tables -A OUTPUT -m owner --gid-owner $blocked_group -j DROP
    # groupadd $blocked_group --force

    for username in ($nowifi_users | columns) {
        let user = $nowifi_users | get $username
        let mode = $user | get mode
        if $mode == "allow" {
            # group remove $user $blocked_group
        } else if $mode == "block" {
            # group add $user $blocked_group
        } else if $mode == "schedule" {
            let schedule_name = $user | get schedule
            let schedule = $schedules | get $schedule_name

            let days_allowed = $schedule | get days_allowed | each { |day| $day | str downcase }
            echo $days_allowed
            let time_start = $schedule | get time_start
            let time_end = $schedule | get time_end

            let current_day = ^date +%A | str downcase
            let current_time = ^date +%H:%M
            if ($current_day in $days_allowed) and (current_time >= $time_start) and (current_time < $time_end) {
                group remove $user $blocked_group
            } else {
                group add $user $blocked_group
            }
        }
    }
}

def "main apply" [
    --config = $config_file: path,
    --force(-f)
] {
    main apply block hosts
    main apply block flatpak-networking
    main apply block user-networking
}