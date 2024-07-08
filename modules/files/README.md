# `files` Module for Startingpoint

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
symlink:
  # creates a symlink that keeps contents of /etc/exampleconfig on end user machine to always be up-to-date with file supplied by the image
  - /usr/etc/exampleconfig: /usr/share/ublue-os/etc/exampleconfig
```

In the example above, `usr` represents the directory located inside the `config/files` in the repository, while `/usr` designates the corresponding destination within the image.
