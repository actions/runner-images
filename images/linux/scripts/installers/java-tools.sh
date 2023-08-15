#!/bin/bash -e
################################################################################
##  File:  java-tools.sh
##  Desc:  Installs Java and related tooling (Ant, Gradle, Maven)
################################################################################

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/etc-environment.sh

createJavaEnvironmentalVariable() {
    local JAVA_VERSION=$1
    local DEFAULT=$2

    local INSTALL_PATH_PATTERN="/usr/lib/jvm/temurin-${JAVA_VERSION}-jdk-amd64"

    if [[ ${DEFAULT} == "True" ]]; then
        echo "Setting up JAVA_HOME variable to ${INSTALL_PATH_PATTERN}"
        addEtcEnvironmentVariable JAVA_HOME ${INSTALL_PATH_PATTERN}
        echo "Setting up default symlink"
        update-java-alternatives -s ${INSTALL_PATH_PATTERN}
    fi

    echo "Setting up JAVA_HOME_${JAVA_VERSION}_X64 variable to ${INSTALL_PATH_PATTERN}"
    addEtcEnvironmentVariable JAVA_HOME_${JAVA_VERSION}_X64 ${INSTALL_PATH_PATTERN}
}

enableRepositories() {
    osLabel=$(getOSVersionLabel)

    # Add Addoptium PPA
    # apt-key is deprecated, dearmor and add manually
    wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor > /usr/share/keyrings/adoptium.gpg
    echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb/ $osLabel main" > /etc/apt/sources.list.d/adoptium.list

}

installOpenJDK() {
    local JAVA_VERSION=$1

    # Install Java from PPA repositories.
    apt-get -y install temurin-${JAVA_VERSION}-jdk=\*
    javaVersionPath="/usr/lib/jvm/temurin-${JAVA_VERSION}-jdk-amd64"

    JAVA_TOOLCACHE_PATH="${AGENT_TOOLSDIRECTORY}/Java_Temurin-Hotspot_jdk"

    fullJavaVersion=$(cat "${javaVersionPath}/release" | grep "^SEMANTIC" | cut -d "=" -f 2 | tr -d "\"" | tr "+" "-")

    # If there is no semver in java release, then extract java version from -fullversion
    [[ -z ${fullJavaVersion} ]] && fullJavaVersion=$(${javaVersionPath}/bin/java -fullversion 2>&1 | tr -d "\"" | tr "+" "-" | awk '{print $4}')

    # Convert non valid semver like 11.0.14.1-9 -> 11.0.14-9
    # https://github.com/adoptium/temurin-build/issues/2248
    [[ ${fullJavaVersion} =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]] && fullJavaVersion=$(echo $fullJavaVersion | sed -E 's/\.[0-9]+-/-/')

    javaToolcacheVersionPath="${JAVA_TOOLCACHE_PATH}/${fullJavaVersion}"
    mkdir -p "${javaToolcacheVersionPath}"

    # Create a complete file
    touch "${javaToolcacheVersionPath}/x64.complete"

    # Create symlink for Java
    ln -s ${javaVersionPath} "${javaToolcacheVersionPath}/x64"

    # add extra permissions to be able execute command without sudo
    chmod -R 777 /usr/lib/jvm
}

# Fetch repositories data
enableRepositories

# Get all the updates from enabled repositories.
apt-get update

defaultVersion=$(get_toolset_value '.java.default')
jdkVersionsToInstall=($(get_toolset_value ".java.versions[]"))

for jdkVersionToInstall in ${jdkVersionsToInstall[@]}; do
    installOpenJDK ${jdkVersionToInstall}

    if [[ ${jdkVersionToInstall} == ${defaultVersion} ]]
    then
        createJavaEnvironmentalVariable ${jdkVersionToInstall} True
    else
        createJavaEnvironmentalVariable ${jdkVersionToInstall} False
    fi
done

# Install Ant
apt-get install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Install Maven
mavenVersion=$(get_toolset_value '.java.maven')
mavenDownloadUrl="https://dlcdn.apache.org/maven/maven-3/${mavenVersion}/binaries/apache-maven-${mavenVersion}-bin.zip"
download_with_retries ${mavenDownloadUrl} "/tmp" "maven.zip"
unzip -qq -d /usr/share /tmp/maven.zip
ln -s /usr/share/apache-maven-${mavenVersion}/bin/mvn /usr/bin/mvn

# Install Gradle
# This script founds the latest gradle release from https://services.gradle.org/versions/all
# The release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
gradleJson=$(curl -fsSL https://services.gradle.org/versions/all)
gradleLatestVersion=$(echo ${gradleJson} | jq -r '.[] | select(.version | contains("-") | not).version' | sort -V | tail -n1)
gradleDownloadUrl=$(echo ${gradleJson} | jq -r ".[] | select(.version==\"$gradleLatestVersion\") | .downloadUrl")
echo "gradleUrl=${gradleDownloadUrl}"
echo "gradleVersion=${gradleLatestVersion}"
download_with_retries ${gradleDownloadUrl} "/tmp" "gradleLatest.zip"
unzip -qq -d /usr/share /tmp/gradleLatest.zip
ln -s /usr/share/gradle-"${gradleLatestVersion}"/bin/gradle /usr/bin/gradle
echo "GRADLE_HOME=$(find /usr/share -depth -maxdepth 1 -name "gradle*")" | tee -a /etc/environment

# Delete java repositories and keys
rm -f /etc/apt/sources.list.d/adoptium.list
rm -f /etc/apt/sources.list.d/zulu.list
rm -f /usr/share/keyrings/adoptium.gpg
rm -f /usr/share/keyrings/zulu.gpg

reloadEtcEnvironment
invoke_tests "Java"
