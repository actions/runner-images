#!/bin/bash -e
################################################################################
##  File:  install-java-tools.sh
##  Desc:  Install Java and related tooling (Ant, Gradle, Maven)
################################################################################

# Source the helpers for use with the script
source $HELPER_SCRIPTS/install.sh
source $HELPER_SCRIPTS/etc-environment.sh

create_java_environment_variable() {
    local java_version=$1
    local default=$2

    local install_path_pattern="/usr/lib/jvm/temurin-${java_version}-jdk-amd64"

    if [[ ${default} == "True" ]]; then
        echo "Setting up JAVA_HOME variable to ${install_path_pattern}"
        set_etc_environment_variable "JAVA_HOME" "${install_path_pattern}"
        echo "Setting up default symlink"
        update-java-alternatives -s ${install_path_pattern}
    fi

    echo "Setting up JAVA_HOME_${java_version}_X64 variable to ${install_path_pattern}"
    set_etc_environment_variable "JAVA_HOME_${java_version}_X64" "${install_path_pattern}"
}

install_open_jdk() {
    local java_version=$1

    # Install Java from PPA repositories.
    apt-get -y install temurin-${java_version}-jdk=\*
    java_version_path="/usr/lib/jvm/temurin-${java_version}-jdk-amd64"

    java_toolcache_path="${AGENT_TOOLSDIRECTORY}/Java_Temurin-Hotspot_jdk"

    full_java_version=$(cat "${java_version_path}/release" | grep "^SEMANTIC" | cut -d "=" -f 2 | tr -d "\"" | tr "+" "-")

    # If there is no semver in java release, then extract java version from -fullversion
    [[ -z ${full_java_version} ]] && full_java_version=$(${java_version_path}/bin/java -fullversion 2>&1 | tr -d "\"" | tr "+" "-" | awk '{print $4}')

    # Convert non valid semver like 11.0.14.1-9 -> 11.0.14-9
    # https://github.com/adoptium/temurin-build/issues/2248
    [[ ${full_java_version} =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+ ]] && full_java_version=$(echo $full_java_version | sed -E 's/\.[0-9]+-/-/')

    # When version string is too short, add extra ".0" to make it valid semver
    [[ ${full_java_version} =~ ^[0-9]+- ]] && full_java_version=$(echo $full_java_version | sed -E 's/-/.0-/')
    [[ ${full_java_version} =~ ^[0-9]+\.[0-9]+- ]] && full_java_version=$(echo $full_java_version | sed -E 's/-/.0-/')

    java_toolcache_version_path="${java_toolcache_path}/${full_java_version}"
    echo "Java ${java_version} Toolcache Version Path: ${java_toolcache_version_path}"
    mkdir -p "${java_toolcache_version_path}"

    # Create a complete file
    touch "${java_toolcache_version_path}/x64.complete"

    # Create symlink for Java
    ln -s ${java_version_path} "${java_toolcache_version_path}/x64"

    # add extra permissions to be able execute command without sudo
    chmod -R 777 /usr/lib/jvm
}

# Add Adoptium PPA
# apt-key is deprecated, dearmor and add manually
wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor > /usr/share/keyrings/adoptium.gpg
echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/adoptium.list

# Get all the updates from enabled repositories.
apt-get update

# While Ubuntu 24.04 binaries are not released in the Adoptium repo, we will not install Java
defaultVersion=$(get_toolset_value '.java.default')
jdkVersionsToInstall=($(get_toolset_value ".java.versions[]"))

for jdkVersionToInstall in ${jdkVersionsToInstall[@]}; do
    install_open_jdk ${jdkVersionToInstall}

    if [[ ${jdkVersionToInstall} == ${defaultVersion} ]]
    then
        create_java_environment_variable ${jdkVersionToInstall} True
    else
        create_java_environment_variable ${jdkVersionToInstall} False
    fi
done

# Install Ant
apt-get install -y --no-install-recommends ant ant-optional
set_etc_environment_variable "ANT_HOME" "/usr/share/ant"

# Install Maven
mavenVersion=$(get_toolset_value '.java.maven')
mavenDownloadUrl="https://dlcdn.apache.org/maven/maven-3/${mavenVersion}/binaries/apache-maven-${mavenVersion}-bin.zip"
maven_archive_path=$(download_with_retry "$mavenDownloadUrl")
unzip -qq -d /usr/share "$maven_archive_path"
ln -s /usr/share/apache-maven-${mavenVersion}/bin/mvn /usr/bin/mvn

# Install Gradle
# This script founds the latest gradle release from https://services.gradle.org/versions/all
# The release is downloaded, extracted, a symlink is created that points to it, and GRADLE_HOME is set.
gradleJson=$(curl -fsSL https://services.gradle.org/versions/all)
gradleLatestVersion=$(echo ${gradleJson} | jq -r '.[] | select(.version | contains("-") | not).version' | sort -V | tail -n1)
gradleDownloadUrl=$(echo ${gradleJson} | jq -r ".[] | select(.version==\"$gradleLatestVersion\") | .downloadUrl")
echo "gradleUrl=${gradleDownloadUrl}"
echo "gradleVersion=${gradleLatestVersion}"
gradle_archive_path=$(download_with_retry "$gradleDownloadUrl")
unzip -qq -d /usr/share "$gradle_archive_path"
ln -s /usr/share/gradle-"${gradleLatestVersion}"/bin/gradle /usr/bin/gradle
gradle_home_dir=$(find /usr/share -depth -maxdepth 1 -name "gradle*")
set_etc_environment_variable "GRADLE_HOME" "${gradle_home_dir}"

# Delete java repositories and keys
rm -f /etc/apt/sources.list.d/adoptium.list
rm -f /etc/apt/sources.list.d/zulu.list
rm -f /usr/share/keyrings/adoptium.gpg
rm -f /usr/share/keyrings/zulu.gpg

reload_etc_environment
invoke_tests "Java"
