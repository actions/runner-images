#!/bin/bash -e
################################################################################
##  File:  erlang.sh
##  Desc:  Installs erlang
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

source_list=/etc/apt/sources.list.d/eslerlang.list
source_key=/usr/share/keyrings/eslerlang.gpg

# Install Erlang
wget -q -O - https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | gpg --dearmor > $source_key
echo "deb [signed-by=$source_key]  https://packages.erlang-solutions.com/ubuntu $(lsb_release -cs) contrib" > $source_list
apt-get update

apt-get install --no-install-recommends esl-erlang

# Install rebar3
rebar3_url="https://github.com/erlang/rebar3/releases/latest/download/rebar3"
download_with_retries $rebar3_url "/usr/local/bin" "rebar3"
chmod +x /usr/local/bin/rebar3

# Clean up source list
rm $source_list
rm $source_key

invoke_tests "Tools" "erlang"
