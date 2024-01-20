#!/usr/bin/env bash
set -euxo pipefail

to_add=(
	"chromium"
	"fish" # > bash

	# gnome stuff
	"adw-gtk3-theme"
	"gnome-tweaks"
	"gnome-shell-extension-caffeine"
	qadwaitadecorations-qt{5,6}

	# maybe one day these will be good on flatpak :p
	"lutris"
	"mangohud"
	"steam"
)

# remove non-flatpak firefox
rpm-ostree override remove firefox firefox-langpacks

# install rpm fusion
release=$(rpm -E %fedora)
rpm-ostree install \
	"https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$release.noarch.rpm" \
	"https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$release.noarch.rpm"

# install hardware codecs
rpm-ostree override remove mesa-va-drivers --install mesa-va-drivers-freeworld
rpm-ostree install mesa-vdpau-drivers-freeworld

# install software codecs
## i have no idea why i have to do this just for ffmpeg
rpm-ostree override remove libavcodec-free libavfilter-free libavformat-free libavutil-free libpostproc-free libswresample-free libswscale-free --install ffmpeg
rpm-ostree install gstreamer1-plugin-libav gstreamer1-plugins-bad-free-extras gstreamer1-plugins-bad-freeworld gstreamer1-plugins-ugly gstreamer1-vaapi

# install extra packages
rpm-ostree install "${to_add[@]}"
