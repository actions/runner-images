#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

JAVA_TOOLCACHE_PATH=$AGENT_TOOLSDIRECTORY/Java_Adoptium_jdk

installJavaFromAdoptOpenJDK() {
    local JAVA_VERSION=$1

    javaRelease=$(curl -s "https://api.adoptopenjdk.net/v3/assets/latest/$JAVA_VERSION/hotspot")
    archivePath=$(echo $javaRelease | jq -r '[.[] | select(.binary.os=="mac") | .binary.package.link][0]')
    fullVersion=$(echo $javaRelease | jq -r '[.[] | select(.binary.os=="mac") | .version.openjdk_version][0]')
    javaToolcacheVersionPath=$JAVA_TOOLCACHE_PATH/$fullVersion
    javaToolcacheVersionArchPath=$javaToolcacheVersionPath/x64

    download_with_retries $archivePath /tmp OpenJDK$JAVA_VERSION.tar.gz
    mkdir /tmp/jdk-$fullVersion && tar -xzf /tmp/OpenJDK$JAVA_VERSION.tar.gz -C /tmp/jdk-$fullVersion
    mkdir -p $javaToolcacheVersionArchPath && mv /tmp/jdk-$fullVersion/*/* $javaToolcacheVersionArchPath

    local JAVA_HOME_PATH=$javaToolcacheVersionArchPath/Contents/Home
    if [[ $JAVA_VERSION == $JAVA_DEFAULT ]]; then
        echo "export JAVA_HOME=${JAVA_HOME_PATH}" >> "${HOME}/.bashrc"
        export PATH="$JAVA_HOME_PATH:$PATH"
    fi
    echo "export JAVA_HOME_${JAVA_VERSION}_X64=${JAVA_HOME_PATH}" >> "${HOME}/.bashrc"
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
