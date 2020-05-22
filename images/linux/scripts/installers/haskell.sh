#!/bin/bash
################################################################################
##  File:  haskell.sh
##  Desc:  Installs Haskell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/os.sh

# Install Herbert V. Riedel's PPA for managing multiple version of ghc on ubuntu.
# https://launchpad.net/~hvr/+archive/ubuntu/ghc
apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update

# Install various versions of ghc and cabal
if isUbuntu20 ; then
    ghcVersions="8.6.5 8.8.3 8.10.1"
    cabalVersions="3.2"
fi

if isUbuntu16 || isUbuntu18 ; then
    # Install various versions of ghc and cabal
    ghcVersions="8.0.2 8.2.2 8.4.4 8.6.2 8.6.3 8.6.4 8.6.5 8.8.1 8.8.2 8.8.3 8.10.1"
    cabalVersions="2.0 2.2 2.4 3.0 3.2"
fi

for version in $ghcVersions; do
    apt-get install -y ghc-$version
done

for version in $cabalVersions; do
    apt-get install -y cabal-install-$version
done

# Install the latest stable release of haskell stack
curl -sSL https://get.haskellstack.org/ | sh

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
# Check all ghc versions
for version in $ghcVersions; do
    if ! command -v /opt/ghc/$version/bin/ghc; then
        echo "ghc $version was not installed"
        exit 1
    fi
done
# Check all cabal versions
for version in $cabalVersions; do
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
for version in $cabalVersions; do
    DocumentInstalledItem "Haskell Cabal ($(/opt/cabal/$version/bin/cabal --version))"
done
for version in $ghcVersions; do
    DocumentInstalledItem "GHC ($(/opt/ghc/$version/bin/ghc --version))"
done
DocumentInstalledItem "Haskell Stack ($(stack --version))"
