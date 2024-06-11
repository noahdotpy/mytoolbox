#!/usr/bin/bash

# I Don't Want To Network (IDWTN)

USER="noah"
HOME="/home/$USER"

TO_BLOCK=$(cat $HOME/.cache/idwtn-block-this-flatpak)
FLATPAK_OVERRIDE_FILE=$HOME/.local/share/flatpak/overrides/$TO_BLOCK

echo "[Context]" >$FLATPAK_OVERRIDE_FILE
echo "shared=!network;" >>$FLATPAK_OVERRIDE_FILE
chattr +i $FLATPAK_OVERRIDE_FILE
