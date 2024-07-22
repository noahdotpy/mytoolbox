#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *
use ./edit.nu *

def "main tighten" [
    action: string,
    field: string,
    value: any,
] {
    echo $action | save -f $tighten_action_file
    echo $field | save -f $tighten_field_file
    echo $value | save -f $tighten_value_file

    ^$"sudo" /usr/libexec/idwt/tighten-apply.nu
}