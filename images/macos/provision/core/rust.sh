#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo Installing Rustup...
brew_smart_install "rustup-init"

echo Installing Rust language...
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

echo Initialize environment variables...
CARGO_HOME=$HOME/.cargo

echo Install common tools...
rustup component add rustfmt clippy
cargo install --locked bindgen cbindgen cargo-outdated
# Temporary hardcode cargo-audit 0.14.1 as 0.15.0 is broken https://docs.rs/crate/cargo-audit/0.15.0
cargo install cargo-audit --version 0.14.1

echo Cleanup Cargo registry cached data...
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
