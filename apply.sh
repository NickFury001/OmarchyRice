#!/bin/bash

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon
sudo systemctl restart nix-daemon.service
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

