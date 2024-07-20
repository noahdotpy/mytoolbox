#!/usr/bin/env nu

# I Don't Want To (IDWT)

source /usr/lib/idwt/constants.nu

def "main edit append block hosts" [
    --config = $config_file: path,
    ...hosts,
] {
    let new_hosts = open $config | get block.hosts | append $hosts
    let new_config = open $config | update block.hosts $new_hosts
    echo $new_config | to yaml | save --force $config
}

def "main edit append block flatpak-networking" [
    --config = $config_file: path,
    ...flatpaks,
] {
    let new_flatpaks = open $config | get block.flatpak-networking | append $flatpaks
    let new_config = open $config | update block.flatpak-networking $new_flatpaks
    echo $new_config | to yaml | save --force $config
}

def "main edit" [
    --config = $config_file: path,
    --editor: string
] {
    mut real_editor = "vim"
    if $editor != null {
        $real_editor = $editor
    }
    sudo $real_editor $config
}
