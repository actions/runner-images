#!/bin/bash
################################################################################
##  File:  homebrew-validate.sh
##  Desc:  Validate the Homebrew can run after reboot without extra configuring
################################################################################

# Validate the installation
echo "Validate the Homebrew can run after reboot"

set -x
if test -d ~/.linuxbrew
then
    echo "User-dir brew"
    eval $(~/.linuxbrew/bin/brew shellenv)
    export PATH=${PATH}:~/.linuxbrew/bin
fi
if test -d /home/linuxbrew/.linuxbrew
then
    echo "System-wide brew"
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    export PATH=${PATH}:/home/linuxbrew/.linuxbrew/bin
fi
# eval $($(brew --prefix)/bin/brew shellenv)
set +x

if ! command -v brew; then
    echo "brew executable not found after reboot"
    exit 1
fi

