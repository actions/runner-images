#!/bin/bash -e
################################################################################
##  File:  java-tools.sh
##  Desc:  Installs Java and related tooling (Ant, Gradle, Maven)
################################################################################

source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/etc-environment.sh

JAVA_VERSIONS_LIST=$(get_toolset_value '.java.versions | .[]')
DEFAULT_JDK_VERSION=$(get_toolset_value '.java.default')
JAVA_TOOLCACHE_PATH="$AGENT_TOOLSDIRECTORY/Java_Adopt_jdk"

# Install GPG Key for Eclipse Temurin JDK. See https://blog.adoptium.net/2021/12/eclipse-temurin-linux-installers-available/
wget -qO - "https://packages.adoptium.net/artifactory/api/gpg/key/public" | apt-key add -
add-apt-repository --yes https://packages.adoptium.net/artifactory/deb/

apt-get update

for JAVA_VERSION in ${JAVA_VERSIONS_LIST[@]}; do
    apt-get -y install temurin-$JAVA_VERSION-jdk=\*
    javaVersionPath="/usr/lib/jvm/temurin-${JAVA_VERSION}-jdk-amd64"
    echo "JAVA_HOME_${JAVA_VERSION}_X64=$javaVersionPath" | tee -a /etc/environment
    fullJavaVersion=$(cat "$javaVersionPath/release" | grep "^SEMANTIC" | cut -d "=" -f 2 | tr -d "\"" | tr "+" "-")

    # If there is no semver in java release, then extract java version from -fullversion
    if [[ -z $fullJavaVersion ]]; then
        fullJavaVersion=$(java -fullversion 2>&1 | tr -d "\"" | tr "+" "-" | awk '{print $4}')
    fi

    javaToolcacheVersionPath="$JAVA_TOOLCACHE_PATH/$fullJavaVersion"
    mkdir -p "$javaToolcacheVersionPath"

    # Create a complete file
    touch "$javaToolcacheVersionPath/x64.complete"

    # Create symlink for Java
    ln -s $javaVersionPath "$javaToolcacheVersionPath/x64"
done

# Set Default Java version
update-java-alternatives -s /usr/lib/jvm/temurin-${DEFAULT_JDK_VERSION}-jdk-amd64

echo "JAVA_HOME=/usr/lib/jvm/temurin-${DEFAULT_JDK_VERSION}-jdk-amd64" | tee -a /etc/environment

# add extra permissions to be able execute command without sudo
chmod -R 777 /usr/lib/jvm
# Install Ant
apt-get install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Install Maven
mavenVersion=$(get_toolset_value '.java.maven')
mavenDownloadUrl="https://www-eu.apache.org/dist/maven/maven-3/${mavenVersion}/binaries/apache-maven-${mavenVersion}-bin.zip"
download_with_retries ${mavenDownloadUrl} "/tmp" "maven.zip"
unzip -qq -d /usr/share /tmp/maven.zip
ln -s /usr/share/apache-maven-${mavenVersion}/bin/mvn /usr/bin/mvn

# Install Gradle
# This script founds the latest gradle release from https://services.gradle.org/versions/all
# The release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
gradleJson=$(curl -s https://services.gradle.org/versions/all)
gradleLatestVersion=$(echo $gradleJson | jq -r '.[] | select(.version | contains("-") | not).version' | sort -V | tail -n1)
gradleDownloadUrl=$(echo $gradleJson | jq -r ".[] | select(.version==\"$gradleLatestVersion\") | .downloadUrl")
echo "gradleUrl=$gradleDownloadUrl"
echo "gradleVersion=$gradleLatestVersion"
download_with_retries $gradleDownloadUrl "/tmp" "gradleLatest.zip"
unzip -qq -d /usr/share /tmp/gradleLatest.zip
ln -s /usr/share/gradle-"${gradleLatestVersion}"/bin/gradle /usr/bin/gradle
echo "GRADLE_HOME=$(find /usr/share -depth -maxdepth 1 -name "gradle*")" | tee -a /etc/environment

reloadEtcEnvironment
invoke_tests "Java"
