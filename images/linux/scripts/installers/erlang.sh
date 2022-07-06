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

if isUbuntu20; then
    # https://github.com/actions/virtual-environments/issues/5859
    # hashes mismatch is going to happen due to not updated release file
    # on the server side,
    # pulling all the dependencies first without apt-cache parsing
    # but ignore the error
    apt-get install --no-install-recommends esl-erlang || true

    # Downoloading and installing a deb file manually, ignore deptree errors
    esl_url="https://packages.erlang-solutions.com/ubuntu/pool/esl-erlang_25.0.2-1~ubuntu~focal_amd64.deb"
    download_with_retries $esl_url  "/tmp"
    dpkg -i /tmp/esl-erlang_25.0.2-1~ubuntu~focal_amd64.deb || true

    # Restore a proper deptree which brings esl-erlang back in the loop
    # but eleminate unwanted X.org dependencies
    apt --no-install-recommends --fix-broken install
else
   apt-get install --no-install-recommends esl-erlang
fi

# Install rebar3
rebar3_url="https://github.com/erlang/rebar3/releases/latest/download/rebar3"
download_with_retries $rebar3_url "/usr/local/bin" "rebar3"
chmod +x /usr/local/bin/rebar3

# Clean up source list
rm $source_list
rm $source_key

invoke_tests "Tools" "erlang"
