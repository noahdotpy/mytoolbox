#!/usr/bin/env bash

set -euo pipefail

fedora_version=$(cat /usr/share/ublue-os/image-info.json | jq -r '.["fedora-version"]')
wallpaper_file="/usr/share/backgrounds/f${fedora_version}/default/f${fedora_version}.xml"

config_file="/usr/etc/dconf/db/local.d/50-myublue"

echo "[org/gnome/desktop/background]" >>$config_file
echo "picture-uri='file://$wallpaper_file'" >>$config_file
echo "picture-uri-dark='file://$wallpaper_file'" >>$config_file
echo "picture-options='zoom'" >>$config_file
echo "primary-color='000000'" >>$config_file
echo "secondary-color='FFFFFF'" >>$config_file
