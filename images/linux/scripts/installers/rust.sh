#!/bin/bash -e
################################################################################
##  File:  rust.sh
##  Desc:  Installs Rust
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

export RUSTUP_HOME=/usr/share/rust/.rustup
export CARGO_HOME=/usr/share/rust/.cargo

RUSTUP_LATEST_VERSION=1.24.3
RUSTUP_INIT_SHA="a3cb081f88a6789d104518b30d4aa410009cd08c3822a1226991d6cf0442a0f8"
curl --proto '=https' --tlsv1.2 -sSf \
  https://raw.githubusercontent.com/rust-lang/rustup/${RUSTUP_LATEST_VERSION}/rustup-init.sh -O
echo "${RUSTUP_INIT_SHA} rustup-init.sh" | sha256sum --check --
sh rustup-init.sh -y --default-toolchain=stable --profile=minimal

# Initialize environment variables
source $CARGO_HOME/env

# Install common tools
rustup component add rustfmt clippy
cargo install --locked bindgen cbindgen cargo-audit cargo-outdated

# Permissions
chmod -R 777 $(dirname $RUSTUP_HOME)

# Cleanup Cargo cache
rm -rf ${CARGO_HOME}/registry/*

# Update /etc/environemnt
prependEtcEnvironmentPath "${CARGO_HOME}/bin"

# Rust Symlinks are added to a default profile /etc/skel
pushd /etc/skel
ln -sf $RUSTUP_HOME .rustup
ln -sf $CARGO_HOME .cargo
popd

invoke_tests "Tools" "Rust"
