#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-windows.sh
##  Desc:  Close open windows
################################################################################

source ~/utils/utils.sh

# Close System Preferences window because since Ventura arm64 it is opened by default on Apperance tab
if is_Arm64; then
    echo "Close System Preferences window"
    osascript -e 'tell application "System Preferences" to quit'

    # Close Setup Assistant window which can auto-launch on first boot of arm64 macOS 15.
    # We try a graceful AppleScript quit first, then fall back to pkill in case the app
    # is not yet scriptable. Both commands are tolerated to no-op when the app is absent.
    echo "Close Setup Assistant window"
    osascript -e 'tell application "Setup Assistant" to quit' 2>/dev/null || true
    pkill -x "Setup Assistant" 2>/dev/null || true
fi

retry=10
while [[ $retry -gt 0 ]]; do
    openwindows=$(osascript -e 'tell application "System Events" to get every window of (every process whose class of windows contains window)') && break
    retry=$((retry-1))
    if [[ $retry -eq 0 ]]; then
        echo "No retry attempts left"
        exit 1
    fi
    sleep 30
done
IFS=',' read -r -a windowslist <<< "$openwindows"

if [[ -n ${openwindows} ]]; then
    echo "Found opened window:"
fi

for key in ${!windowslist[@]}; do
    if [[ ${windowslist[$key]} =~ "NotificationCenter" ]]; then
        echo "[Warning] ${windowslist[$key]}"
    else
        echo " - ${windowslist[$key]}" | xargs
        scripterror=true
    fi
done

if [[ ${scripterror} = true ]]; then
    exit 1
fi
