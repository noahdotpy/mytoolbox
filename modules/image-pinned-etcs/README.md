# `files` Module for Startingpoint

# TODO: Must do better for this yes

The `files` module simplifies the process of copying and removing files on the image during build time. The added files are sourced from the `config/files` directory, which is located at `/tmp/config/files` inside the image.

> **Warning**
> If you want to place anything in `/etc` of the final image, you MUST place them in `/usr/etc` in your repo, so that they're written to `/usr/etc` on the final system. That is the proper directory for "system" configuration templates on OSTree-based Fedora distros, whereas `/etc` is meant for manual overrides and editing by the machine's admin AFTER installation! See issue https://github.com/ublue-os/startingpoint/issues/28.

## Example Configuration

```yaml
type: files
add:
  - usr: /usr
remove:
  # remove script that automatically creates ~/.justfile
  - /etc/profile.d/ublue-os-just.sh
```

In the example above, `usr` represents the directory located inside the `config/files` in the repository, while `/usr` designates the corresponding destination within the image.

If you would like to have an etc configuration file that is always up-to-date with the image's default file on the end user machine then you don't want to use this module. Instead you want to use the `ln -s` command. An example is this: `ln -s /usr/share/ublue-os/etc/exampleconfig ~/.myublue/config/files/common/usr/etc/exampleconfig`. /usr/share/ublue-os/etc is the standard directory for putting these types of configuration files that symlinks can point to (making the file immutable unless the symlink is removed).
