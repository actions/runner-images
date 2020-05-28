#!/bin/bash
################################################################################
##  File:  haskell.sh
##  Desc:  Installs Haskell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

# Install Herbert V. Riedel's PPA for managing multiple version of ghc on ubuntu.
# https://launchpad.net/~hvr/+archive/ubuntu/ghc
apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update

# Get 3 latest Haskell versions and latest Cabal version
ghcVersions=$(apt-cache search "^ghc-" | grep -Po '(\d*\.){2}\d*' | awk 'BEGIN {FS=OFS=SUBSEP="."}{if (arr[$1,$2] < $3) arr[$1,$2] = $3} END {for (i in arr) print i,arr[i]}' | sort --version-sort | tail -3)
cabalVersion=$(apt-cache search cabal-install-[0-9] | grep -Po '\d*\.\d*' | sort --unique --version-sort | tail -1)

for version in $ghcVersions; do
    apt-get install -y ghc-$version
done

apt-get install -y cabal-install-$cabalVersion

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

# Check cabal
if ! command -v /opt/cabal/$cabalVersion/bin/cabal; then
    echo "cabal $cabalVersion was not installed"
    exit 1
fi

# Check stack
if ! command -v stack; then
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Haskell Cabal ($(/opt/cabal/$cabalVersion/bin/cabal --version))"
for version in $ghcVersions; do
    DocumentInstalledItem "GHC ($(/opt/ghc/$version/bin/ghc --version))"
done
DocumentInstalledItem "Haskell Stack ($(stack --version))"
