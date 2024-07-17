#!/usr/bin/env nu

let files = (ls -a /usr/share/bluebuild/homefiles/ | get name)

for file in $files {
  let entry_name = echo $file | path basename
  let source_config = $"/etc/bluebuild/homefiles/($entry_name)/chezmoi.toml"
  ^mkdir -p (echo $source_config | path dirname)
  if ((echo $source_config) | path exists) != "true" {
    touch $source_config
  }
  chezmoi apply --source $file --config $source_config  --no-tty --keep-going
}