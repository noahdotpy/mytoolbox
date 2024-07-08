#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -oue pipefail

DIRS_TO_CREATE=($(fd --type directory --base-directory $CONFIG_DIRECTORY/image-pinned-etcs | xargs))
FILES_TO_LINK=($(fd --type file --base-directory $CONFIG_DIRECTORY/image-pinned-etcs | xargs))

cp -rf $CONFIG_DIRECTORY/image-pinned-etcs /usr/share/ublue-os/image-pinned-etcs/

for dir in "${DIRS_TO_CREATE[@]}"; do
	mkdir -p /etc/$dir
done

for file in "${FILES_TO_LINK[@]}"; do
	ln -s /usr/share/ublue-os/image-pinned-etcs/$file /usr/etc/$file
done
