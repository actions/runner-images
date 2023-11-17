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

# Invoke shellenv to make brew available during runnig session
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

setEtcEnvironmentVariable HOMEBREW_NO_AUTO_UPDATE 1
setEtcEnvironmentVariable HOMEBREW_CLEANUP_PERIODIC_FULL_DAYS 3650

# Validate the installation ad hoc
echo "Validate the installation reloading /etc/environment"
reloadEtcEnvironment

gfortran=$(brew --prefix)/bin/gfortran
# Remove gfortran symlink, not to conflict with system gfortran
if [[ -e $gfortran ]]; then
    rm $gfortran
fi

invoke_tests "Tools" "Homebrew"
