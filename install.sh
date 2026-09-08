#!/bin/bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo systemctl restart nix-daemon.service
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Apply Flake
nix run home-manager/master -- switch --flake . -b backup
