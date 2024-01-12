#!/bin/bash
set -e

cd images/macos

# check if GITHUB_API_PAT is set
if [ -z "${GITHUB_API_PAT}" ]; then
  echo "GITHUB_API_PAT is not set"
  exit 1
fi
# check if XCODE_INSTALL_STORAGE_URL is set
if [ -z "${XCODE_INSTALL_STORAGE_URL}" ]; then
  echo "XCODE_INSTALL_STORAGE_URL is not set"
  exit 1
fi

echo "Booting up new vm from ipsw base image"
packer build \
  -var-file ./variables/macos-13.arm64.tart.pkrvars.hcl \
  templates/macOS-13.arm64.tart.prepare.pkr.hcl
echo "Disabling SIP"
packer build \
  -var-file ./variables/macos-13.arm64.tart.pkrvars.hcl \
  templates/macOS-13.arm64.tart.disable-sip.pkr.hcl
echo "Setting up the runner-image"
packer build \
  -var-file ./variables/macos-13.arm64.tart.pkrvars.hcl \
  -var "github_api_pat=${GITHUB_API_PAT}" \
  -var "xcode_install_storage_url=${XCODE_INSTALL_STORAGE_URL}" \
  templates/macOS-13.arm64.tart.pkr.hcl
echo "Setting up warpbuild components"
packer build \
  -var-file ./variables/macos-13.arm64.tart.pkrvars.hcl \
  templates/warpbuild.pkr.hcl
