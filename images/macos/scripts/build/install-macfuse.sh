#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-macfuse.sh
##  Desc:  Install and approve macFUSE for lazy user-mode filesystems
################################################################################

source ~/utils/utils.sh

MACFUSE_VERSION="5.3.3"
MACFUSE_SHA256="7a0b7b66c0e7f8932707d1215dc9cf486e178d097ae0a2dcdf17d8530566aa15"
MACFUSE_DMG="${RUNNER_TEMP:-/tmp}/macfuse-${MACFUSE_VERSION}.dmg"
MACFUSE_URL="https://github.com/macfuse/macfuse/releases/download/macfuse-${MACFUSE_VERSION}/macfuse-${MACFUSE_VERSION}.dmg"

download_with_retry "$MACFUSE_URL" "$MACFUSE_DMG"
use_checksum_comparison "$MACFUSE_DMG" "$MACFUSE_SHA256"

mount_point=$(hdiutil attach "$MACFUSE_DMG" -nobrowse -readonly | awk '/\/Volumes\// { sub(/^.*\/Volumes\//, "/Volumes/"); print; exit }')
if [[ -z "$mount_point" ]]; then
    echo "Unable to mount macFUSE installer image"
    exit 1
fi
trap 'hdiutil detach "$mount_point" >/dev/null 2>&1 || true' EXIT

sudo installer -pkg "$mount_point/Extras/macFUSE ${MACFUSE_VERSION}.pkg" -target /

# Trigger the approval request. The image builder already provisions UI
# automation for the Security & Privacy approval used by Parallels.
sudo /Library/Filesystems/macfuse.fs/Contents/Resources/load_macfuse || true
osascript "$HOME/utils/confirm-identified-developers-macos15.scpt" "$USER_PASSWORD"
killall "System Settings" || true

invoke_tests "MacFUSE" "macFUSE installation"
