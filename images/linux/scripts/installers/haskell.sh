#!/bin/bash -e
################################################################################
##  File:  haskell.sh
##  Desc:  Installs Haskell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

# Any nonzero value for noninteractive installation
export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
export GHCUP_INSTALL_BASE_PREFIX=/usr/local
export BOOTSTRAP_HASKELL_GHC_VERSION=0
ghcup_bin=$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin
setEtcEnvironmentVariable "BOOTSTRAP_HASKELL_NONINTERACTIVE" $BOOTSTRAP_HASKELL_NONINTERACTIVE

# Install Herbert V. Riedel's PPA for managing multiple version of ghc on ubuntu.
# https://launchpad.net/~hvr/+archive/ubuntu/ghc
apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update

# Install GHCup
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh > /dev/null 2>&1 || true
export PATH="$ghcup_bin:$PATH"
prependEtcEnvironmentPath $ghcup_bin

# Get 2 latest Haskell Major.Minor versions
allGhcVersions=$(apt-cache search "^ghc-" | grep -Po '(\d*\.){2}\d*' | sort --unique --version-sort)
ghcMajorMinorVersions=$(echo "$allGhcVersions" | cut -d "." -f 1,2 | sort --unique --version-sort | tail -2)

# We are using apt-get to install ghc, not ghcup,
# because ghc installed through ghcup takes up too much disk space (2GB versus 1GB through apt-get)
for version in $ghcMajorMinorVersions; do
    # Get latest patch version for given Major.Minor one (ex. 8.6.5 for 8.6) and install it
    exactVersion=$(echo "$allGhcVersions" | grep $version | sort --unique --version-sort | tail -1)
    apt-get install -y ghc-$exactVersion
    ghcInstalledVersions+=("$exactVersion")
    defaultGHCVersion=$exactVersion
done

echo "install cabal..."
ghcup install cabal

chmod -R 777 $GHCUP_INSTALL_BASE_PREFIX/.ghcup
ln -s $GHCUP_INSTALL_BASE_PREFIX/.ghcup /etc/skel/.ghcup
ln -s "/opt/ghc/$defaultGHCVersion/bin/ghc" "/usr/bin/ghc"

# Install the latest stable release of haskell stack
curl -sSL https://get.haskellstack.org/ | sh

# remove PPA repo
echo "ghc ppa:hvr/ghc" >> $HELPER_SCRIPTS/apt-sources.txt
add-apt-repository --remove ppa:hvr/ghc

invoke_tests "Haskell"
