#!/usr/bin/env bash

set -euo pipefail

OUTPUT_FILE="/usr/share/bluebuild/image-pinned-etcs/hosts"

wget https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts -O $OUTPUT_FILE
echo "Creating symlink at /usr/etc/hosts that points to $OUTPUT_FILE"
ln -s $OUTPUT_FILE /usr/etc/hosts
