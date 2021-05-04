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

# Install GPG Key for Adopt Open JDK. See https://adoptopenjdk.net/installation.html
wget -qO - "https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public" | apt-key add -
add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

if isUbuntu16 || isUbuntu18 ; then
    # Install GPG Key for Azul Open JDK. See https://www.azul.com/downloads/azure-only/zulu/
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
    apt-add-repository "deb https://repos.azul.com/azure-only/zulu/apt stable main"
fi

apt-get update

for JAVA_VERSION in ${JAVA_VERSIONS_LIST[@]}; do
    apt-get -y install adoptopenjdk-$JAVA_VERSION-hotspot=\*
    javaVersionPath="/usr/lib/jvm/adoptopenjdk-${JAVA_VERSION}-hotspot-amd64"
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
if isUbuntu16; then
    # issue: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=825987
    # stackoverflow: https://askubuntu.com/questions/1187136/update-java-alternatives-only-java-but-not-javac-is-changed
    sed -i 's/(hl|jre|jdk|plugin|DUMMY) /(hl|jre|jdk|jdkhl|plugin|DUMMY) /g' /usr/sbin/update-java-alternatives
fi

update-java-alternatives -s /usr/lib/jvm/adoptopenjdk-${DEFAULT_JDK_VERSION}-hotspot-amd64

echo "JAVA_HOME=/usr/lib/jvm/adoptopenjdk-${DEFAULT_JDK_VERSION}-hotspot-amd64" | tee -a /etc/environment

# add extra permissions to be able execute command without sudo
chmod -R 777 /usr/lib/jvm
# Install Ant
apt-fast install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Install Maven
curl -sL https://www-eu.apache.org/dist/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip -o maven.zip
unzip -qq -d /usr/share maven.zip
rm maven.zip
ln -s /usr/share/apache-maven-3.8.1/bin/mvn /usr/bin/mvn

# Install Gradle
# This script downloads the latest HTML list of releases at https://gradle.org/releases/.
# Then, it extracts the top-most release download URL, relying on the top-most URL being for the latest release.
# The release download URL looks like this: https://services.gradle.org/distributions/gradle-5.2.1-bin.zip
# The release version is extracted from the download URL (i.e. 5.2.1).
# After all of this, the release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
wget -qO gradleReleases.html https://gradle.org/releases/
gradleUrl=$(grep -m 1 -o "https:\/\/services.gradle.org\/distributions\/gradle-.*-bin\.zip" gradleReleases.html | head -1)
gradleVersion=$(echo $gradleUrl | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')
rm gradleReleases.html
echo "gradleUrl=$gradleUrl"
echo "gradleVersion=$gradleVersion"
curl -sL $gradleUrl -o gradleLatest.zip
unzip -qq -d /usr/share gradleLatest.zip
rm gradleLatest.zip
ln -s /usr/share/gradle-"${gradleVersion}"/bin/gradle /usr/bin/gradle
echo "GRADLE_HOME=$(find /usr/share -depth -maxdepth 1 -name "gradle*")" | tee -a /etc/environment

reloadEtcEnvironment
invoke_tests "Java"
