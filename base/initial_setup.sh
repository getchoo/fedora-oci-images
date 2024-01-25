#!/usr/bin/env bash
set -euxo pipefail

# make sure we're using the right flathub
flatpak remote-delete flathub --force
flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# add all of our stuff :)
to_install=(
	"com.raggesilver.BlackBox"
	"io.github.celluloid_player.Celluloid"
	"com.spotify.Client"
	"com.discordapp.Discord"
	"com.mattjakeman.ExtensionManager"
	"org.mozilla.firefox"
	"com.github.tchx84.Flatseal"
	"org.freedesktop.Platform.VulkanLayer.MangoHud"
	"org.prismlauncher.PrismLauncher"
	"io.github.flattool.Warehouse"
)

for id in "${to_install[@]}"; do
	flatpak install --user --noninteractive flathub "$id"
done
