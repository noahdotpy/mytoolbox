#!/usr/bin/env bash

set -euo pipefail

podman create --name tmp ghcr.io/noahdotpy/idwt:main --replace
podman cp tmp:/out ./
podman rm -f tmp
