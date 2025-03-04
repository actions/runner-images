#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
brew_smart_install "rustup-init"

echo "Installing Rust language..."
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

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
