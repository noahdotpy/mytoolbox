#!/usr/bin/env nu

# I Don't Want To (IDWT)

source /usr/lib/idwt/group.nu

def "main group add" [
    user: string,
    group: string,
] {
    group add $user $group
}

def "main group remove" [
    user: string,
    group: string,
] {
    group remove $user $group
}