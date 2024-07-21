#!/usr/bin/env nu

# I Don't Want To (IDWT)

export def "is_property_defined" [
    config: record,
    property: string,
] {
    return (not ($config | columns | where $it == $property | is-empty))
}

export def "is_property_populated" [
    config: record
    property: string,
] {
    if not (is_property_defined $config $property) {
        return false
    }
    return (not ($config | get $property | is-empty))
}