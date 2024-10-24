#!/usr/bin/env bash

/usr/libexec/plucky-install

echo "Creating symlinks to fix pluck - which installs to /opt"

# Create symlink for /opt to /var/opt since it is not created in the image yet
mkdir -p "/var/opt"
ln -s "/var/opt" "/opt"

# Create symlinks for pluck directory
mkdir -p "/usr/lib/opt/pluck"
ln -s "../../usr/lib/opt/pluck" "/var/opt/pluck"
echo "Created symlinks to fix /opt/pluck"
