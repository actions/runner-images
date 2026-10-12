#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
# ## Pin rustup due to https://github.com/actions/runner-images/issues/14097
# COMMIT=cfffe64fa6fc4d56b3b2299ce07f224191098b6a
# FILE_NAME="r/rustup.rb"
# FORMULA_NAME="rustup"
# brew_install_pinned_formula "$FORMULA_NAME" "$FILE_NAME" "$COMMIT"
brew_smart_install rustup

echo "Installing Rust language..."
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Install common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
