#!/usr/bin/env nu

let files = (ls -a /usr/share/bluebuild/homefiles/ | get name)

for file in $files {
  chezmoi apply --source $file --no-tty --keep-going
  # TODO: remove the below command chezmoi is fixed
  # this is a workaround because the above command overwrites any file written by chezmoi (no matter the source)
  chezmoi apply
}