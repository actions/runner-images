#!/bin/bash -e
################################################################################
##  File:  erlang.sh
##  Desc:  Installs erlang
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh

source_list=/etc/apt/sources.list.d/eslerlang.list
source_key=/usr/share/keyrings/eslerlang.gpg

# Install Erlang
wget -q -O - https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | gpg --dearmor > $source_key
echo "deb [signed-by=$source_key]  https://packages.erlang-solutions.com/ubuntu $(lsb_release -cs) contrib" > $source_list
apt-get update


apt-get install --no-install-recommends esl-erlang || true

# Downoloading and installing a deb file manually, ignore deptree errors
if isUbuntu18; then
    esl_url="https://packages.erlang-solutions.com/ubuntu/pool/esl-erlang_25.2.3-1~ubuntu~bionic_amd64.deb"
    download_with_retries $esl_url  "/tmp"
    dpkg -i /tmp/esl-erlang_25.2.3-1~ubuntu~bionic_amd64.deb || true
else
    esl_url="https://packages.erlang-solutions.com/ubuntu/pool/esl-erlang_25.2.3-2~ubuntu~focal_amd64.deb"
    download_with_retries $esl_url  "/tmp"
    dpkg -i /tmp/esl-erlang_25.2.3-2~ubuntu~focal_amd64.deb || true
fi

# Restore a proper deptree which brings esl-erlang back in the loop
# but eleminate unwanted X.org dependencies
apt --no-install-recommends --fix-broken install

# Install rebar3
rebar3_url="https://github.com/erlang/rebar3/releases/latest/download/rebar3"
download_with_retries $rebar3_url "/usr/local/bin" "rebar3"
chmod +x /usr/local/bin/rebar3

# Clean up source list
rm $source_list
rm $source_key

invoke_tests "Tools" "erlang"
