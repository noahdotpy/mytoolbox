#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *

def "main edit update" [
    field: cell-path,
    value: any
] {
    let config = open $config_file

    let new_config = $config | upsert $field $value

    $new_config | to yaml | save -f $config_file
    echo $new_config | to yaml
}

def "main edit append" [
    field: cell-path
    value: any,
] {
    let config = open $config_file

    let new_value = $config | get -i $field | append $value
    let new_config = $config | upsert $field $new_value

    $new_config | to yaml | save -f $config_file
    echo $new_config | to yaml
}

def "main edit" [
    --editor(-e): string, # editor to open config file in when `--open` is used
] {
    let editor = if $editor == null {
        "vim"
    } else {
        $editor
    }

    ^$editor $config_file
}