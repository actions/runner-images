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
    echo "JAVA_HOME_${JAVA_VERSION}_X64=/usr/lib/jvm/adoptopenjdk-${JAVA_VERSION}-hotspot-amd64" | tee -a /etc/environment
done

# Set Default Java version.
if isUbuntu16; then
    # issue: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=825987
    # stackoverflow: https://askubuntu.com/questions/1187136/update-java-alternatives-only-java-but-not-javac-is-changed
    sed -i 's/(hl|jre|jdk|plugin|DUMMY) /(hl|jre|jdk|jdkhl|plugin|DUMMY) /g' /usr/sbin/update-java-alternatives
fi
update-java-alternatives -s /usr/lib/jvm/adoptopenjdk-${DEFAULT_JDK_VERSION}-hotspot-amd64

echo "JAVA_HOME=/usr/lib/jvm/adoptopenjdk-${DEFAULT_JDK_VERSION}-hotspot-amd64" | tee -a /etc/environment

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
