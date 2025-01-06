#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-audiodevice.sh
##  Desc:  Install audio device
################################################################################

source ~/utils/utils.sh

echo "install switchaudio-osx"
brew_smart_install "switchaudio-osx"

echo "install sox"
brew_smart_install "sox"

invoke_tests "System" "Audio Device"
