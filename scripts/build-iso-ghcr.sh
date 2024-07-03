#!/usr/bin/bash
#shellcheck disable=SC2154

image_name=$1
image_tag=$2

project_root=$(git rev-parse --show-toplevel)

if [[ ${image_name} =~ "bluefin" ]] || [[ ${image_name} =~ "gnome" ]]; then
    installer_variant=Silverblue
elif [[ ${image_name} =~ "aurora" ]] || [[ ${image_name} =~ "plasma" ]]; then
    installer_variant=Kinoite
else
    exit 1
fi

# 40
fedora_major_version=$(skopeo inspect docker://ghcr.io/noahdotpy/${image_name}:${image_tag} | jq -r '.Labels["org.opencontainers.image.version"]' | awk -F '.' '{print $1}')

# 20240703
date=$(date +%Y%m%d)

file_name=$(echo "noahdotpy-${image_name}-${image_tag}-f${fedora_major_version}-built${date}")

echo "image_name: $image_name"
echo "image_tag: $image_tag"
echo "installer_variant: $installer_variant"
echo "fedora_major_version: $fedora_major_version"
echo "file_name: $file_name"
echo "date: $date"

if ! [ -d ./build ]; then
  mkdir ./build
fi

sudo podman run --rm --privileged --volume ./build:/build-container-installer/build --security-opt label=disable --pull=newer \
ghcr.io/jasonn3/build-container-installer:latest \
ARCH="x86_64" \
ENABLE_CACHE_DNF="false" \
ENABLE_CACHE_SKOPEO="false" \
ENABLE_FLATPAK_DEPENDENCIES="false" \
ENROLLMENT_PASSWORD="fedora" \
IMAGE_NAME="${image_name}" \
IMAGE_REPO="ghcr.io/noahdotpy" \
IMAGE_TAG="${image_tag}" \
ISO_NAME="build/${file_name}.iso" \
SECURE_BOOT_KEY_URL='https://github.com/ublue-os/akmods/raw/main/certs/public_key.der' \
VARIANT="${installer_variant}" \
VERSION="${fedora_major_version}"
