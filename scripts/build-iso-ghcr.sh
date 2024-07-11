#!/usr/bin/bash
#shellcheck disable=SC2154

image_name=$1
image_tag=$2
file_name=$3

project_root=$(git rev-parse --show-toplevel)

if [[ ${image_name} =~ "bluefin" ]] || [[ ${image_name} =~ "gnome" ]]; then
	installer_variant=Silverblue
elif [[ ${image_name} =~ "aurora" ]] || [[ ${image_name} =~ "plasma" ]]; then
	installer_variant=Kinoite
else
	exit 1
fi

fedora_major_version=$(skopeo inspect docker://ghcr.io/noahdotpy/${image_name}:${image_tag} | jq -r '.Labels["org.opencontainers.image.version"]' | awk -F '.' '{print $1}')

date=$(date +%Y%m%d)

if [[ ${image_tag} == "latest" ]]; then
	formatted_tag=""
else
	formatted_tag="--${image_tag}"
fi

if [ $file_name = "__auto" ]; then
	file_name="build/${image_name}${formatted_tag}.${date}.iso"
else
	if [[ ! "$file_name" = *".iso" ]]; then
		file_name="${file_name}.iso"
	fi
fi

dirnames=$(dirname $file_name)

if ! [ -d $dirnames ]; then
	mkdir -p $dirnames
fi

echo "image_name: $image_name"
echo "image_tag: $image_tag"
echo "installer_variant: $installer_variant"
echo "fedora_major_version: $fedora_major_version"
echo "date: $date"
echo "file_name: $file_name"

sudo podman run --rm --privileged --volume ./$dirnames:/build-container-installer/build --security-opt label=disable --pull=newer \
	ghcr.io/jasonn3/build-container-installer:latest \
	ARCH="x86_64" \
	ENABLE_CACHE_DNF="false" \
	ENABLE_CACHE_SKOPEO="false" \
	ENABLE_FLATPAK_DEPENDENCIES="false" \
	ENROLLMENT_PASSWORD="fedora" \
	IMAGE_NAME="${image_name}" \
	IMAGE_REPO="ghcr.io/noahdotpy" \
	IMAGE_TAG="${image_tag}" \
	ISO_NAME="${file_name}" \
	SECURE_BOOT_KEY_URL='https://github.com/ublue-os/akmods/raw/main/certs/public_key.der' \
	VARIANT="${installer_variant}" \
	VERSION="${fedora_major_version}"
