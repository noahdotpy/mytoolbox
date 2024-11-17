# My custom Bluefin and Aurora images

> **Warning** This repository is solely intended for only my purpose and may not completely work for you.

This is a constantly updating repository which hosts my custom [ostree images](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable).
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org).

## Images

> **Tip** You can check out all images built from this repository by clicking the packages heading on the sidebar

### [Bluefin](https://projectbluefin.io) and [Aurora](https://getaurora.dev)

[![build-gts-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-aurorafin.yml/badge.svg)
[![build-gts-git-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-git-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-gts-git-aurorafin.yml/badge.svg)

[![build-stable-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-aurorafin.yml/badge.svg)
[![build-stable-git-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-git-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-git-aurorafin.yml/badge.svg)

[![build-stable-daily-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-daily-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-daily-aurorafin.yml/badge.svg)
[![build-stable-daily-git-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-daily-git-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-stable-daily-git-aurorafin.yml/badge.svg)

[![build-latest-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-aurorafin.yml/badge.svg)
[![build-latest-git-aurorafin.yml](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-git-aurorafin.yml/badge.svg)](https://github.com/noahdotpy/myublue/actions/workflows/build-latest-git-aurorafin.yml/badge.svg)

- any image with `-dx` (such as `bluefin-dx` or `aurora-dx`) is an image with additional tools for developers

#### Streams

|                       | :gts     | :stable | :stable-daily  | :latest  |
| --------------------- | -------- | ------- | -------------- | -------- |
| Fedora version        | Previous | Current | Current        | Current  |
| Kernel version        | Gated    | Gated   | Gated          | Upstream |
| Image build frequency | Weekly   | Weekly  | Daily          | Daily    |

Add `-git` (e.g `stable-git`) to your stream's tag to get image builds that are additionaly built on every commit pushed to the repository.

## Installation

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

You can do this by running:

```bash
just build-iso-ghcr bluefin-dx gts
```

### Rebase from another Fedora Atomic image

> **Warning** [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable) and should not be used in production, try it in a VM for a while!

To rebase an existing Silverblue/Kinoite installation to the latest build:

> **Tip**
> If you are already on a signed universal blue image you may skip directly to step 3

> **Tip**
> Replace `bluefin-dx` with your preferred variant (eg: `aurora-dx`).
> Replace `:gts` with your preferred stream (eg: `:stable`).

- 1. First rebase to the unsigned image, to get the proper signing keys and policies installed:

  ```bash
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/noahdotpy/bluefin-dx:gts
  ```

- 2. Reboot to complete the rebase:

  ```bash
  systemctl reboot
  ```

- 3. Then rebase to the signed image, like so:

  ```bash
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/noahdotpy/bluefin-dx:gts
  ```

- 4. Reboot again to complete the installation

  ```bash
  systemctl reboot
  ```

## After the installation

You will need to use the password `universalblue` to enroll the secure boot key if you are using secure boot.
