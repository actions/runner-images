#!/bin/bash -e
################################################################################
##  File:  install-erlang.sh
##  Desc:  Install erlang and rebar3
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

source_list=/etc/apt/sources.list.d/eslerlang.list
source_key=/usr/share/keyrings/eslerlang.gpg

# Install Erlang
wget -q -O - https://binaries2.erlang-solutions.com/GPG-KEY-pmanager.asc | gpg --dearmor > $source_key
echo "deb [signed-by=$source_key]  http://binaries2.erlang-solutions.com/ubuntu $(lsb_release -cs)-esl-erlang-25 contrib" > $source_list
apt-get update

apt-get install --no-install-recommends esl-erlang

# Install rebar3
rebar3_url=$(resolve_github_release_asset_url "erlang/rebar3" "endswith(\"rebar3\")" "latest")
binary_path=$(download_with_retry "$rebar3_url")
install "$binary_path" /usr/local/bin/rebar3

# Clean up source list
rm $source_list
rm $source_key

invoke_tests "Tools" "erlang"
