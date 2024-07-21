#!/usr/bin/env nu

# I Don't Want To (IDWT)

use ../group.nu *

def "main group add" [
    user: string,
    group: string,
] {
    group_add $user $group
}

def "main group remove" [
    user: string,
    group: string,
] {
    group_remove $user $group
}