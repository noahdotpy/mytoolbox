# My custom uBlue images

> **Warning** This repository is solely intended for only my purpose and may not completely work for you.

This is a constantly updating repository which hosts my custom [ostree images](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable).
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org).

## Images

> **Tip** You can check out all images built from this repository by clicking the packages heading on the sidebar

### [Bluefin](https://projectbluefin.io) and [Aurora](https://getaurora.dev)

[![build-gts-aurorafin](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-aurorafin.yml)
[![build-latest-aurorafin](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-aurorafin.yml)
[![build-stable-aurorafin](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-aurorafin.yml)

- any image with `-dx` (such as `bluefin-dx` or `aurora-dx`) is an image with additional tools for developers

#### Update Channels

|                       | GTS    | Stable | Latest   |
| --------------------- | ------ | ------ | -------- |
| Fedora version        | 39     | 40     | 40       |
| Kernel version        | Gated  | Gated  | Upstream |
| Image build frequency | Weekly | Weekly | Daily    |

## Tags

> **Warning**
> This may not be an accurate list of tags for each image

The built images are tagged in the following way:

> **Tip** You can also check the tags by clicking on the package you want (eg: bluefin-dx) in the `Packages` area of the sidebar on the right

- `latest` - latest build
- `{commit}-{version}` - c376c87-40
- `{timestamp}` - 20240627
- `{timestamp}-{version}`- 20240627-40
- `{version}` - 40

You can rollback to an earlier build of any image by switching to a different tag.

Example:
```
rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/bluefin-dx:20240627
```

## Installation

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

You can do this by running:
```
just build-iso-ghcr bluefin-dx gts
```

### Rebase from another Fedora Atomic image

> **Warning** [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

> **Tip**
> If you are already on a signed uBlue image you may skip directly to step 3

> **Tip**
> Replace `bluefin-dx` with your preferred variant (eg: `aurora-dx`).
> Replace `:gts` with your preferred update channel (eg: `:stable`).

- 1. First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/bluefin-dx:gts
  ```
- 2. Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- 3. Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/noahdotpy/bluefin-dx:gts
  ```
- 4. Reboot again to complete the installation
  ```
  systemctl reboot
  ```

## After the installation

You will need to use the password `ublue-os` to enroll the secure boot key if you are using secure boot.
