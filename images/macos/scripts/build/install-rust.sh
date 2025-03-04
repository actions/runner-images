#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

#echo "Installing Rustup..."
#brew_smart_install "rustup-init"

#echo "Installing Rust language..."
#rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

RUSTUP_VERSION="1.27.1"  # Set the Rustup version to pin

echo "Installing Rustup version $RUSTUP_VERSION..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain=$RUSTUP_VERSION

# Ensure Rustup is available in PATH
export PATH="$HOME/.cargo/bin:$PATH"

echo "Setting Rust language to stable..."
rustup default stable
rustup show active-toolchain

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Disable rustup self-updating"
# This is undesirable because:
# - We will keep rustup updated (just like any other dependency).
# - rustup does not need to be the latest and greatest.
# - Self-updating in CI will introduce longer build times for no benefit.
# - ... which becomes important because self-updating happens in various
#   places, including `rustup toolchain install`.
rustup set auto-self-update disable

echo "Install common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
