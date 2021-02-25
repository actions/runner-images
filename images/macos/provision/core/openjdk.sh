#!/bin/bash -e -o pipefail
source ~/utils/utils.sh

createEnvironmentVariable() {
    local VARIABLE_NAME=$1
    local JAVA_VERSION=$2
    if [[ $JAVA_VERSION == "8" ]]; then
        JAVA_VERSION="1.${JAVA_VERSION}"
    fi
    local JAVA_PATH=$(/usr/libexec/java_home -v${JAVA_VERSION})
    echo "export ${VARIABLE_NAME}=${JAVA_PATH}" >> "${HOME}/.bashrc"
}

brew tap AdoptOpenJDK/openjdk

JAVA_VERSIONS_LIST=($(get_toolset_value '.java.versions | .[]'))
JAVA_DEFAULT=$(get_toolset_value '.java.default')
for JAVA_VERSION in "${JAVA_VERSIONS_LIST[@]}"
do
    brew install --cask "adoptopenjdk${JAVA_VERSION}"
    createEnvironmentVariable "JAVA_HOME_${JAVA_VERSION}_X64" $JAVA_VERSION
done

createEnvironmentVariable "JAVA_HOME" $JAVA_DEFAULT

echo Installing Maven...
brew_smart_install "maven"

echo Installing Gradle ...
brew_smart_install "gradle"

invoke_tests "Java"
