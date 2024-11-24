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

The images this repository offers are Silvara (GNOME), Kavon (Plasma), and variants of each of these that includes Hyprland as well. There are also developer editions of each of these images (including the Hyprland variants).

Below is a table to get the name of the image you want to use:

| Edition           | Silvara    | Kavon    | Silvara (Hyprland) | Kavon (Hyprland) |
| ----------------- | ---------- | -------- | ------------------ | ---------------- |
| Regular           | silvara    | kavon    | silvara-hypr       | kavon-hypr       |
| Developer edition | silvara-dx | kavon-dx | silvara-hypr-dx    | kavon-hypr-dx    |

### Channels

Channels determine the fedora version you want to use. Channels will be used in your tag.

Use `current` for the current Fedora version, or use `previous` for the previous Fedora version.

### Frequencies

Frequency determine the frequency of builds you will get throughout the week.

The three frequencies are `weekly`, `git`, and `daily`. If you don't add a frequency in your tag it will default to `weekly`.

To use different build frequencies just add it to your tag. An example of this is using the `daily` build frequency on silvara previous to get `silvara:previous-daily`.

Below is a table to explain the differences between the frequencies:

|                          | weekly | git    | daily |
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

#### Secure boot

After you have installed from the ISO successfully you will need to use the password `fedora` to enroll the secure boot key.

### Switching from a Fedora Atomic image

Below is an example of switching to silvara:previous-git

1. `bootc switch ghcr.io/noahdotpy/silvara:previous-git`

2. Reboot computer
