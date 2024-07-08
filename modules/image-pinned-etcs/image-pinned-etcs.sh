#!/usr/bin/env bash

# TODO: make user of module do something like
# - type: image-pinned-etcs
#   add:
#     - common

# Tell build process to exit if there are any errors.
set -oue pipefail

get_yaml_array ADD_FILES '.add[]' "$1"

if [[ ${#ADD_FILES[@]} -gt 0 ]]; then
	cd "$CONFIG_DIRECTORY/files"

	echo "Adding files to image-pinned-etcs"
	for entry in "${ADD_FILES[@]}"; do
		if [ ! -e "$CONFIG_DIRECTORY/image-pinned-etcs/$entry" ]; then
			echo "Entry $entry Does Not Exist in $CONFIG_DIRECTORY/image-pinned-etcs"
			exit 1
		fi

		echo "Copying $entry to /usr/share/ublue-os/image-pinned-etcs"
		cp -rf "$CONFIG_DIRECTORY/image-pinned-etcs/$entry/*" "/usr/share/ublue-os/image-pinned-etcs/"
	done
fi

DIRS_TO_CREATE=($(fd --type directory --base-directory $CONFIG_DIRECTORY/image-pinned-etcs | xargs))
FILES_TO_LINK=($(fd --type file --base-directory $CONFIG_DIRECTORY/image-pinned-etcs | xargs))

cp -rf $CONFIG_DIRECTORY/image-pinned-etcs /usr/share/ublue-os/image-pinned-etcs/

for dir in "${DIRS_TO_CREATE[@]}"; do
	mkdir -p /usr/etc/$dir
done

for file in "${FILES_TO_LINK[@]}"; do
	ln -s /usr/share/ublue-os/image-pinned-etcs/$file /usr/etc/$file
done
