#!/usr/bin/env nu

let files = (ls -a /usr/share/bluebuild/homefiles/ | get name)

for file in $files {
  chezmoi apply --source $file --no-tty --keep-going
}