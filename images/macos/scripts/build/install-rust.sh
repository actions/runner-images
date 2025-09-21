#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
brew_smart_install "rustup-init"

echo "Installing Rust language..."
# Pin to 1.89.0 until https://github.com/actions/runner-images/issues/13041 && https://github.com/rust-lang/rust/issues/145936 is resolved
rustup-init -y --no-modify-path --default-toolchain=1.89.0 --profile=minimal

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Install common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
