#!/bin/bash -e -o pipefail

source ~/utils/utils.sh
XCODE_LIST=($(get_xcode_list_from_toolset))
DEFAULT_XCODE_VERSION=$(get_default_xcode_from_toolset)

# https://github.com/microsoft/appcenter/issues/847
# Assets.xcassets : error : CoreData: error: (6922) I/O error for database
# at $HOME/Library/Developer/Xcode/UserData/IB Support/Simulator Devices/{GUID}
echo "Erase a device's contents and settings:"
for XCODE_VERSION in "${XCODE_LIST[@]}"
do
    echo "    Xcode Version: ${XCODE_VERSION}"
    launchctl remove com.apple.CoreSimulator.CoreSimulatorService || true
    #add sleep to let CoreSimulatorService to exit
    sleep 3

    # Version 12.2_beta installed into 12.2 directory and 12.1_GM_seed in 12.1
    pattern="[0-9]{1,2}.*_"
    if [[ $XCODE_VERSION =~ $pattern ]] ; then
        XCODE_VERSION=$(echo $XCODE_VERSION | cut -d"_" -f 1)
    fi
    # Select xcode version by default
    sudo xcode-select -s "/Applications/Xcode_${XCODE_VERSION}.app/Contents/Developer"

    # Erase a device's contents and settings
    xcrun simctl erase all

    #add sleep due to sometimes "xcrun simctl list" takes more than a few moments and script fails when trying to remove CoreSimulatorSerivce
    sleep 10
done

# Select xcode version by default
echo "Setting Xcode ${DEFAULT_XCODE_VERSION} as default"
sudo xcode-select -s "/Applications/Xcode_${DEFAULT_XCODE_VERSION}.app/Contents/Developer"
