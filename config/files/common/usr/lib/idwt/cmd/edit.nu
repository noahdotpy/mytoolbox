#!/usr/bin/env nu

# I Don't Want To (IDWT)

# idwt edit <field> <value>
# idwt edit --append <field> <value>

use ../constants.nu *

def "main edit" [
    field?: string,
    value?: string, # raw nuon object
    --merge(-m), # merge current value with inputted value 
    --from-tighten, # do not use this argument external to the program's code
    --editor(-e): string, # editor to open config file in when `--open` is used
    --open(-o), # open config file in editor
] {
    let editor = if $editor == null {
        $env.EDITOR
    } else {
        $editor
    }

    let field = $field | split row '.' | into cell-path

    if $open {
        ^$editor $config_file
        return
    }
        
    let value = if $from_tighten {
        open $tighten_temp_file | from nuon
    } else {
        $value | from nuon
    }
    
    let config = $config_file | from yaml

    let new_config =  if $merge {
        # let old_value = $config | get $field
        # let new_value = $old_value | merge $value 
        $config | update $field ($config | select $field | merge $value)
    } else {
        $config | update $field $value
    }
    echo $new_config | to yaml
    # echo $new_config | to yaml | save --force $config_file
}

# TODO: If mode == schedule, then use `--schedule` to get schedule and add it new config.
def "main edit user-networking" [
    mode: string,
    user?: string,
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