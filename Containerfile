ARG IMAGE_FLAVOR="${IMAGE_FLAVOR:-silverblue}"
ARG BASE_IMAGE="quay.io/fedora-ostree-desktops/${IMAGE_FLAVOR}"
ARG FEDORA_VERSION="${FEDORA_VERSION:-39}"

FROM ${BASE_IMAGE}:${FEDORA_VERSION} as builder

COPY initial_setup.sh /usr/local/bin/initial_setup.sh
COPY override.sh /tmp/override.sh

RUN /tmp/override.sh && rpm-ostree cleanup -m && \
	rm -rf /tmp/* /var/* && ostree container commit
