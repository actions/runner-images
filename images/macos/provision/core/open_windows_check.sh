#!/bin/bash -e -o pipefail

openwindows=$(osascript -e 'tell application "System Events" to get every window of (every process whose class of windows contains window)')
IFS=',' read -r -a windowslist <<< "$openwindows"

if [ -n "${openwindows}" ]; then
    echo "Found opened window:"
fi

for window in "${windowslist[@]}"; do
    echo " - ${window}" | xargs
    scripterror=true
done

if [ "${scripterror}" = true ]; then
    exit 1
fi
