#!/bin/bash -e
################################################################################
##  File:  vercel.sh
##  Desc:  Installs the Vercel CLI
################################################################################

source $HELPER_SCRIPTS/invoke-tests.sh

# Install the Vercel CLI
npm i -g vercel

echo "Creating the symlink for [now] command to vercel CLI"
ln -s /usr/local/bin/vercel /usr/local/bin/now

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
invoke_tests "CLI.Tools" "Vercel CLI"