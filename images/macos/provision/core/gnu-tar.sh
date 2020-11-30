#!/bin/bash -e -o pipefail

echo "Installing gnu-tar..."
brew install gnu-tar

echo 'Updating PATH to use gnu-tar as "tar"'
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"