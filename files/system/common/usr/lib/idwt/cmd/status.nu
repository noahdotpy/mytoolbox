#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu config_file

# Show current configured mode of <user>
def "main status user-networking" [
    user: string, # User to show current mode for (example: john)
] {
    echo (open $config_file | get user-networking.users.noah.mode)
}