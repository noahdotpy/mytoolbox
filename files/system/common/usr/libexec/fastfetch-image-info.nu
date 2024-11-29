#!/usr/bin/env nu
let raw = rpm-ostree status --booted --json | jq '.deployments.[0]."container-image-reference"'
let parsed = $raw | str replace '"' '' --all
    | str replace 'ostree-image-signed:' ''
    | str replace 'ostree-unverified-registry:' ''
    | str replace 'docker://' ''
print $parsed
