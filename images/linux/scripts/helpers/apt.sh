#!/bin/sh
# Created by GithHub,Inc. under MIT license (https://opensource.org/licenses/MIT) in 2020
# Refactored by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020

# shellcheck source=images/linux/scripts/common-code # Source common-code for linting

: "
  This script contains helper functions for using dpkg and apt
"

masterUnset="commonPath release"

# Source common-code
commonPath="images/linux/scripts/common-code"
[ ! -f "$commonPath" ] && { printf 'FATAL: %s\n' "Unable to find '$commonPath' from current directory" ; exit 1 ;}
. "$commonPath"
sourcecheck || die 1 "Unable to source common-code in '$commonPath'"

: '
  Use dpkg to figure out if a package has already been installed

  if ! IsInstalled packageName; then
    echo "packageName is not installed!"
  fi'
pkgcheck() {
	dpkg -S "$1" >/dev/null
}

# Process packages
## Use apt-fast for parallel downloads (?)
for pkg in aria2 apt-fast; do
	# For packages that require additional repositories
	case "$release" in
		ubuntu)
			case "$pkg" in
				apt-fast)
					# FIXME: Requires sanitization - No need to add this if it's already present
					add-apt-repository -y ppa:apt-fast/stable || die 1 "Unable to add sources for package '$pkg'"
					apt update || die 1 "Unable to update repositories"
			esac ;;
		*) die 2 "Release '$release' is not supported, fixme?"
	esac

	# Process package
	if ! pkgcheck "$pkg"; then
		apt install -y "$pkg" || die 1 "Unable to install package '$pkg'"
	elif pkgcheck "$pkg"; then
		eerror "Package '$pkg' is already installed, skipping installation"
		true
	else
		die 256 "Unexpected happend while processing package '$pkg' in apt.sh"
	fi
done

# Master unset
## NOTICE: Do not double-quote since we expect spaces
unset $masterUnset
