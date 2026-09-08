#!/usr/bin/env bash
set -euo pipefail

# Set up flake.nix
sudo docker run --rm -v "$PWD:/workspace" -w /workspace rust:latest \
    cargo build --release --manifest-path ./install-rs/Cargo.toml

sudo docker run --rm -v "$PWD:/workspace" -w /workspace rust:latest \
    ./install-rs/target/release/install-rs "$USER"

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo systemctl restart nix-daemon.service
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Apply Flake
nix run home-manager/master -- switch --flake . -b backup
