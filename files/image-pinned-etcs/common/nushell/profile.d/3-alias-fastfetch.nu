let small_logo = "/usr/share/bluebuild/fastfetch/logos/fedora-blue-small"
let large_logo = "/usr/share/bluebuild/fastfetch/logos/fedora-blue-large"

alias smallfetch = /usr/bin/fastfetch -c /usr/share/bluebuild/fastfetch/configs/small.jsonc --logo ($small_logo)
alias bigfetch = /usr/bin/fastfetch -c /usr/share/bluebuild/fastfetch/configs/large.jsonc --logo ($large_logo)

alias fastfetch = bigfetch
alias neofetch = fastfetch
