#!/bin/bash -e -o pipefail
source ~/utils/invoke-tests.sh

echo "install soundflower"
brew install --cask soundflower

echo "install switchaudio-osx"
brew install switchaudio-osx

echo "install sox"
brew install sox

echo "set Soundflower (2ch) as input/output device"
SwitchAudioSource -s "Soundflower (2ch)" -t input
SwitchAudioSource -s "Soundflower (2ch)" -t output

invoke_tests "Common" "Audio Device"
