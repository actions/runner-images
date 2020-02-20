#!/bin/sh
# Created by GithHub,Inc. under MIT license (https://opensource.org/licenses/MIT) in 2020
# Refactored by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020

# shellcheck source=images/linux/scripts/common-code # Source common-code for linting

: "
  File used to installs official Microsoft package repos for the target distribution

  This script is expected to get 'packages-microsoft-prod.deb' for (fixme: why?) and make sure that the repositories are synced.
"

# Master unset - Uset to unset variables after runtime
masterUnset="release commonPath"

# Source common-code
commonPath="images/linux/scripts/common-code"
[ ! -f "$commonPath" ] && { printf 'FATAL: %s\n' "Unable to find '$commonPath' from current directory" ; exit 1 ;}
. "$commonPath"
sourcecheck || die 1 "Unable to source common-code in '$commonPath'"

# Make sure that chachedir is available
if [ ! -d "$HOME/.cache" ]; then
	mkdir "$HOME/.cache" || die 1 "Unable to create cachedir in '$HOME/.cachedir'"
elif [ -d "$HOME/.cache" ]; then
	true
else
	die 256 "Unexpected happend while checking for cachedir"
fi

case "$release" in
	ubuntu)
		# FIXME-DOCS: Why is packages-microsoft-prod.deb required?

		# Install Microsoft repository
		if [ ! -f "$HOME/.cache/actions/virtual-environments/packages-microsoft-prod.deb" ]; then
			einfo "Package packages-microsoft-prod.deb is not cached yet, chacing in '$HOME/.cache/actions/virtual-environments'"

			[ ! -d "$HOME/.cache/actions/virtual-environments" ] && { mkdir -p "$HOME/.cache/actions/virtual-environments" || die 1 "Unable to make cachedir for virtual-environments" ;}

			wget "https://packages.microsoft.com/config/ubuntu/$release/packages-microsoft-prod.deb" -O "$HOME/.cache/actions/virtual-environments" || die 1 "Unable to download package 'microsoft-prod.deb' from upstream"
		elif [ -f "$HOME/.cache/actions/virtual-environments/packages-microsoft-prod.deb" ]; then
			true
		else
			die 256 "Unexpected happend while caching package 'microsoft-prod.deb'"
		fi

		# Install required package
		if ! apt list --installed | grep -qF "packages-microsoft-prod"; then
			dpkg -i packages-microsoft-prod.deb || die 1 "Unable to install package 'packages-microsoft-prod.deb'"
		elif ! apt list --installed | grep -qF "packages-microsoft-prod"; then
			true
		else
			die 256 "Unexpected happend while installing packages-microsoft-prod.deb"
		fi

		# Install Microsoft GPG public key
		# FIXME: Sanitize
		curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

		# Update repositories
		## FIXME: Sanitize
		apt-get update || die 1 "Unable to update repositories"
	;;
	*) die 2 "Unsupported release '$release' has been parsed in repos.sh file, fixme?"
esac

# Master unset
## NOTICE: Do not double-quote since we expect spaces
unset $masterUnset
