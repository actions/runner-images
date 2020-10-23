downloadXcode() {
    local XCODE_VERSION="$1"

    VERSION_TO_INSTALL=$(resolveLatestXcodeVersion "$XCODE_VERSION")
    if [[ -z "$VERSION_TO_INSTALL" ]]; then
        echo "No versions were found matching $XCODE_VERSION"
        exit 1
    fi

    echo "Downloading Xcode $VERSION_TO_INSTALL ..."
    xcversion install "$VERSION_TO_INSTALL" --no-install
}

resolveLatestXcodeVersion() {
    local XCODE_VERSION="$1"

    if [[ $XCODE_VERSION == "12" ]]; then
        echo "12.0.1"
    elif [[ ! $XCODE_VERSION =~ "_beta" ]]; then
        echo "${XCODE_VERSION//_/ }"
    else
        local XCODE_BETA="${XCODE_VERSION/_/ }"
        echo "$(xcversion list | sort -r | grep -m 1 "$XCODE_BETA")"
    fi
}

validateXcodeIntegrity() {
    local WORKING_DIR="$1"
    local XCODE_VERSION="$2"

    if echo $XCODE_VERSION | grep "beta"; then
        return 0
    fi

    spctl --assess --raw "${WORKING_DIR}/Xcode.app"
}

approveXcodeLicense() {
    local XCODE_VERSION="$1"
    sudo "/Applications/Xcode_${XCODE_VERSION}.app/Contents/Developer/usr/bin/xcodebuild" -license accept
}

installAdditionalPackages() {
    # should be called only for old High Sierra and Mojave
    local XCODE_VERSION="$1"
    find /Applications/Xcode_${XCODE_VERSION}.app/Contents/Resources/Packages/ -name '*.pkg' | xargs -I '{}' sudo installer -pkg '{}' -target / -allowUntrusted
}

runFirstLaunch() {
    local XCODE_VERSION="$1"
    sudo "/Applications/Xcode_${XCODE_VERSION}.app/Contents/Developer/usr/bin/xcodebuild" -runFirstLaunch
}

runFirstLaunchXcodeList() {
    local XCODE_LIST=("$@")
    if is_Less_Catalina; then
        echo "Install additional packages for Xcode ${XCODE_LIST[0]}"
        installAdditionalPackages ${XCODE_LIST[0]}
    fi

    for XCODE_VERSION in "${XCODE_LIST[@]}"
    do
        if [[ $XCODE_VERSION == 8* || $XCODE_VERSION == 9* ]]; then
            continue
        fi

        echo "Running 'runFirstLaunch' for Xcode ${XCODE_VERSION}..."
        runFirstLaunch $XCODE_VERSION
    done
}

setXcodeDeveloperDirVariables() {
    stable_xcode_versions=$(get_xcode_list_from_toolset | tr " " "\n" | grep -v "beta")
    major_versions=($(echo ${stable_xcode_versions[@]} | tr " " "\n" | cut -d '.' -f 1 | uniq))
    for MAJOR_VERSION in "${major_versions[@]}"
    do
        LATEST_STABLE_VERSION=$(echo "${stable_xcode_versions[*]}" | grep "${MAJOR_VERSION}" | tail -n 1)
        LATEST_STABLE_VERSION=$(echo $LATEST_STABLE_VERSION | cut -d"_" -f 1)
        echo "export XCODE_${MAJOR_VERSION}_DEVELOPER_DIR=/Applications/Xcode_${LATEST_STABLE_VERSION}.app/Contents/Developer" >> "$HOME/.bashrc"
    done
}

extractXcodeXip() {
    local WORKING_DIR="$1"
    local XCODE_XIP=$(find "$WORKING_DIR" -name "Xcode_*.xip" | head -n1)

    pushd $WORKING_DIR
    xip -x "${XCODE_XIP}"
    popd

    if [[ -d "${WORKING_DIR}/Xcode-beta.app" ]]; then
        mv -f "${WORKING_DIR}/Xcode-beta.app" "${WORKING_DIR}/Xcode.app"
    fi

    if [[ ! -d "${WORKING_DIR}/Xcode.app" ]]; then
        echo "'Xcode.app' doesn't exist after Xcode XIP extraction"
        exit 1
    fi
}

createXcodeSymlinks() {
    local SOURCE_XCODE=$1 && shift
    local SYMLINKS=($@)


    for TARGET_XCODE in "${SYMLINKS[@]}"
    do
        echo "Creating symlink '/Applications/Xcode_${SOURCE_XCODE}.app' -> '/Applications/Xcode_${TARGET_XCODE}.app'"
        ln -sf "/Applications/Xcode_${SOURCE_XCODE}.app" "/Applications/Xcode_${TARGET_XCODE}.app"
    done

    # TO-DO, symlink is not correct
    local FULL_XCODE_VERSION=$(echo "${XCODE_VERSION}.0.0" | cut -d'.' -f 1,2,3)
    if [ $FULL_XCODE_VERSION != $SOURCE_XCODE ]; then
        echo "Creating symlink '/Applications/Xcode_${SOURCE_XCODE}.app' -> '/Applications/Xcode_${FULL_XCODE_VERSION}.app'"
        ln -sf "/Applications/Xcode_${SOURCE_XCODE}.app" "/Applications/Xcode_${FULL_XCODE_VERSION}.app"
    fi
}