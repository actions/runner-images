#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

createEnvironmentVariable() {
    local JAVA_VERSION=$1
    local VENDOR_NAME=$2
    local DEFAULT=$3

    INSTALL_PATH_PATTERN=$(echo ${AGENT_TOOLSDIRECTORY}/Java_${VENDOR_NAME}_jdk/${JAVA_VERSION}*/x64/Contents/Home/)

    if [[ ${DEFAULT} == "True" ]]; then
        echo "Setting up JAVA_HOME variable to ${INSTALL_PATH_PATTERN}"
        echo "export JAVA_HOME=${INSTALL_PATH_PATTERN}" >> "${HOME}/.bashrc"
    fi

    echo "Setting up JAVA_HOME_${JAVA_VERSION}_X64 variable to ${INSTALL_PATH_PATTERN}"
    echo "export JAVA_HOME_${JAVA_VERSION}_X64=${INSTALL_PATH_PATTERN}" >> "${HOME}/.bashrc"
}

installOpenJDK() {
    local JAVA_VERSION=$1
    local VENDOR_NAME=$2

    # Get link for Java binaries and Java version
    if [[ ${VENDOR_NAME} == "Temurin-Hotspot" ]]; then
        assetUrl=$(curl -s "https://api.adoptium.net/v3/assets/latest/${JAVA_VERSION}/hotspot")
    elif [[ ${VENDOR_NAME} == "Adopt" ]]; then
        assetUrl=$(curl -s "https://api.adoptopenjdk.net/v3/assets/latest/${JAVA_VERSION}/hotspot")
    else
        echo "${VENDOR_NAME} is invalid, valid names are: Temurin-Hotspot and Adopt"
        exit 1
    fi

    asset=$(echo ${assetUrl} | jq -r '.[] | select(.binary.os=="mac" and .binary.image_type=="jdk" and .binary.architecture=="x64")')
    archivePath=$(echo ${asset} | jq -r '.binary.package.link')
    fullVersion=$(echo ${asset} | jq -r '.version.semver' | tr '+' '-')

    JAVA_TOOLCACHE_PATH=${AGENT_TOOLSDIRECTORY}/Java_${VENDOR_NAME}_jdk

    javaToolcacheVersionPath=$JAVA_TOOLCACHE_PATH/${fullVersion}
    javaToolcacheVersionArchPath=${javaToolcacheVersionPath}/x64

    # Download and extract Java binaries
    download_with_retries ${archivePath} /tmp OpenJDK-${VENDOR_NAME}-${fullVersion}.tar.gz
    
    echo "Creating ${javaToolcacheVersionArchPath} directory"
    mkdir -p ${javaToolcacheVersionArchPath}

    tar -xf /tmp/OpenJDK-${VENDOR_NAME}-${fullVersion}.tar.gz -C ${javaToolcacheVersionArchPath} --strip-components=1
    # Create complete file
    touch ${javaToolcacheVersionPath}/x64.complete

    # Create a symlink to '/Library/Java/JavaVirtualMachines'
    # so '/usr/libexec/java_home' will be able to find Java
    sudo ln -sf ${javaToolcacheVersionArchPath} /Library/Java/JavaVirtualMachines/${VENDOR_NAME}-${JAVA_VERSION}.jdk
}

defaultVersion=$(get_toolset_value '.java.default')
defaultVendor=$(get_toolset_value '.java.default_vendor')
jdkVendors=($(get_toolset_value '.java.vendors[].name'))

for jdkVendor in ${jdkVendors[@]}; do

     # get vendor-specific versions
     jdkVersionsToInstall=($(get_toolset_value ".java.vendors[] | select (.name==\"${jdkVendor}\") | .versions[]"))

     for jdkVersionToInstall in ${jdkVersionsToInstall[@]}; do

        installOpenJDK ${jdkVersionToInstall} ${jdkVendor}

        isDefaultVersion=False; [[ ${jdkVersionToInstall} == ${defaultVersion} ]] && isDefaultVersion=True

        if [[ ${jdkVendor} == ${defaultVendor} ]]; then
            createEnvironmentVariable ${jdkVersionToInstall} ${jdkVendor} ${isDefaultVersion}
        fi

    done
done

# Big Sur or newer does not have these versions of Adopt.
# Also hardcode these versions as they only exist for Adopt
if is_Catalina; then
    for adoptVersionToInstall in 12 13 14; do
        createEnvironmentVariable ${adoptVersionToInstall} "Adopt"
    done
fi

echo Installing Maven...
brew_smart_install "maven"

echo Installing Gradle ...
brew_smart_install "gradle"

invoke_tests "Java"
