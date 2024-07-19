#!/usr/bin/env nu

# I Don't Want To (IDWT)

source /home/noah/.myublue/config/files/common/usr/lib/idwt/constants.nu
source /home/noah/.myublue/config/files/common/usr/lib/idwt/group.nu

def "main apply block flatpak-networking" [
    --config = $config_file: path,
    --overrides_dir = "~/.local/share/flatpak/overrides": path,
] {
    let flatpaks_list = open $config | get block.flatpak-networking

    for file in (ls $"($overrides_dir)") {
        let file_name = echo $file | get name | path basename
        let override_file = $"($overrides_dir)/($file_name)"
        if (open $override_file) =~ "# IDWTN_REPLACEABLE" and ($file_name in $flatpaks_list) == false {
            chattr -i $override_file
            rm $override_file
        }
    }

    for flatpak in $flatpaks_list {
        let file_contents = "# IDWTN_REPLACEABLE: Remove line if you want file to not be replaced by idwtn\n[Context]\nshared=!network;"
        let override_file = $"($overrides_dir)/($flatpak)"
        if (open $override_file) =~ "# IDWTN_REPLACEABLE" {
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
    main apply block user-networking
    main apply block flatpak-networking
}

# if user in wheel group and config says user should be unadmined then remove user from wheel group
# if user not in wheel group and config says user should be admin then add user to wheel group

# I'll have to make some way to differentitate flatpak overrides, maybe a comment at the top of the file will do?

# idwt networking block host will just add configuration to file

























# function enable-networking {
    # iptables -D OUTPUT -m owner --uid-owner $USERNAME -j DROP >/dev/null
    # ip6tables -D OUTPUT -m owner --uid-owner $USERNAME -j DROP >/dev/null
    # echo "on" >$STATUS_FILE
    # echo "Networking enabled for user $USERNAME."
# }
# 
# function disable-networking {
    # iptables -A OUTPUT -m owner --uid-owner $USERNAME -j DROP >/dev/null
    # ip6tables -A OUTPUT -m owner --uid-owner $USERNAME -j DROP >/dev/null
    # echo "off" >$STATUS_FILE
    # echo "Networking disabled for user $USERNAME."
# }
# 
# USERNAME="noah"
# 
# TIME_START="08:30"
# TIME_END="15:00"
# 
# CURRENT_TIME=$(date +"%H:%M")
# DAY_OF_WEEK=$(date +%u)
# 
# CONFIG_FILE="/etc/idwt/config"
# CONFIG=$(cat $CONFIG_FILE)
# 
# STATUS_FILE="/etc/idwt/networking-status"
# 
# echo "Networking config is set to: '$CONFIG'"
# 
# if [[ "$CONFIG" = "disallow" ]]; then
    # disable-networking
# elif [[ "$CONFIG" = "allow" ]]; then
    # enable-networking
# elif [[ "$CONFIG" = "schedule" ]]; then
    # If day == wednesday and time_is_between(8:30-15:00); then: enable networking; else: disable networking.
    # if [[ "$CURRENT_TIME" > "$TIME_START" && "$CURRENT_TIME" < "$TIME_END" && "$DAY_OF_WEEK" = "3" ]]; then
        # enable-networking
    # else
        # disable-networking
    # fi
# else
    # echo "Config is not a valid option. Must be 'disallow', 'allow' or 'schedule'"
# fi
# 