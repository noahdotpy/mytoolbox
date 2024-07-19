#!/usr/bin/env nu

# I Don't Want To (IDWT)

def "group add" [
    user: string,
    group: string,
] {
    usermod -aG $group $user
}

def "group remove" [
    user: string,
    group: string,
] {
    if (groups $user =~ $group) {
        gpasswd -d $user $group
    }
}
