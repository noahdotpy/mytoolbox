#!/usr/bin/sh

SMALL_LOGO="/usr/share/bluebuild/fastfetch/logos/fedora-blue-small"
LARGE_LOGO="/usr/share/bluebuild/fastfetch/logos/fedora-blue-large"

alias smallfetch="/usr/bin/fastfetch -c /usr/share/bluebuild/fastfetch/configs/small.jsonc --logo ${SMALL_LOGO}"
alias bigfetch="/usr/bin/fastfetch -c /usr/share/bluebuild/fastfetch/configs/large.jsonc --logo ${LARGE_LOGO}"

alias fastfetch="bigfetch"
alias neofetch="fastfetch"
