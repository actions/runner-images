#!/bin/bash -e
################################################################################
##  File:  install-alsa.sh
##  Desc:  Install ALSA (Advanced Linux Sound Architecture) libraries and tools
##         Provides audio development API for MIDI and sound applications
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh

echo "Installing ALSA libraries and development tools..."

# Install ALSA packages from apt
# - alsa-base: Base ALSA configuration files
# - alsa-utils: ALSA utilities (aplay, arecord, amixer, etc.)
# - libasound2: ALSA shared library
# - libasound2-dev: ALSA development files (headers, pkgconfig)
# - libasound2-plugins: ALSA plugins for additional functionality

apt-get install -y --no-install-recommends \
    alsa-base \
    alsa-utils \
    libasound2 \
    libasound2-dev \
    libasound2-plugins

# Create a virtual sound card using snd-dummy for environments without hardware sound
# This enables ALSA API testing even on headless CI/CD runners
echo "Loading snd-dummy kernel module for virtual sound card support..."
if modprobe snd-dummy 2>/dev/null; then
    echo "snd-dummy module loaded successfully"
else
    echo "Warning: Could not load snd-dummy module (may require kernel support)"
fi

# Ensure snd-dummy loads on boot by adding to modules
if [ -d /etc/modules-load.d ]; then
    echo "snd-dummy" > /etc/modules-load.d/alsa-dummy.conf
    echo "Configured snd-dummy to load on boot"
fi

# Configure ALSA to use the dummy device as default when no hardware is present
mkdir -p /etc/alsa/conf.d
cat > /etc/alsa/conf.d/99-dummy.conf << 'EOF'
# Default to dummy sound card when no hardware is available
# This allows ALSA API to function in CI/CD environments
pcm.!default {
    type plug
    slave.pcm "null"
}

ctl.!default {
    type hw
    card 0
}
EOF

echo "ALSA installation completed successfully"

invoke_tests "ALSA"
