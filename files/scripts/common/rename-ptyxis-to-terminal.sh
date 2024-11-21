#!/usr/bin/env bash

set -euo pipefail

# Check if the desktop file exists
if [[ -f /usr/share/applications/org.gnome.Ptyxis.desktop ]]; then
	sed -i 's/Ptyxis/Terminal/g' /usr/share/applications/org.gnome.Ptyxis.desktop
else
	echo "Desktop file does not exist: /usr/share/applications/org.gnome.Ptyxis.desktop"
	echo "Skipped in-place editing from Ptyxis to Terminal of above desktop file"
fi
