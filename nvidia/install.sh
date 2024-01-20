#!/usr/bin/env bash
set -euxo pipefail

NVIDIA_VERSION="${1:-}"

if [ -z "${NVIDIA_VERSION}" ]; then
	echo "I need a major version of a NVIDIA driver! (i.e., 535)"
	exit 1
fi

rpm-ostree install /tmp/akmods/akmods-cert/getchoo-akmods-cert*.rpm

rpm-ostree install \
	xorg-x11-drv-nvidia-{cuda,power}-"$NVIDIA_VERSION"* \
	nvidia-vaapi-driver \
	/tmp/akmods/kmods/kmod-nvidia-*.rpm
