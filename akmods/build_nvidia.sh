#!/usr/bin/env bash
set -euxo pipefail

_usage="
usage: ./build_nvidia.sh nvidia_driver_version
"

if [ $# -lt 1 ]; then
	echo "$_usage"
	exit 1
fi

NVIDIA_VERSION="$1"
release="$(rpm -E '%fedora.%_arch')"

rpm-ostree install \
	akmod-nvidia-"$NVIDIA_VERSION"* \
	xorg-x11-drv-nvidia-{cuda,power}-"$NVIDIA_VERSION"* \

# Either successfully build and install the kernel modules, or fail early with debug output
kernel_version="$(rpm -q kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
akmod_version="$(basename "$(rpm -q akmod-nvidia --queryformat '%{VERSION}-%{RELEASE}')" ".fc${release%%.*}")"

akmods --force --kernels "$kernel_version" --kmod nvidia

if ! modinfo /usr/lib/modules/"$kernel_version"/extra/nvidia/nvidia{,-drm,-modeset,-peermem,-uvm}.ko.xz &> /dev/null; then
	cat /var/cache/akmods/nvidia/"$akmod_version"-for-"$kernel_version".failed.log && exit 1
fi
