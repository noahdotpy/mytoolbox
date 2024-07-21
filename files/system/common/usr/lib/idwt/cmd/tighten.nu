#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../constants.nu *

# idwt tighten append <field> <value>
# idwt tighten edit <field> <value>

def "main tighten user-networking block" [
    user: string,
] {
    {user: $user} | to nuon | save -f $tighten_temp_file
    sudo /usr/bin/idwt edit user-networking block --from-tighten
}

def "main tighten block-hosts append" [
    ...hosts,
] {
    {hosts: $hosts} | to nuon | save -f $tighten_temp_file
    sudo /usr/bin/idwt edit block-hosts append --from-tighten
}

def "main tighten block-flatpak-networking append" [
    ...flatpaks,
] {
    {flatpaks: $flatpaks} | to nuon | save -f $tighten_temp_file
    sudo /usr/bin/idwt edit block-flatpak-networking append --from-tighten
}
