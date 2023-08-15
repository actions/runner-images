#!/bin/bash -e
################################################################################
##  File:  haskell.sh
##  Desc:  Installs Haskell
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/etc-environment.sh

# Any nonzero value for noninteractive installation
export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
export BOOTSTRAP_HASKELL_INSTALL_NO_STACK_HOOK=1
export GHCUP_INSTALL_BASE_PREFIX=/usr/local
export BOOTSTRAP_HASKELL_GHC_VERSION=0
ghcup_bin=$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin
setEtcEnvironmentVariable "BOOTSTRAP_HASKELL_NONINTERACTIVE" $BOOTSTRAP_HASKELL_NONINTERACTIVE
setEtcEnvironmentVariable "GHCUP_INSTALL_BASE_PREFIX" $GHCUP_INSTALL_BASE_PREFIX

# Install GHCup
curl --proto '=https' --tlsv1.2 -fsSL https://get-ghcup.haskell.org | sh > /dev/null 2>&1 || true
export PATH="$ghcup_bin:$PATH"
prependEtcEnvironmentPath $ghcup_bin

availableVersions=$(ghcup list -t ghc -r | grep -v "prerelease" | awk '{print $2}')

# Get 2 latest Haskell Major.Minor versions
minorMajorVersions=$(echo "$availableVersions" | cut -d"." -f 1,2 | uniq | tail -n2)
for majorMinorVersion in $minorMajorVersions; do
    fullVersion=$(echo "$availableVersions" | grep "$majorMinorVersion." | tail -n1)
    echo "install ghc version $fullVersion..."
    ghcup install ghc $fullVersion
    ghcup set ghc $fullVersion
done

echo "install cabal..."
ghcup install cabal latest

chmod -R 777 $GHCUP_INSTALL_BASE_PREFIX/.ghcup
ln -s $GHCUP_INSTALL_BASE_PREFIX/.ghcup /etc/skel/.ghcup

# Install the latest stable release of haskell stack
curl -fsSL https://get.haskellstack.org/ | sh

invoke_tests "Haskell"
