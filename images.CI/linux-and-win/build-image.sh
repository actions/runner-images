#!/bin/bash

# FIXME: 独自追加
# ローカル実行用のファイル

OS=ubuntu-24.04
TemplatePath="images/ubuntu/templates/${OS}.pkr.hcl"

echo "Show Packer Version"
packer --version

echo "Download packer plugins"
packer init $TemplatePath

echo "Validate packer template"
packer validate -syntax-only $TemplatePath

echo "Build $OS VM"
packer build $TemplatePath
