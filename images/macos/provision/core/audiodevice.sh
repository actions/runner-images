#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "install soundflower"
brew install --cask soundflower

echo "install switchaudio-osx"
brew_smart_install "switchaudio-osx"

echo "install sox"
brew_smart_install "sox"

echo "set Soundflower (2ch) as input/output device"
SwitchAudioSource -s "Soundflower (2ch)" -t input
SwitchAudioSource -s "Soundflower (2ch)" -t output

invoke_tests "System" "Audio Device"
