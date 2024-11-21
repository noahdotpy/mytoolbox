# noahdotpy/myublue

> **Warning** This repository is solely intended for only my purpose and may bring breaking changes without warning.

This is a constantly updating repository which hosts my custom [bootable desktop images](https://containers.github.io/bootable/) based on Aurora/Bluefin from the Universal Blue team and built with container tooling.
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org).

## Table of contents

- [noahdotpy/myublue](#noahdotpymyublue)
  - [Table of contents](#table-of-contents)
  - [Images](#images)
    - [Streams](#streams)
  - [Installation](#installation)
    - [ISO (recommended)](#iso-recommended)
      - [Secure boot](#secure-boot)
    - [Switching from a Fedora Atomic image](#switching-from-a-fedora-atomic-image)

## Images

The images this repository offers are [Bluefin](https://projectbluefin.io) (Gnome), [Aurora](https://getaurora.dev) (Plasma), and variants of each of these that includes Hyprland as well.

Below is a table to get the name of the image you want to use:

|                   | [Aurora](https://getaurora.dev) | [Bluefin](https://projectbluefin.io) | [Aurora](https://getaurora.dev) (Hyprland) | [Bluefin](https://projectbluefin.io) (Hyprland) |
| ----------------- | ------------------------------- | ------------------------------------ | ------------------------------------------ | ----------------------------------------------- |
| Regular           | aurora                          | bluefin                              | aurora-hypr                                | bluefin-hypr                                    |
| Developer edition | aurora-dx                       | bluefin-dx                           | aurora-hypr-dx                             | bluefin-hypr-dx                                 |

Developer edition is an image with additional tools for developers, such as Visual Studio Code pre-installed and developer-related applications such as Pods (for podman management).

### Streams

|                       | :gts     | :stable | :stable-daily | :latest  |
| --------------------- | -------- | ------- | ------------- | -------- |
| Fedora version        | Previous | Current | Current       | Current  |
| Kernel version        | Gated    | Gated   | Gated         | Upstream |
| Image build frequency | Weekly   | Weekly  | Daily         | Daily    |

Add `-git` (e.g `stable-git`) to your stream to get image builds that are additionally built on every commit pushed to the repository.

## Installation

The URL format for any image is `ghcr.io/noahdotpy/{image}:{stream}`.

For example, if you want aurora-dx on the stable stream and built daily or when a git commit is pushed then you would want the following: `ghcr.io/noahdotpy/aurora-dx:stable-daily-git`

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

Below is an example of building an ISO for bluefin-dx:gts

```bash
just build-iso-ghcr bluefin-dx gts
```

#### Secure boot

After you have installed from the ISO successfully you will need to use the password `universalblue` to enroll the secure boot key.

### Switching from a Fedora Atomic image

Below is an example of switching to aurora-dx:stable

1. `bootc switch ghcr.io/noahdotpy/aurora-dx:stable`

2. Reboot computer
