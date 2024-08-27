#!/usr/bin/env bash

set -euo pipefail

FILE_DOWNLOAD="https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/gambling-porn/hosts"
OUTPUT_FILE="/usr/share/hosts/stevenblack-hosts.conf"

mkdir -p $(dirname $OUTPUT_FILE)
wget $FILE_DOWNLOAD -O $OUTPUT_FILE
