#!/usr/bin/env nu

# I Don't Want To (IDWT)

export def "is_column_populated" [
    config: path,
    column: string,
] {
    if not (does_column_exist $config $column) {
        return false
    }
    return (not (is_column_empty $config $column))
}

export def "does_column_exist" [
    config: path,
    column: string,
] {
    return (not (open $config | columns | where $it == $column | is-empty))
}

export def "is_column_empty" [
    config: path,
    column: string,
] {
    return (open $config | get $column | is-empty)
}