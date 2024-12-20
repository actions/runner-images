#!/bin/bash -e
################################################################################
##  File:  install-homebrew.sh
##  Desc:  Install Homebrew on Linux
##  Caveat: Brew MUST NOT be used to install any tool during the image build to avoid dependencies, which may come along with the tool
################################################################################

# Source the helpers
source $HELPER_SCRIPTS/etc-environment.sh
source $HELPER_SCRIPTS/install.sh

# Install the Homebrew on Linux
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Invoke shellenv to make brew available during running session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

set_etc_environment_variable HOMEBREW_NO_AUTO_UPDATE 1
set_etc_environment_variable HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 3650

# Validate the installation ad hoc
echo "Validate the installation reloading /etc/environment"
reload_etc_environment

gfortran=$(brew --prefix)/bin/gfortran
# Remove gfortran symlink, not to conflict with system gfortran
if [[ -e $gfortran ]]; then
    rm $gfortran
fi

invoke_tests "Tools" "Homebrew"
