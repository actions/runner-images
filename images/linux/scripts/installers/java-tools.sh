#!/bin/bash -e
################################################################################
##  File:  java-tools.sh
##  Desc:  Installs Java and related tooling (Ant, Gradle, Maven)
################################################################################
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/os.sh
source $HELPER_SCRIPTS/etc-environment.sh

JAVA_TOOLCACHE_PATH="$AGENT_TOOLSDIRECTORY/Java_Adopt_jdk"

createEnvironmentVariable() {
    local JAVA_VERSION=$1
    local JAVA_HOME_PATH=$2

    if [[ $JAVA_VERSION == $JAVA_DEFAULT ]]; then
        echo "JAVA_HOME=${JAVA_HOME_PATH}" | tee -a /etc/environment

        update-alternatives --install "/usr/bin/java" "java" "$JAVA_HOME_PATH/bin/java" 1
        update-alternatives --set java "$JAVA_HOME_PATH/bin/java"
        
        update-alternatives --install "/usr/bin/javac" "javac" "$JAVA_HOME_PATH/bin/javac" 1
        update-alternatives --set javac "$JAVA_HOME_PATH/bin/javac"
    fi

    echo "JAVA_HOME_${JAVA_VERSION}_X64=${JAVA_HOME_PATH}" | tee -a /etc/environment
}

installJavaFromAdoptOpenJDK() {
    local JAVA_VERSION=$1

    javaRelease=$(curl -s "https://api.adoptopenjdk.net/v3/assets/latest/${JAVA_VERSION}/hotspot" \
                | jq -r '.[] | select(.binary.os=="linux" and .binary.image_type=="jdk" and .binary.architecture=="x64")')
    archivePath=$(echo $javaRelease | jq -r '.binary.package.link')
    fullVersion=$(echo $javaRelease | jq -r '.version.semver')

    javaToolcacheVersionPath="$JAVA_TOOLCACHE_PATH/$fullVersion"
    javaToolcacheVersionArchPath="$javaToolcacheVersionPath/x64"

    echo "Downloading tar archive $archivePath"
    download_with_retries $archivePath "/tmp" "OpenJDK$JAVA_VERSION.tar.gz"
    mkdir -p "$javaToolcacheVersionArchPath"
    tar -xzf "/tmp/OpenJDK${JAVA_VERSION}.tar.gz" -C $javaToolcacheVersionArchPath --strip-components=1

    # Create a complete file
    touch $javaToolcacheVersionPath/x64.complete

    createEnvironmentVariable $JAVA_VERSION $javaToolcacheVersionArchPath
}

JAVA_VERSIONS_LIST=$(get_toolset_value '.java.versions[]')
JAVA_DEFAULT=$(get_toolset_value '.java.default')

for JAVA_VERSION in $JAVA_VERSIONS_LIST
do
    installJavaFromAdoptOpenJDK $JAVA_VERSION
done

# Install Ant
apt-fast install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Install Maven
curl -sL https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -o maven.zip
unzip -d /usr/share maven.zip
rm maven.zip
ln -s /usr/share/apache-maven-3.6.3/bin/mvn /usr/bin/mvn

# Install Gradle
# This script downloads the latest HTML list of releases at https://gradle.org/releases/.
# Then, it extracts the top-most release download URL, relying on the top-most URL being for the latest release.
# The release download URL looks like this: https://services.gradle.org/distributions/gradle-5.2.1-bin.zip
# The release version is extracted from the download URL (i.e. 5.2.1).
# After all of this, the release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
wget -O gradleReleases.html https://gradle.org/releases/
gradleUrl=$(grep -m 1 -o "https:\/\/services.gradle.org\/distributions\/gradle-.*-bin\.zip" gradleReleases.html | head -1)
gradleVersion=$(echo $gradleUrl | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')
rm gradleReleases.html
echo "gradleUrl=$gradleUrl"
echo "gradleVersion=$gradleVersion"
curl -sL $gradleUrl -o gradleLatest.zip
unzip -d /usr/share gradleLatest.zip
rm gradleLatest.zip
ln -s /usr/share/gradle-"${gradleVersion}"/bin/gradle /usr/bin/gradle
echo "GRADLE_HOME=/usr/share/gradle" | tee -a /etc/environment

reloadEtcEnvironment

invoke_tests "Java"