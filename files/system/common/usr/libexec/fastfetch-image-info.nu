#!/usr/bin/env nu
print (rpm-ostree status --booted --json | jq '.deployments.[0]."container-image-reference"' | str replace '"' '' --all | split row ':' | range 1..2 | str join ':')
