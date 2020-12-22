#!/bin/bash -e

#Install GraalVM
tmp_graalvm="/tmp/graalvm"
mkdir -p "$tmp_graalvm"
url=$(curl -s https://api.github.com/repos/graalvm/graalvm-ce-builds/releases/latest | jq -r '.assets[].browser_download_url | select(contains("graalvm-ce-java11-linux-amd64"))')
curl -sL ${url} -o "$tmp_graalvm/graalvm-archive.tar.gz"
sudo tar -xzf "$tmp_graalvm/graalvm-archive.tar.gz" -C /usr/local/bin

# Run tests to determine that the software installed as expected
if [[ $(java --version) != *"GraalVM"* ]]; then
    echo "GraalVM was not installed"
    exit 1
fi