#!/usr/bin/env nu

let files = (ls -a /usr/share/bluebuild/homefiles/ | get name)

for file in $files {
  let entry_name = echo $file | path basename
  let source_config = $"/etc/bluebuild/homefiles/($entry_name)/chezmoi.toml"
  chezmoi apply --source $file --config $source_config  --no-tty --keep-going
}