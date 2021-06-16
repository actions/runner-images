#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

JAVA_TOOLCACHE_PATH=$AGENT_TOOLSDIRECTORY/Java_Adopt_jdk

createEnvironmentVariable() {
    local JAVA_VERSION=$1
    local JAVA_PATH=$2

    local JAVA_HOME_PATH=$JAVA_PATH/Contents/Home
    if [[ $JAVA_VERSION == $JAVA_DEFAULT ]]; then
        echo "export JAVA_HOME=${JAVA_HOME_PATH}" >> "${HOME}/.bashrc"
    fi
    echo "export JAVA_HOME_${JAVA_VERSION}_X64=${JAVA_HOME_PATH}" >> "${HOME}/.bashrc"
}

installJavaFromAdoptOpenJDK() {
    local JAVA_VERSION=$1

    # Get link for Java binaries and Java version
    assetUrl=$(curl -s "https://api.adoptopenjdk.net/v3/assets/latest/${JAVA_VERSION}/hotspot")
    asset=$(echo $assetUrl | jq -r '.[] | select(.binary.os=="mac" and .binary.image_type=="jdk" and .binary.architecture=="x64")')
    archivePath=$(echo $asset | jq -r '.binary.package.link')
    fullVersion=$(echo $asset | jq -r '.version.semver' | tr '+' '-')

    javaToolcacheVersionPath=$JAVA_TOOLCACHE_PATH/$fullVersion
    javaToolcacheVersionArchPath=$javaToolcacheVersionPath/x64

    # Download and extract Java binaries
    download_with_retries $archivePath /tmp OpenJDK${JAVA_VERSION}.tar.gz
    mkdir -p $javaToolcacheVersionArchPath
    tar -xzf /tmp/OpenJDK${JAVA_VERSION}.tar.gz -C $javaToolcacheVersionArchPath --strip-components=1
    # Create complete file
    touch $javaToolcacheVersionPath/x64.complete

    createEnvironmentVariable $JAVA_VERSION $javaToolcacheVersionArchPath

    # Create a symlink to '/Library/Java/JavaVirtualMachines'
    # so '/usr/libexec/java_home' will be able to find Java
    sudo ln -sf $javaToolcacheVersionArchPath /Library/Java/JavaVirtualMachines/adoptopenjdk-${JAVA_VERSION}.jdk
}

JAVA_VERSIONS_LIST=($(get_toolset_value '.java.versions | .[]'))
JAVA_DEFAULT=$(get_toolset_value '.java.default')

for JAVA_VERSION in "${JAVA_VERSIONS_LIST[@]}"
do
    installJavaFromAdoptOpenJDK $JAVA_VERSION 
done

echo Installing Maven...
brew_smart_install "maven"

echo Installing Gradle ...
brew_smart_install "gradle"

invoke_tests "Java"
