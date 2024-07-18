#!/usr/bin/env nu

let entries = (ls -a /usr/share/bluebuild/homefiles/ | get name)

for entry in $entries {
  let entry_name = echo $entry | path basename
  let state_file = $"~/.local/state/bluebuild/homefiles/($entry_name)/chezmoi-state"
  yes "skip" | chezmoi apply --source $entry --persistent-state $state_file --no-tty --keep-going
}