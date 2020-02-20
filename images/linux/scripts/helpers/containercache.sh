#!/bin/sh
# Created by GithHub,Inc. under MIT license (https://opensource.org/licenses/MIT) in 2020
# Refactored by Jacob Hrbek <kreyren@rixotstudio.cz> in 2020

# shellcheck source=images/linux/scripts/common-code # Source common-code for linting

: "
  Script used to prepulls Docker images used in build tasks and templates
"

# Source common-code
commonPath="images/linux/scripts/common-code"
[ ! -f "$commonPath" ] && { printf 'FATAL: %s\n' "Unable to find '$commonPath' from current directory" ; exit 1 ;}
. "$commonPath"
sourcecheck || die 1 "Unable to source common-code in '$commonPath'"

# Check deps
if ! command -v docker >/dev/null; then
	einfo "Required package 'docker' is not installed, installing"
	case "$release" in
		ubuntu)
			# Kreyren: Get the dependencies directly from https://docs.docker.com/install/linux/docker-ce/ubuntu/ if possible else use hardcoded
			dockerDeps="$({ curl https://docs.docker.com/install/linux/docker-ce/ubuntu/ 2>/dev/null | grep -A 12 'Install packages to allow <code class="highlighter-rouge">apt</code> to use a repository over HTTPS' | sed 's#<.*>##g' | tr -d ' ' | tr '\n' ' ' ;} || printf '%s\n' "apt-transport-https ca-certificates curl gnupg-agent software-properties-common")"

			# Get upstream gpg key
			## FIXME: Sanitize
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - || die 1 "Unable to import docker's GPG key"

			# Sanitize RegEx
			## NOTICE: Do not double quote, spaces are expected
			for pkg in $dockerDeps; do
				apt-cache pkgnames | grep -q "$pkg" >/dev/null || die 1 "Package '$pkg' is not available on this system, regex failure?"
			done

			# Do not double-quote since we expect spaces
			## NOTICE: Do not double quote, spaces are expected
			apt install -y $dockerDeps || die 1 "Unable to install required packages" ;;
		*) die 1 "Release '$release' is not supported, fixme?"
	esac
fi

# Add 3rd party repo for docker
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" || die 1 "Unable to add 3rd party repository for docker"

# FIXME: Sanitize
apt update || die 1 "Unable to sync repositories using apt"

# FIXME-DOCS: Why do we need these?
. "${commonPath%%common-code}/apt.sh"
. "${commonPath%%common-code}/document.sh"

# Information output
# FIXME-QA: Why do we need to output this?
systemctl status docker --no-pager



# Pull images
# NOTICE: This is translated array from bash so that it's easier to maintain while keeping bash convinience
images="
    docker.io/jekyll/builder
    mcr.microsoft.com/azure-pipelines/node8-typescript
"

for img in $(printf '%s\n' "$images" | tr '\n' ' '); do
	docker pull "$img" || die 1 "Docker was unable to pull image '$img'"
done

## Add container information to the metadata file
DocumentInstalledItem "Cached container images"

# DO_NOT_MERGE(kreyren): Context for what is this supposed to do?
while read -r line; do
    DocumentInstalledItemIndent "$line"
done <<< "$(docker images --digests --format '{{.Repository}}:{{.Tag}} (Digest: {{.Digest}})')"
