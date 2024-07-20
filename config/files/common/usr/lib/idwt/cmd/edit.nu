#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *

# TODO: If mode == schedule, then use `--schedule` to get schedule and add it new config.
def "main edit user-networking" [
    mode: string,
    user: string,
    --from-tighten, # do not use this argument external to the program's code
] {
    mut real_user = $user
    if $from_tighten {
        $real_user = $"(open $tighten_temp_file | get user)"
    }

    let new_config = open $config_file | update $"user-networking.users.($real_user)" {mode: $mode}
    echo $new_config | to yaml | save --force $config_file
}

def "main edit block-hosts append" [
    ...hosts,
    --from-tighten, # do not use this argument external to the program's code
] {
    mut real_hosts = $hosts
    if $from_tighten {
        $real_hosts = $"(open $tighten_temp_file | get hosts)"
    }

    let new_hosts = open $config_file | get block-hosts | append $real_hosts
    let new_config = open $config_file | update block-hosts $new_hosts
    echo $new_config | to yaml | save --force $config_file
}

def "main edit block-flatpak-networking append" [
    ...flatpaks,
    --from-tighten, # do not use this argument external to the program's code
] {
    mut real_flatpaks = $flatpaks
    if $from_tighten {
        $real_flatpaks = $"(open $tighten_temp_file | get flatpaks)"
    }

    let new_flatpaks = open $config_file | get block-flatpak-networking | append $real_flatpaks
    let new_config = open $config_file | update block-flatpak-networking $new_flatpaks
    echo $new_config | to yaml | save --force $config_file
}

def "main edit" [
    --editor: string
] {
    mut real_editor = "vim"
    if $editor != null {
        $real_editor = $editor
    }
    sudo $real_editor $config_file
}
