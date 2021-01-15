#!/bin/bash -e
################################################################################
##  File:  vercel.sh
##  Desc:  Installs the Vercel CLI
################################################################################

# Install the Vercel CLI
npm i -g vercel

echo "Creating the symlink for [now] command to vercel CLI"
ln -s /usr/local/bin/vercel /usr/local/bin/now

invoke_tests "CLI.Tools" "Vercel CLI"