#!/usr/bin/env bash

sudo dnf copr enable deathwish/emacs-pgtk-nativecomp -y
sudo dnf upgrade --refresh -y
sudo dnf groupinstall 'Development Tools'
sudo dnf groupinstall "C Development Tools and Libraries"
sudo dnf install -y emacs vim neovim editorconfig \
	     jq golang glslang cmake htop glances \
	     openssl python-devel ruby-devel nodejs \
	     npm marked wl-clipboard

