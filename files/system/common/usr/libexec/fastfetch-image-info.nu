#!/usr/bin/env nu

print (bootc status --booted --format json | from json | get status.booted.image.image.image | path basename)
