#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

FILE_DIR=$MODULE_DIRECTORY/install-idwt/files

go build -o /usr/bin/idwt $FILE_DIR/idwt/main.go

mkdir -p /usr/share/bluebuild/install-idwt/
cp -r $FILE_DIR /usr/share/bluebuild/install-idwt/

ln -s /usr/share/bluebuild/install-idwt/files/sudoers-file /usr/etc/sudoers.d/idwtn

cp -r $FILE_DIR/services/* /usr/lib/systemd/user/