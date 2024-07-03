# My custom uBlue images

[![build-bazzite](https://github.com/noahdotpy/myublue/actions/workflows/build-bazzite.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-bazzite.yml)
[![build-gts-aurorafin](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-aurorafin.yml)
[![build-latest-aurorafin](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-aurorafin.yml)
[![build-stable-aurorafin](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-aurorafin.yml)

This repository is solely intended for only my purpose and may not work completely for your machine/workflow/something else.

This is a constantly updating repository which hosts my custom [ostree images](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable).
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org)

## Images

> **Tip** You can check out all images built from this repository by clicking the packages heading on the sidebar

### Aurora/Bluefin variants

- dx is an image mainly meant for developers

|                       | GTS    | Stable | Latest   |
| --------------------- | ------ | ------ | -------- |
| Fedora version        | 39     | 40     | 40       |
| Kernel version        | Gated  | Gated  | Upstream |
| Image build frequency | Weekly | Weekly | Daily    |

## Tags

The built images are tagged in the following way:

> **Tip** You can also check the tags by clicking on the package you want (eg: bluefin-dx-gts) in the `Packages` area of the sidebar on the right

- `latest` - latest build
- `{commit}-{version}` - c376c87-40
- `{timestamp}` - 20240627
- `{timestamp}-{version}`- 20240627-40
- `{version}` - 40

You can 'rollback' to an earlier version (a bad update may have occured) by switching to a different tag, likely timestamp.

## Installation

> **Warning** > [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

> **Tip**
> If you are already on a signed uBlue image you may skip directly to step 3

- 1. First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/bluefin-dx-gts:latest
  ```
- 2. Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- 3. Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/noahdotpy/bluefin-dx-gts:latest
  ```
- 4. Reboot again to complete the installation
  ```
  systemctl reboot
  ```

## ISO

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

You can do this by running:
```
just build-iso-ghcr bluefin-dx-gts
```