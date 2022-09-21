#!/bin/bash -e
################################################################################
##  File:  homebrew.sh
##  Desc:  Installs the Homebrew on Linux
##  Caveat: Brew MUST NOT be used to install any tool during the image build to avoid dependencies, which may come along with the tool
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/install.sh

# Install the Homebrew on Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew_shellenv="/home/linuxbrew/.linuxbrew/bin/brew shellenv"

# Update /etc/environment
## Put HOMEBREW_* variables.
$brew_shellenv | grep 'export HOMEBREW' | sed -E 's/^export (.*);$/\1/' | tr -d '"' | sudo tee -a /etc/environment
# add brew executables locations to PATH
brew_path=$($brew_shellenv | grep '^export PATH' | sed -E 's/^export PATH="([^$]+)\$.*/\1/')
prependEtcEnvironmentPath "$brew_path"
setEtcEnvironmentVariable HOMEBREW_NO_AUTO_UPDATE 1
setEtcEnvironmentVariable HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 3650

# Validate the installation ad hoc
echo "Validate the installation reloading /etc/environment"
reloadEtcEnvironment

# Install additional brew packages

# brew GCC installation needed because the default Ubuntu components
# are too old for current brew software
# See:
# https://github.com/Homebrew/homebrew-core/issues/110877

brew_packages=$(get_toolset_value .brew[].name)
for package in $brew_packages; do
    echo "Install $package"
    brew install $package
    # create symlinks for zstd in /usr/local/bin
    if [[ $package == "zstd" ]]; then
        find $(brew --prefix)/bin -name *zstd* -exec sudo sh -c 'ln -s {} /usr/local/bin/$(basename {})' ';'
    fi
done

gfortran=$(brew --prefix)/bin/gfortran
# Remove gfortran symlink, not to conflict with system gfortran
if [[ -e $gfortran ]]; then
    rm $gfortran
fi

invoke_tests "Tools" "Homebrew"
