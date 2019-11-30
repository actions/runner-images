#!/bin/bash
################################################################################
##  File:  qemu-user-emulation.sh
##  Desc:  Installs qemu, binfmt-support and qemu-user-static
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh
source $HELPER_SCRIPTS/apt.sh

PACKAGES="qemu binfmt-support qemu-user-static"

# Test to see if the software in question is already installed, if not install it
echo "Checking to see if the installer script has already been run"
if ! IsInstalled "$PACKAGES"; then
    echo "Installing $PACKAGES"
    apt-get install -y --no-install-recommends $PACKAGES
else
    echo "$PACKAGES are already installed"
fi

# Check if qemu emulation is enabled at least for arm
if [ -r /proc/sys/fs/binfmt_misc/qemu-arm ] ; then
    echo "qemu-arm-static is not registered in binfmt_misc"
    exit 1
fi

# Check if fixed binary is enabled
# Needed for running containers without /usr/bin/qemu-xxx-static in rootfs
# https://www.kernel.org/doc/html/v4.14/admin-guide/binfmt-misc.html
QEMU_ARM_FIX_BIN=$(cat /proc/sys/fs/binfmt_misc/qemu-arm | grep flags | grep F)
if [ -z "$QEMU_ARM_FIX_BIN" ] ; then
    echo "qemu static binary is lazy loaded by binfmt_misc"
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "QemuUserEmulation with $PACKAGES"
