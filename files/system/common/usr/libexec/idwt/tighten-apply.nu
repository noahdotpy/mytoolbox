#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../../lib/idwt/constants.nu *

let action = cat $tighten_action_file
let field = cat $tighten_field_file
let value = cat $tighten_value_file

let approved_appends = [
    "block-flatpak-networking.apps"
]

if $action == "append" {
    if not ($field in $approved_appends) {
        echo "field is not in approved tightener paths"
        exit
    }
}

sudo /usr/bin/idwt edit (cat $tighten_action_file) (cat $tighten_field_file) (cat $tighten_value_file)