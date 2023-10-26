#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

createEnvironmentVariable() {
    local JAVA_VERSION=$1
    local DEFAULT=$2

    if [[ $arch == "arm64" ]]; then
        INSTALL_PATH_PATTERN=$(echo ${AGENT_TOOLSDIRECTORY}/Java_Temurin-Hotspot_jdk/${JAVA_VERSION}*/arm64/Contents/Home/)
    else
        INSTALL_PATH_PATTERN=$(echo ${AGENT_TOOLSDIRECTORY}/Java_Temurin-Hotspot_jdk/${JAVA_VERSION}*/x64/Contents/Home/)
    fi

    if [[ ${DEFAULT} == "True" ]]; then
        echo "Setting up JAVA_HOME variable to ${INSTALL_PATH_PATTERN}"
        echo "export JAVA_HOME=${INSTALL_PATH_PATTERN}" >> "${HOME}/.bashrc"
    fi

    if [[ $arch == "arm64" ]]; then
        echo "Setting up JAVA_HOME_${JAVA_VERSION}_arm64 variable to ${INSTALL_PATH_PATTERN}"
        echo "export JAVA_HOME_${JAVA_VERSION}_arm64=${INSTALL_PATH_PATTERN}" >> "${HOME}/.bashrc"
    else
        echo "Setting up JAVA_HOME_${JAVA_VERSION}_X64 variable to ${INSTALL_PATH_PATTERN}"
        echo "export JAVA_HOME_${JAVA_VERSION}_X64=${INSTALL_PATH_PATTERN}" >> "${HOME}/.bashrc"
    fi
}

installOpenJDK() {
    local JAVA_VERSION=$1

    # Get link for Java binaries and Java version
    download_with_retries "https://api.adoptium.net/v3/assets/latest/${JAVA_VERSION}/hotspot" "/tmp" "openjdk-hotspot.json"

    if [[ $arch == "arm64" ]]; then
        asset=$(jq -r '.[] | select(.binary.os=="mac" and .binary.image_type=="jdk" and .binary.architecture=="aarch64")' /tmp/openjdk-hotspot.json)
    else
        asset=$(jq -r '.[] | select(.binary.os=="mac" and .binary.image_type=="jdk" and .binary.architecture=="x64")' /tmp/openjdk-hotspot.json)
    fi

    archivePath=$(echo ${asset} | jq -r '.binary.package.link')
    fullVersion=$(echo ${asset} | jq -r '.version.semver' | tr '+' '-')

    JAVA_TOOLCACHE_PATH=${AGENT_TOOLSDIRECTORY}/Java_Temurin-Hotspot_jdk
    javaToolcacheVersionPath=$JAVA_TOOLCACHE_PATH/${fullVersion}

    if [[ $arch == "arm64" ]]; then
        javaToolcacheVersionArchPath=${javaToolcacheVersionPath}/arm64
    else
        javaToolcacheVersionArchPath=${javaToolcacheVersionPath}/x64
    fi

    # Download and extract Java binaries
    download_with_retries ${archivePath} /tmp OpenJDK-${fullVersion}.tar.gz

    echo "Creating ${javaToolcacheVersionArchPath} directory"
    mkdir -p ${javaToolcacheVersionArchPath}

    tar -xf /tmp/OpenJDK-${fullVersion}.tar.gz -C ${javaToolcacheVersionArchPath} --strip-components=1

    # Create complete file
    if [[ $arch == "arm64" ]]; then
        touch ${javaToolcacheVersionPath}/arm64.complete
    else
        touch ${javaToolcacheVersionPath}/x64.complete
    fi

    # Create a symlink to '/Library/Java/JavaVirtualMachines'
    # so '/usr/libexec/java_home' will be able to find Java
    sudo ln -sf ${javaToolcacheVersionArchPath} /Library/Java/JavaVirtualMachines/Temurin-Hotspot-${JAVA_VERSION}.jdk
}

arch=$(get_arch)
defaultVersion=$(get_toolset_value '.java.'$arch'.default')
jdkVersionsToInstall=($(get_toolset_value ".java.${arch}.versions[]"))

for jdkVersionToInstall in ${jdkVersionsToInstall[@]}; do
    installOpenJDK ${jdkVersionToInstall}

    if [[ ${jdkVersionToInstall} == ${defaultVersion} ]]
    then
        createEnvironmentVariable ${jdkVersionToInstall} True
    else
        createEnvironmentVariable ${jdkVersionToInstall} False
    fi
done

echo Installing Maven...
brew_smart_install "maven"

echo Installing Gradle ...
brew_smart_install "gradle"

invoke_tests "Java"
