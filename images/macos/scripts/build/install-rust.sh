#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
brew_smart_install rustup

export PATH="$(brew --prefix rustup)/bin:$PATH"
echo "export PATH=\"$(brew --prefix rustup)/bin:\$PATH\"" >> "$HOME/.bashrc"
rustup set profile minimal
rustup default stable

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Install common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
