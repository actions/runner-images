#!/bin/bash
################################################################################
##  File:  haskell.sh
##  Desc:  Installs Haskell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

# Install Herbert V. Riedel's PPA for managing multiple version of ghc on ubuntu.
# https://launchpad.net/~hvr/+archive/ubuntu/ghc
apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update

# Install various versions of ghc and cabal
apt-get install -y \
    ghc-8.0.2 \
    ghc-8.2.2 \
    ghc-8.4.4 \
    ghc-8.6.2 \
    ghc-8.6.3 \
    ghc-8.6.4 \
    ghc-8.6.5 \
    ghc-8.8.1 \
    ghc-8.8.2 \
    ghc-8.8.3 \
    ghc-8.10.1 \
    cabal-install-2.0 \
    cabal-install-2.2 \
    cabal-install-2.4 \
    cabal-install-3.0 \
    cabal-install-3.2

# Install haskell stack, pinned to v2.1.3
curl -sSL https://raw.githubusercontent.com/commercialhaskell/stack/v2.1.3/etc/scripts/get-stack.sh | sh

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
# Check all ghc versions
for version in 8.0.2 8.2.2 8.4.4 8.6.2 8.6.3 8.6.4 8.6.5 8.8.1 8.8.2 8.8.3 8.10.1; do
    if ! command -v /opt/ghc/$version/bin/ghc; then
        echo "ghc $version was not installed"
        exit 1
    fi
done
# Check all cabal versions
for version in 2.0 2.2 2.4 3.0 3.2; do
    if ! command -v /opt/cabal/$version/bin/cabal; then
        echo "cabal $version was not installed"
        exit 1
    fi
done
# Check stack
if ! command -v stack; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
for version in 2.0 2.2 2.4 3.0 3.2; do
    DocumentInstalledItem "Haskell Cabal ($(/opt/cabal/$version/bin/cabal --version))"
done
for version in 8.0.2 8.2.2 8.4.4 8.6.2 8.6.3 8.6.4 8.6.5 8.8.1 8.8.2 8.8.3 8.10.1; do
    DocumentInstalledItem "GHC ($(/opt/ghc/$version/bin/ghc --version))"
done
DocumentInstalledItem "Haskell Stack ($(stack --version))"
