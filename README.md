# My custom Bluefin and Aurora images

> **Warning** This repository is solely intended for only my purpose and will update with breaking changes without warning.

This is a constantly updating repository which hosts my custom [ostree images](https://fedoraproject.org/wiki/Changes/OstreeNativeContainerStable).
GitHub will build this image, and then host it on [ghcr.io](https://github.com/features/packages).
The users can then tell the computer to boot off of that image.
GitHub keeps 90 days worth of image backups for us, thanks Microsoft!

For info on how to create your own, check out the [BlueBuild website](https://blue-build.org).

## Images

> **Tip** You can check out all images built from this repository by clicking the packages heading on the sidebar

The images this repository offers are [Bluefin](https://projectbluefin.io) (Gnome), [Aurora](https://getaurora.dev) (Plasma), and Horizon (Hyprland). Horizon is a custom spin which is based on Aurora (for regular and plasma variant) or Bluefin (for gnome variant), but with a Hyprland desktop instead.

Below is a table to figure out which image you want to use.

|                   | Aurora - Plasma | Bluefin - Gnome | Horizon - Hyprland | Horizon - Plasma and Hyprland | Horizon - Gnome and Hyprland |
| ----------------- | --------------- | --------------- | ------------------ | ----------------------------- | ---------------------------- |
| Regular           | aurora          | bluefin         | horizon            | horizon-plasma                | horizon-gnome                |
| Developer edition | aurora-dx       | bluefin-dx      | horizon-dx         | horizon-plasma-dx             | horizon-gnome-dx             |

Developer edition is an image with additional tools for developers, such as Visual Studio Code pre-installed and developer-related applications such as Pods (for podman management).

### Streams

|                       | :gts     | :stable | :stable-daily | :latest  |
| --------------------- | -------- | ------- | ------------- | -------- |
| Fedora version        | Previous | Current | Current       | Current  |
| Kernel version        | Gated    | Gated   | Gated         | Upstream |
| Image build frequency | Weekly   | Weekly  | Daily         | Daily    |

Add `-git` (e.g `stable-git`) to your stream to get image builds that are additionaly built on every commit pushed to the repository.

## Installation

The URL format for any image is `ghcr.io/noahdotpy/{image}:{stream}`.

For example, if you want aurora-dx on the stable stream and built daily or when a git commit is pushed then you would want the following: `ghcr.io/noahdotpy/aurora-dx:stable-daily-git`

### ISO (recommended)

This repository includes a justfile recipe to build ISOs locally from the GHCR registry.

You can do this by running:

```bash
just build-iso-ghcr bluefin-dx gts
```

#### Secure boot

After you have installed from the ISO succesfully you will need to use the password `universalblue` to enroll the secure boot key.

### Example of Switching to Stable Aurora (Developer Edition)

1. `bootc switch ghcr.io/noahdotpy/aurora-dx:stable`

2. Reboot computer
