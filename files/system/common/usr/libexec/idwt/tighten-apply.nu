#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../../lib/idwt/constants.nu *
use ../../lib/idwt/lib.nu *

let action = cat $tighten_action_file
let field = cat $tighten_field_file
let value = cat $tighten_value_file

let tightener_config = open $config_file | get tightener-config
let approved_updates = $tightener_config | get approved-updates
let approved_appends = $tightener_config | get approved-appends

if $action == "append" {
    if not (regex_matches_with_any $approved_appends $field) {
        echo $"ERROR: ($field) is not in approved tightener append fields"
    }
} else if $action == "update" {
    if not (regex_matches_with_any ($approved_updates | columns) $field) {
        echo $"ERROR: ($field) is not in approved tightener update fields"
    }
    if not (regex_matches_with_any ($approved_updates | values) $value) {
        echo $"ERROR: ($value) is not in approved tightener update values"
    }
} else {
    echo "ERROR: unsupported tightener action"
    exit 1
}

sudo /usr/bin/idwt edit (cat $tighten_action_file) (cat $tighten_field_file) (cat $tighten_value_file)

rm $tighten_action_file
rm $tighten_field_file
rm $tighten_value_file