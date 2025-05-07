#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-mono.sh
##  Desc:  Install Mono Framework
################################################################################

source ~/utils/utils.sh

# Install Mono Framework
mono_version_full=$(get_toolset_value '.mono.framework.version')
mono_pkg_sha256=$(get_toolset_value '.mono.framework.sha256')
mono_version=$(echo $mono_version_full | cut -d. -f 1,2,3)
mono_version_short=$(echo $mono_version_full | cut -d. -f 1,2)
mono_pkg_url="https://download.mono-project.com/archive/${mono_version}/macos-10-universal/MonoFramework-MDK-${mono_version_full}.macos10.xamarin.universal.pkg"
MONO_VERSIONS_PATH='/Library/Frameworks/Mono.framework/Versions'

mono_pkg_path=$(download_with_retry $mono_pkg_url)
use_checksum_comparison $mono_pkg_path $mono_pkg_sha256
echo "Installing Mono Framework ${mono_version_full}..."
sudo installer -pkg $mono_pkg_path -target /

# Download and install NUnit console
nunit_version=$(get_toolset_value '.mono.nunit.version')
nunit_archive_url="https://github.com/nunit/nunit-console/releases/download/${nunit_version}/NUnit.Console-${nunit_version}.zip"
nunit_archive_sha256=$(get_toolset_value '.mono.nunit.sha256')
NUNIT_PATH="/Library/Developer/nunit"
nunit_version_path=$NUNIT_PATH/$nunit_version

nunit_archive_path=$(download_with_retry $nunit_archive_url)
use_checksum_comparison $nunit_archive_path $nunit_archive_sha256
echo "Installing NUnit ${nunit_version}..."
sudo mkdir -p $nunit_version_path
sudo unzip -q $nunit_archive_path -d $nunit_version_path

# Create a wrapper script for nunit3-console
echo "Creating nunit3-console wrapper..."
nunit3_console_wrapper=$(mktemp)
cat <<EOF > "$nunit3_console_wrapper"
#!/bin/bash -e -o pipefail
exec ${MONO_VERSIONS_PATH}/${mono_version}/bin/mono --debug \$MONO_OPTIONS $nunit_version_path/nunit3-console.exe "\$@"
EOF
cat $nunit3_console_wrapper
sudo chmod +x $nunit3_console_wrapper
sudo mv $nunit3_console_wrapper "${MONO_VERSIONS_PATH}/${mono_version}/Commands/nunit3-console"

# Create a symlink for the short version of Mono (e.g., 6.12)
echo "Creating short symlink '${mono_version_short}'..."
sudo ln -s ${MONO_VERSIONS_PATH}/${mono_version} ${MONO_VERSIONS_PATH}/${mono_version_short}

# Invoke tests and Mono
invoke_tests "Mono"
