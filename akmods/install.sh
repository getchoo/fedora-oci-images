#!/usr/bin/env bash
set -euxo pipefail

cp /tmp/akmods-cert/rpmbuild/RPMS/noarch/getchoo-akmods-cert*.rpm /var/cache/rpms/akmods-cert/
find /var/cache/akmods -type f -name \*.rpm | while read -r rpm; do
	cp "$rpm" /var/cache/rpms/kmods/
done
