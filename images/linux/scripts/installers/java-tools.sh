#!/bin/bash
################################################################################
##  File:  java-tools.sh
##  Desc:  Installs Java and related tooling (Ant, Gradle, Maven)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/document.sh

DEFAULT_JDK_VERSION=8

set -e

# Install the Azul Systems Zulu JDKs
# See https://www.azul.com/downloads/azure-only/zulu/
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
apt-add-repository "deb http://repos.azul.com/azure-only/zulu/apt stable main"
apt-get -q update
apt-get -y install zulu-7-azure-jdk=\*
apt-get -y install zulu-8-azure-jdk=\*
apt-get -y install zulu-11-azure-jdk=\*
apt-get -y install zulu-12-azure-jdk=\*
update-java-alternatives -s /usr/lib/jvm/zulu-8-azure-amd64
echo "JAVA_HOME_7_X64=/usr/lib/jvm/zulu-7-azure-amd64" | tee -a /etc/environment
echo "JAVA_HOME_8_X64=/usr/lib/jvm/zulu-8-azure-amd64" | tee -a /etc/environment
echo "JAVA_HOME_11_X64=/usr/lib/jvm/zulu-11-azure-amd64" | tee -a /etc/environment
echo "JAVA_HOME_12_X64=/usr/lib/jvm/zulu-12-azure-amd64" | tee -a /etc/environment
echo "JAVA_HOME=/usr/lib/jvm/zulu-${DEFAULT_JDK_VERSION}-azure-amd64" | tee -a /etc/environment
echo "JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF8" | tee -a /etc/environment

# Install Ant
apt-fast install -y --no-install-recommends ant ant-optional
echo "ANT_HOME=/usr/share/ant" | tee -a /etc/environment

# Install Maven
curl -sL https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip -o maven.zip
unzip -d /usr/share maven.zip
rm maven.zip
ln -s /usr/share/apache-maven-3.6.3/bin/mvn /usr/bin/mvn
echo "M2_HOME=/usr/share/apache-maven-3.6.3" | tee -a /etc/environment

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

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
for cmd in gradle java javac mvn ant; do
    if ! command -v $cmd; then
        echo "$cmd was not installed or found on path"
        exit 1
    fi
done

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "Azul Zulu OpenJDK (7) ($(/usr/lib/jvm/zulu-7-azure-amd64/bin/java -showversion |& head -n 1))"
DocumentInstalledItem "Azul Zulu OpenJDK (8) ($(/usr/lib/jvm/zulu-8-azure-amd64/bin/java -showversion |& head -n 1))"
DocumentInstalledItem "Azul Zulu OpenJDK (11) ($(/usr/lib/jvm/zulu-11-azure-amd64/bin/java -showversion |& head -n 1))"
DocumentInstalledItem "Azul Zulu OpenJDK (12) ($(/usr/lib/jvm/zulu-12-azure-amd64/bin/java -showversion |& head -n 1))"
DocumentInstalledItem "Ant ($(ant -version))"
DocumentInstalledItem "Gradle ${gradleVersion}"
DocumentInstalledItem "Maven ($(mvn -version | head -n 1))"
