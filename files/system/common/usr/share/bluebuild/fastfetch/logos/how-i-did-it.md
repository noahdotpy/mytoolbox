# How did I generate these images?

## Large
nix run nixpkgs#timg -- ~/Desktop/fedora-blue.png -g 40x40 -a | save ~/Desktop/fedora-blue-large.txt

## Small
nix run nixpkgs#timg -- ~/Desktop/fedora-blue.png -g 13x13 -p q -a | save ~/Desktop/fedora-blue-small.txt

<!-- TODO: rebuild logos with no background colour by default -->
