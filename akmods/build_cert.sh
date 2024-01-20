#!/usr/bin/env bash
set -euxo pipefail

install -D /etc/pki/akmods/certs/public_key.der /tmp/akmods-cert/rpmbuild/SOURCES/public_key.der
rpmbuild -ba \
	--define '_topdir /tmp/akmods-cert/rpmbuild' \
	--define '%_tmppath %{_topdir}/tmp' \
	/tmp/akmods-cert/akmods-cert.spec
