#!/bin/bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUST_PROJECT="$SCRIPT_DIR/install-rs"
BINARY="$RUST_PROJECT/target/release/install-rs"
if [[ ! -x "$BINARY" ]] || \
   [[ "$RUST_PROJECT/src/main.rs" -nt "$BINARY" ]] || \
   [[ "$RUST_PROJECT/Cargo.toml" -nt "$BINARY" ]]; then
    echo "🔨 Building Rust helper..."
    cargo build --release --manifest-path "$RUST_PROJECT/Cargo.toml" --quiet
    echo "✅ Build complete"
fi

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
sudo systemctl restart nix-daemon.service
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf

# Apply Flake
exec "$BINARY" "$USER"
nix run home-manager/master -- switch --flake . -b backup
