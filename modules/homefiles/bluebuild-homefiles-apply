#!/usr/bin/env nu

def main [
  --mode = "skip": string # skip: never overwrite existing files, overwrite: always overwrite existing files
] {
  let entries = (ls -a /usr/share/bluebuild/homefiles/ | get name)

  for entry in $entries {
    let entry_name = echo $entry | path basename
    let state_file = $"~/.local/state/bluebuild/homefiles/($entry_name)/chezmoi-state"
    if $mode == "skip" {
      yes "skip" | chezmoi apply --source $entry --persistent-state $state_file --no-tty --keep-going
    } else if $mode == "overwrite" {
      chezmoi apply --source $entry --persistent-state $state_file --force
    } else {
      echo "--mode must be either `skip` or `overwrite`"
      echo "see --help for more info"
      exit 1
    }
  }
}
