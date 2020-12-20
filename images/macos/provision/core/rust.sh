#!/bin/bash -e -o pipefail
source ~/utils/invoke-tests.sh

echo Installing Rustup...
brew install rustup-init

echo Installing Rust language...
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

echo Initialize environment variables...
CARGO_HOME=$HOME/.cargo

echo Install common tools...
rustup component add rustfmt clippy
cargo install bindgen cbindgen cargo-audit cargo-outdated

echo Cleanup Cargo registry cached data...
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
