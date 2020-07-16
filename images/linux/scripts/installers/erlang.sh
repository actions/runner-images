#!/bin/bash
################################################################################
##  File:  erlang.sh
##  Desc:  Installs erlang
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

source_list=/etc/apt/sources.list.d/eslerlang.list

# Install Erlang
echo "deb http://binaries.erlang-solutions.com/debian $(lsb_release -cs) contrib" > $source_list
wget -O - http://binaries.erlang-solutions.com/debian/erlang_solutions.asc | apt-key add -
apt-get update
apt-get install -y --no-install-recommends esl-erlang

# Install rebar3
wget -q -O rebar3 https://s3.amazonaws.com/rebar3/rebar3
chmod +x rebar3
mv rebar3 /usr/local/bin/rebar3

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in erl erlc rebar3; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or not found on PATH"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
erlang_version="$(erl -version 2>&1 | tr -d '\n' | tr -d '\r')"
DocumentInstalledItem "Erlang ($erlang_version)"

# Clean up source list
rm $source_list
