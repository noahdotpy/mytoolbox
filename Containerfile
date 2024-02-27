
# This stage is responsible for holding onto
# your config without copying it directly into
# the final image
FROM scratch as stage-config
COPY ./config /config

# Copy modules
# The default modules are inside blue-build/modules
# Custom modules overwrite defaults
FROM scratch as stage-modules
COPY --from=ghcr.io/blue-build/modules:latest /modules /modules
COPY ./modules /modules

# This stage is responsible for holding onto
# exports like the exports.sh
FROM docker.io/alpine as stage-exports
RUN printf "#!/usr/bin/env bash\n\nget_yaml_array() { \n  readarray -t \"\$1\" < <(echo \"\$3\" | yq -I=0 \"\$2\")\n} \n\nexport -f get_yaml_array\nexport OS_VERSION=\$(grep -Po '(?<=VERSION_ID=)\d+' /usr/lib/os-release)" >> /exports.sh && chmod +x /exports.sh

FROM ghcr.io/ublue-os/bazzite-gnome:39

LABEL org.blue-build.build-id="883b2239-07f3-4ac5-a8d7-595f7a7a45d8"
LABEL org.opencontainers.image.title="bazzite-gnome"
LABEL org.opencontainers.image.description="This is my personal OS image based on ublue-os/bazzite-gnome (AMD/Intel)."
LABEL io.artifacthub.package.readme-url=https://raw.githubusercontent.com/blue-build/cli/main/README.md

ARG RECIPE=./config/bazzite-gnome.yml
ARG IMAGE_REGISTRY=localhost
COPY cosign.pub /usr/share/ublue-os/cosign.pub

ARG CONFIG_DIRECTORY="/tmp/config"
ARG IMAGE_NAME="bazzite-gnome"
ARG BASE_IMAGE="ghcr.io/ublue-os/bazzite-gnome"
RUN \
  --mount=type=tmpfs,target=/tmp \
  --mount=type=tmpfs,target=/var \
  --mount=type=bind,from=docker.io/mikefarah/yq,src=/usr/bin/yq,dst=/usr/bin/yq \
  --mount=type=bind,from=stage-config,src=/config,dst=/tmp/config,rw \
  --mount=type=bind,from=stage-modules,src=/modules,dst=/tmp/modules,rw \
  --mount=type=bind,from=stage-exports,src=/exports.sh,dst=/tmp/exports.sh \
  --mount=type=cache,dst=/var/cache/rpm-ostree,id=rpm-ostree-cache-bazzite-gnome-39,sharing=locked \
  chmod +x /tmp/modules/rpm-ostree/rpm-ostree.sh \
  && source /tmp/exports.sh && /tmp/modules/rpm-ostree/rpm-ostree.sh '{"type":"rpm-ostree","install":["chromium","cryfs","syncthing","zsh"]}'
RUN \
  --mount=type=tmpfs,target=/tmp \
  --mount=type=tmpfs,target=/var \
  --mount=type=bind,from=docker.io/mikefarah/yq,src=/usr/bin/yq,dst=/usr/bin/yq \
  --mount=type=bind,from=stage-config,src=/config,dst=/tmp/config,rw \
  --mount=type=bind,from=stage-modules,src=/modules,dst=/tmp/modules,rw \
  --mount=type=bind,from=stage-exports,src=/exports.sh,dst=/tmp/exports.sh \
  --mount=type=cache,dst=/var/cache/rpm-ostree,id=rpm-ostree-cache-bazzite-gnome-39,sharing=locked \
  chmod +x /tmp/modules/rpm-ostree/rpm-ostree.sh \
  && source /tmp/exports.sh && /tmp/modules/rpm-ostree/rpm-ostree.sh '{"type":"rpm-ostree","install":["gnome-shell-extension-pop-shell","kvantum","libgda","libgda-sqlite","qgnomeplatform-qt5","qgnomeplatform-qt6"]}'
RUN \
  --mount=type=tmpfs,target=/tmp \
  --mount=type=tmpfs,target=/var \
  --mount=type=bind,from=docker.io/mikefarah/yq,src=/usr/bin/yq,dst=/usr/bin/yq \
  --mount=type=bind,from=stage-config,src=/config,dst=/tmp/config,rw \
  --mount=type=bind,from=stage-modules,src=/modules,dst=/tmp/modules,rw \
  --mount=type=bind,from=stage-exports,src=/exports.sh,dst=/tmp/exports.sh \
  --mount=type=cache,dst=/var/cache/rpm-ostree,id=rpm-ostree-cache-bazzite-gnome-39,sharing=locked \
  chmod +x /tmp/modules/script/script.sh \
  && source /tmp/exports.sh && /tmp/modules/script/script.sh '{"type":"script","scripts":["signing.sh"]}'
RUN \
  --mount=type=tmpfs,target=/tmp \
  --mount=type=tmpfs,target=/var \
  --mount=type=bind,from=docker.io/mikefarah/yq,src=/usr/bin/yq,dst=/usr/bin/yq \
  --mount=type=bind,from=stage-config,src=/config,dst=/tmp/config,rw \
  --mount=type=bind,from=stage-modules,src=/modules,dst=/tmp/modules,rw \
  --mount=type=bind,from=stage-exports,src=/exports.sh,dst=/tmp/exports.sh \
  --mount=type=cache,dst=/var/cache/rpm-ostree,id=rpm-ostree-cache-bazzite-gnome-39,sharing=locked \
  chmod +x /tmp/modules/signing/signing.sh \
  && source /tmp/exports.sh && /tmp/modules/signing/signing.sh '{"type":"signing"}'



COPY --from=gcr.io/projectsigstore/cosign /ko-app/cosign /usr/bin/cosign
COPY --from=ghcr.io/blue-build/cli:latest-installer /out/bluebuild /usr/bin/bluebuild

RUN ostree container commit