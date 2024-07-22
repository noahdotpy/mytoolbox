#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../../lib/idwt/constants.nu *

let action = cat $tighten_action_file
let field = cat $tighten_field_file
let value = cat $tighten_value_file

let approved_append_fields = [
    "block-flatpak-networking.apps"
]

let approved_update_fields = [
    "user-networking.users.*.mode" # TODO: Allow this somehow
]

if $action == "append" {
    if not ($field in $approved_append_fields) {
        echo "field is not in approved tightener paths"
        exit 1
    }
} else if $action == "update" {
    if not ($field in $approved_update_fields) {
        echo "field is not in approved tightener paths"
        exit 1
    }
} else {
    echo "unsupported action"
    exit 1
}

sudo /usr/bin/idwt edit (cat $tighten_action_file) (cat $tighten_field_file) (cat $tighten_value_file)