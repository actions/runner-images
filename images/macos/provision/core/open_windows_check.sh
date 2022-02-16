#!/bin/bash -e -o pipefail

retry=10
while [ $retry -gt 0 ]; do
    openwindows=$(osascript -e 'tell application "System Events" to get every window of (every process whose class of windows contains window)') && break

    retry=$((retry-1))
    if [ $retry -eq 0 ]; then
        echo "No retry attempts left"
        exit 1
    fi
    sleep 30
done
IFS=',' read -r -a windowslist <<< "$openwindows"

if [ -n "${openwindows}" ]; then
    echo "Found opened window:"
fi

for window in "${windowslist[@]}"; do
    if [[ $window =~ "NotificationCenter" ]]; then
        echo "[Warning] $window"
    else
        echo " - ${window}" | xargs
        scripterror=true
    fi
done

if [ "${scripterror}" = true ]; then
    exit 1
fi
