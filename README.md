# noahdotpy/myfedora

> **Warning** This repository is solely intended for only my purpose and may bring breaking changes without warning.

This is a constantly updating repository which hosts my personalised Fedora Atomic images [built with container technology](https://containers.github.io/bootable/).
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org).

## Table of contents

- [noahdotpy/myfedora](#noahdotpymyfedora)
  - [Table of contents](#table-of-contents)
  - [Images](#images)
    - [Channels](#channels)
    - [Frequencies](#frequencies)
  - [Installation](#installation)
    - [ISO (recommended)](#iso-recommended)
      - [Secure boot](#secure-boot)
    - [Switching from a Fedora Atomic image](#switching-from-a-fedora-atomic-image)

## Images

The images this repository offers are Kova (Plasma), Silvara (GNOME), and variants of each of these that includes Hyprland as well. There are also developer editions of each of these images (including the Hyprland variants).

Below is a table to get the name of the image you want to use:

| Edition           | Kova    | Silvara    | Kova (Hyprland) | Silvara (Hyprland) |
| ----------------- | ------- | ---------- | --------------- | ------------------ |
| Regular           | kova    | silvara    | kova-hypr       | silvara-hypr       |
| Developer edition | kova-dx | silvara-dx | kova-hypr-dx    | silvara-hypr-dx    |

### Channels

Channels determine the fedora version you want to use. Channels will be used in your tag.

Use `current` for the current Fedora version, or use `previous` for the previous Fedora version.

You can also use the specific Fedora version you want to use as the channel. An example of the full tag aiming to use Fedora 40 with the `git` frequency is as follows: `:40-git`.

### Frequencies

Frequency determine the frequency of builds you will get throughout the week.

The three frequencies are `weekly`, `weekly-git`, and `daily-git`. If you don't add a frequency in your tag it will default to `weekly`. This means that if your tag is only `previous` or `current` or a fedora version, then you will be using the `weekly` frequency.

To use different build frequencies just add it to your tag. An example of this is using the `daily-git` build frequency on Silvara previous to get `silvara:previous-daily-git`.

Below is a table to explain the differences between the frequencies:

|                          | weekly | weekly-git    | daily-git |
| ------------------------ | ------ | ------ | ----- |
| Builds weekly/daily      | weekly | weekly | daily |
| Builds on every git push | no     | yes    | yes   |

## Installation

The URL format for any image is `ghcr.io/noahdotpy/{image}:{tag}`.

For example, if you want silvara on the `previous` channel and the `git` frequency then you would want the following: `ghcr.io/noahdotpy/silvara:previous-git`

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

- The first argument is the image name
- The second argument is the tag (channel + stream)

Below is an example of building an ISO for silvara:previous-git

```bash
just build-iso-ghcr silvara previous-git
```

### Switching from a Fedora Atomic image

Below is an example of switching to silvara:previous-git

1. `bootc switch ghcr.io/noahdotpy/silvara:previous-git`

2. Reboot computer
