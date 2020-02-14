#!/bin/sh
################################################################################
##  File:  valgrind.sh
##  Desc:  Installs the correct version of valgrind
################################################################################

: '
This file is used to install valgrind on target image'

# Simplified die() implementation
die() {
	printf 'FATAL: %s\n' "$2"
	exit "$1"
}

# Make sure that repository is indexed by apt for us to install
apt update || die 1 "Unable to update repositories for the usage of installing valgrind on $(lsb_release -rs)"

# Install Valgrind
apt install -y valgrind || die 1 "Unable to install valgrind on $(lsb_release -rs)"

## Add version information to the metadata file
printf 'Documenting %s version\n' "valgrind"
export VALGRIND_VALGRIND="$(valgrind -v)"
DocumentInstalledItem "Valgrind ($VALGRIND_VERSION)"
