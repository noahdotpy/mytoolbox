#!/usr/bin/env nu

let entries = (ls -a /usr/share/bluebuild/homefiles/ | get name)

for entry in $entries {
  let entry_name = echo $entry | path basename
  let source_config = $"/etc/bluebuild/homefiles/($entry_name)/chezmoi.toml"
  let state_file = "~/.local/state/bluebuild/homefiles/common/chezmoi-state"
  yes "skip" | chezmoi apply --source $entry --config $source_config --no-tty --keep-going --persistent-state $state_file
}