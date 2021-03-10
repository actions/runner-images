#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

JAVA_TOOLCACHE_PATH=$AGENT_TOOLSDIRECTORY/Java_Adoptium_jdk

createEnvironmentVariable() {
    local JAVA_VERSION=$1
    local JAVA_PATH=$2

    local JAVA_HOME_PATH=$JAVA_PATH/Contents/Home
    if [[ $JAVA_VERSION == $JAVA_DEFAULT ]]; then
        echo "export JAVA_HOME=${JAVA_HOME_PATH}" >> "${HOME}/.bashrc"
        export PATH="$JAVA_HOME_PATH:$PATH"
    fi
    echo "export JAVA_HOME_${JAVA_VERSION}_X64=${JAVA_HOME_PATH}" >> "${HOME}/.bashrc"
}

installJavaFromAdoptOpenJDK() {
    local JAVA_VERSION=$1

    javaRelease=$(curl -s "https://api.adoptopenjdk.net/v3/assets/latest/${JAVA_VERSION}/hotspot" | jq -r '[.[] | select(.binary.os=="mac")][0]')
    archivePath=$(echo $javaRelease | jq -r '.binary.package.link')
    fullVersion=$(echo $javaRelease | jq -r '.version.openjdk_version' | grep -o -E '^[0-9]+\.[0-9]+\.[0-9]+')

    javaToolcacheVersionPath=$JAVA_TOOLCACHE_PATH/$fullVersion
    javaToolcacheVersionArchPath=$javaToolcacheVersionPath/x64

    download_with_retries $archivePath /tmp OpenJDK${JAVA_VERSION}.tar.gz
    mkdir -p $javaToolcacheVersionArchPath
    tar -xzf /tmp/OpenJDK${JAVA_VERSION}.tar.gz -C $javaToolcacheVersionArchPath --strip-components=1

    createEnvironmentVariable $JAVA_VERSION $javaToolcacheVersionArchPath
    ln -sf $javaToolcacheVersionArchPath /Library/Java/JavaVirtualMachines/adoptopenjdk-${JAVA_VERSION}.jdk
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
