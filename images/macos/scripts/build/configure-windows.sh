#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-windows.sh
##  Desc:  Close open windows
################################################################################

source ~/utils/utils.sh

# Close System Preferences window because in Ventura arm64 it is opened by default on Apperance tab
if is_Arm64; then
    echo "Close System Preferences window"
    osascript -e 'tell application "System Preferences" to quit'
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
