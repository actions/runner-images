#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-shell.sh
##  Desc:  Configure shell to use bash
################################################################################

source ~/utils/utils.sh
arch=$(get_arch)

echo "Changing shell to bash"
sudo chsh -s /bin/bash $USERNAME
sudo chsh -s /bin/bash root

# Check MacOS architecture and add HOMEBREW PATH to bashrc
if [[ $arch == "arm64" ]]; then
  echo "Adding Homebrew environment to bash"
  # Discussed here: https://github.com/Homebrew/brew/pull/18366
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.bashrc
fi
