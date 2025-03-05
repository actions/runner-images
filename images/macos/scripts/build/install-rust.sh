#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rustup and Rust
################################################################################

source ~/utils/utils.sh

RUSTUP_VERSION="1.27.1"  # Set the Rustup version to pin

echo "Downloading Rustup version $RUSTUP_VERSION..."
curl -LO "https://github.com/rust-lang/rustup/releases/download/${RUSTUP_VERSION}/rustup-init"

echo "Making Rustup executable..."
chmod +x rustup-init

echo "Installing Rustup version $RUSTUP_VERSION..."
./rustup-init -y --no-modify-path

# Ensure Rustup is available in PATH
export PATH="$HOME/.cargo/bin:$PATH"

echo "Setting Rust language to stable..."
rustup default stable
rustup show active-toolchain

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Disable Rustup self-updating"
rustup set auto-self-update disable

echo "Installing common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
