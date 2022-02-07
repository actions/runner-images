#!/bin/bash -e
################################################################################
##  File:  erlang.sh
##  Desc:  Installs erlang
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

source_list=/etc/apt/sources.list.d/eslerlang.list

# Install Erlang
echo "deb https://binaries.erlang-solutions.com/debian $(lsb_release -cs) contrib" > $source_list
wget -q -O - https://binaries.erlang-solutions.com/debian/erlang_solutions.asc | apt-key add -
apt-get update
apt-get install -y --no-install-recommends esl-erlang

# Install rebar3
rebar3DownloadUrl=$(get_github_package_download_url "erlang/rebar3" "endswith(\"rebar3\")")
download_with_retries $rebar3DownloadUrl "/tmp"
mv /tmp/rebar3 /usr/local/bin/rebar3
chmod +x /usr/local/bin/rebar3

# Clean up source list
rm $source_list

invoke_tests "Tools" "erlang"
