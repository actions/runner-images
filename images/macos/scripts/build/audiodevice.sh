#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

echo "install switchaudio-osx"
brew_smart_install "switchaudio-osx"

echo "install sox"
brew_smart_install "sox"

# Big Sur doesn't support soundflower installation without user interaction https://github.com/mattingalls/Soundflower/releases/tag/2.0b2
# Install blackhole-2ch for Big Sur instead

echo "install blackhole-2ch"
brew_smart_install "blackhole-2ch"

echo "set BlackHole 2ch as input/output device"
SwitchAudioSource -s "BlackHole 2ch" -t input
SwitchAudioSource -s "BlackHole 2ch" -t output

invoke_tests "System" "Audio Device"
