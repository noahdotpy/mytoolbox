#!/usr/bin/env nu

def main [image_ref: string] {
    let project_root = git rev-parse --show-toplevel

    let image_name = $image_ref | split row ':' | get 0
    let image_tag = $image_ref | split row ':' | get 0

    let installer_variant = if ($image_ref =~ "silvara") {
        "Silverblue"
    } else {
        "Kinoite"
    }

    let fedora_major_version = skopeo inspect $"docker://ghcr.io/noahdotpy/($image_ref)" |
        jq -r '.Labels["org.opencontainers.image.version"]' | awk -F '.' '{print $1}'

    let date = ^date +%Y%m%d

    let file_output = $"./build/($image_name)--($image_tag).($date).iso"

    let dirnames = dirname $file_output

    # this doesnt error if already exists,
    # and it makes the parent directories if missing
    mkdir $dirnames

    print $"image_ref: ($image_ref)"
    print $"image_name: ($image_name)"
    print $"image_tag: ($image_tag)"
    print $"installer_variant: ($installer_variant)"
    print $"fedora_major_version: ($fedora_major_version)"
    print $"date: ($date)"
    print $"file_output: ($file_output)"
    print $"CONFIRM THE ABOVE IS CORRECT BEFORE DOING ANYTHING"

    (sudo podman run --rm --privileged --volume $"($dirnames):/build-container-installer/build" --security-opt label=disable --pull=newer
    	ghcr.io/jasonn3/build-container-installer:latest
    	ARCH="x86_64"
    	ENABLE_CACHE_DNF="false"
    	ENABLE_CACHE_SKOPEO="false"
    	ENABLE_FLATPAK_DEPENDENCIES="false"
    	IMAGE_NAME=$"($image_name)"
    	IMAGE_REPO="ghcr.io/noahdotpy"
    	IMAGE_TAG=$"($image_tag)"
    	ISO_NAME=$"($file_output)"
    	VARIANT=$"($installer_variant)"
    	VERSION=$"($fedora_major_version)") # wrapped in () to enable multi-line capabilities

}
