# noahdotpy/myfedora

> **Warning**: This repository is solely intended for only my purpose and may bring breaking changes without warning.

This is a constantly updating repository which hosts my personalised Fedora Atomic images - [built with container technology](https://containers.github.io/bootable/).
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
    - [Switching from a Fedora Atomic image](#switching-from-a-fedora-atomic-image)

## Images

The images this repository offers are `kova` (Kinoite), `silvara` (Silverblue), and `horizon` (Hyprland).

### Tags

Tags are based on the Fedora version it is based on. An example tag is `41`,
which is based on Fedora 41.

If you only use the Fedora version as your tag then you will get weekly builds
started at 4:30AM every Sunday (UTC), but you can add `-git` to your image ref
tag to get additional builds when a git commit is pushed to the default branch
of this repo. An example tag is `41-git`, which is based on Fedora 41 but gets
additional updates on every git commit instead of only weekly.

## Installation

The image reference format for any image in this repo is `ghcr.io/noahdotpy/myfedora/{image}:{tag}`.

For example, if you want Silvara on Fedora 41 and image builds weekly and on git
pushes then you would want the following tag:
`ghcr.io/noahdotpy/myfedora/silvara:41-git`.

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

Below is an example of building an ISO for silvara:41-git

```bash
just build-iso-ghcr silvara:41-git
```

### Switching from a Fedora Atomic image

Below is an example of switching to silvara:41-git

1. `bootc switch ghcr.io/noahdotpy/myfedora/silvara:41-git`

2. Reboot computer
