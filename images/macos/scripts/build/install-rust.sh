#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rustup and Rust
################################################################################

source ~/utils/utils.sh

RUSTUP_VERSION="1.27.1"  # Set the Rustup version to pin

echo "Downloading Rustup version $RUSTUP_VERSION..."
curl -LO "https://static.rust-lang.org/rustup/archive/${RUSTUP_VERSION}/x86_64-apple-darwin/rustup-init"

# Check if the file was downloaded properly
if [[ ! -s rustup-init ]]; then
  echo "Error: Rustup download failed. Check the URL or Rustup version."
  exit 1
fi

echo "Making Rustup executable..."
chmod +x rustup-init

echo "Installing Rustup version $RUSTUP_VERSION..."
./rustup-init -y --no-modify-path || { echo "Rustup installation failed"; exit 1; }

# Ensure Rustup is available in PATH
export PATH="$HOME/.cargo/bin:$PATH"

echo "Verifying installed Rustup version..."
INSTALLED_VERSION=$(rustup --version | awk '{print $2}')
if [[ "$INSTALLED_VERSION" != "$RUSTUP_VERSION" ]]; then
  echo "Error: Expected Rustup version $RUSTUP_VERSION but found $INSTALLED_VERSION"
  exit 1
fi

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
