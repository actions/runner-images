#!/bin/bash -e
################################################################################
##  File:  julia.sh
##  Desc:  Installs Julia, and adds Julia to the path
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

# get the latest julia version
json=$(curl -fsSL "https://julialang-s3.julialang.org/bin/versions.json")
julia_version=$(echo $json | jq -r '.[].files[] | select(.triplet=="x86_64-linux-gnu" and (.version | contains("-") | not)).version' | sort -V | tail -n1)

# download julia archive
julia_tar_url=$(echo $json | jq -r ".[].files[].url | select(endswith(\"julia-${julia_version}-linux-x86_64.tar.gz\"))")
julia_tar_name="julia-${julia_version}-linux-x86_64.tar.gz"
download_with_retries $julia_tar_url "/tmp" "${julia_tar_name}"

# extract files and make symlink
julia_tar_tmp="/tmp/${julia_tar_name}"
julia_installation_path="/usr/local/julia${julia_version}"
mkdir -p "${julia_installation_path}"
tar -C "${julia_installation_path}" -xzf "${julia_tar_tmp}" --strip-components=1
ln -s "${julia_installation_path}/bin/julia" /usr/bin/julia
rm "${julia_tar_tmp}"

invoke_tests "Tools" "Julia"
