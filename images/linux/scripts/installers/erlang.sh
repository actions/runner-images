#!/bin/bash -e
################################################################################
##  File:  erlang.sh
##  Desc:  Installs erlang
################################################################################

source_list=/etc/apt/sources.list.d/eslerlang.list

# Install Erlang
echo "deb https://binaries.erlang-solutions.com/debian $(lsb_release -cs) contrib" > $source_list
wget -q -O - https://binaries.erlang-solutions.com/debian/erlang_solutions.asc | apt-key add -
apt-get update
apt-get install -y --no-install-recommends esl-erlang

# Install rebar3
wget -q -O rebar3 https://s3.amazonaws.com/rebar3/rebar3
chmod +x rebar3
mv rebar3 /usr/local/bin/rebar3

invoke_tests "Tools" "erlang"

# Clean up source list
rm $source_list
