#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
brew_smart_install rustup

echo "Installing Rust..."
brew_smart_install rust

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Install common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
