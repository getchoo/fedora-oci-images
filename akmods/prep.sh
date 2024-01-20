#!/usr/bin/env bash
set -euxo pipefail

# enable alternatives (for ld to be available)
mkdir -p /var/lib/alternatives

# install rpmfusion
release=$(rpm -E %fedora)
rpm-ostree install \
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$release.noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$release.noarch.rpm"

rpm-ostree install akmods mock

if [ ! -e /tmp/certs/private_key.priv ]; then
	echo "WARNING: Using test signing key." >> "${GITHUB_OUTPUT:-/dev/stdout}"
	cp /tmp/certs/private_key.priv{.test,}
	cp /tmp/certs/public_key.der{.test,}
fi

install -Dm644 {/tmp/certs,/etc/pki/akmods/certs}/public_key.der
install -Dm644 {/tmp/certs,/etc/pki/akmods/private}/private_key.priv

# directory for signed artifacts
mkdir -p /var/cache/rpms/kmods
# directory for akmods public cert
mkdir -p /var/cache/rpms/akmods-cert
