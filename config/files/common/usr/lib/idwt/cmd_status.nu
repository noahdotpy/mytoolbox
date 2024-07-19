#!/usr/bin/env nu

# I Don't Want To (IDWT)

def "main status user-networking" [
    user: string,
] {
    if (groups $user) =~ "idwt-networking-blocked" {
        echo "blocked"
    } else {
        echo "allowed"
    }
}