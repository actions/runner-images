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

apt-get install -y software-properties-common
add-apt-repository -y ppa:hvr/ghc
apt-get update

curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
export PATH="$ghcup_bin:$PATH"
prependEtcEnvironmentPath $ghcup_bin

availableVersions=$(ghcup list -t ghc -r | grep -v "prerelease" | awk '{print $2}')

minorMajorVersions=$(echo "$availableVersions" | cut -d"." -f 1,2 | uniq | tail -n2)
for majorMinorVersion in $minorMajorVersions; do
    fullVersion=$(echo "$availableVersions" | grep "$majorMinorVersion." | tail -n1)
    echo "install ghc version $fullVersion..."
    apt-get install -y ghc-$fullVersion
    defaultGHCVersion=$fullVersion
done

echo "install cabal..."
ghcup install cabal

chmod -R 777 $GHCUP_INSTALL_BASE_PREFIX/.ghcup
ln -s $GHCUP_INSTALL_BASE_PREFIX/.ghcup /etc/skel/.ghcup
ln -s "/opt/ghc/$defaultGHCVersion/bin/ghc" "/usr/bin/ghc"

# Install the latest stable release of haskell stack
curl -sSL https://get.haskellstack.org/ | sh

invoke_tests "Haskell"