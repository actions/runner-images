#!/bin/bash -e
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs the Homebrew on Linux
##  Caveat: Brew MUST NOT be used to install any tool during the image build to avoid dependencies, which may come along with the tool
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/etc-environment.sh

# Install the Homebrew on Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Update /etc/environemnt
## Put HOMEBREW_* variables
brew shellenv|grep 'export HOMEBREW'|sed -E 's/^export (.*);$/\1/' | sudo tee -a /etc/environment
# add brew executables locations to PATH
brew_path=$(brew shellenv|grep  '^export PATH' |sed -E 's/^export PATH="([^$]+)\$.*/\1/')
prependEtcEnvironmentPath "$brew_path"
setEtcEnvironmentVariable HOMEBREW_NO_AUTO_UPDATE 1
setEtcEnvironmentVariable HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 3650

# Validate the installation ad hoc
echo "Validate the installation reloading /etc/environment"
reloadEtcEnvironment

invoke_tests "Tools" "Homebrew"
