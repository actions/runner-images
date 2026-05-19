#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-rust.sh
##  Desc:  Install Rust
################################################################################

source ~/utils/utils.sh

echo "Installing Rustup..."
## Pin rustup due https://github.com/actions/runner-images/issues/14097
COMMIT=cfffe64fa6fc4d56b3b2299ce07f224191098b6a
FORMULA_URL="https://raw.githubusercontent.com/Homebrew/homebrew-core/$COMMIT/Formula/r/rustup.rb"
FORMULA_PATH="$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula/r/rustup.rb"
mkdir -p "$(dirname $FORMULA_PATH)"
curl -fsSL $FORMULA_URL -o $FORMULA_PATH
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_FROM_API=1 brew install rustup

echo "Installing Rust language..."
rustup-init -y --no-modify-path --default-toolchain=stable --profile=minimal

echo "Initialize environment variables..."
CARGO_HOME=$HOME/.cargo

echo "Install common tools..."
rustup component add rustfmt clippy

echo "Cleanup Cargo registry cached data..."
rm -rf $CARGO_HOME/registry/*

invoke_tests "Rust"
