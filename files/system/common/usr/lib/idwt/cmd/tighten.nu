#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *
use ./edit.nu *

# Allow specific approved configuration by users with idwt-tightener group
def "main tighten" [
    action: string, # The action to use (append, update)
    field: string,  # The field to take action on (example: block-hosts)
    value: any,     # The value to update/append to the field (example: youtube.com)
] {
    echo $action | save -f $tighten_action_file
    echo $field | save -f $tighten_field_file
    echo $value | save -f $tighten_value_file

    ^$"sudo" /usr/libexec/idwt/tighten-apply.nu
}