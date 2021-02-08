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
ghcup_bin=$GHCUP_INSTALL_BASE_PREFIX/.ghcup/bin
setEtcEnvironmentVariable "BOOTSTRAP_HASKELL_NONINTERACTIVE" BOOTSTRAP_HASKELL_NONINTERACTIVE

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
export PATH="$ghcup_bin:$PATH"
prependEtcEnvironmentPath $ghcup_bin

availableVersions=$(ghcup list -t ghc -r | grep -v "prerelease" | awk '{print $2}')

minorMajorVersions=$(echo "$availableVersions" | cut -d"." -f 1,2 | uniq | tail -n3)
for majorMinorVersion in $minorMajorVersions; do
    fullVersion=$(echo "$availableVersions" | grep "$majorMinorVersion." | tail -n1)
    echo "install ghc version $fullVersion..."
    ghcup install ghc $fullVersion
    ghcup set $fullVersion
done

echo "install cabal..."
ghcup install cabal

ln -s $GHCUP_INSTALL_BASE_PREFIX/.ghcup $HOME/.ghcup

# Install the latest stable release of haskell stack
curl -sSL https://get.haskellstack.org/ | sh

invoke_tests "Haskell"