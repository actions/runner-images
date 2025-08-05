#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-chrome.sh
##  Desc:  Install chrome and chrome for testing browsers
################################################################################

source ~/utils/utils.sh
arch=$(get_arch)

echo "Installing Google Chrome..."
brew install --cask google-chrome

# Parse Google Chrome version
full_chrome_version=$("/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --version)
full_chrome_version=${full_chrome_version#Google Chrome }
chrome_version=${full_chrome_version%.*}
echo "Google Chrome version is $full_chrome_version"

# Get Google Chrome versions information
chrome_platform="mac-$arch"
CHROME_VERSIONS_URL="https://googlechromelabs.github.io/chrome-for-testing/latest-patch-versions-per-build-with-downloads.json"
chrome_versions_json=$(download_with_retry "$CHROME_VERSIONS_URL")

# Download and unpack the latest release of Chrome Driver
chromedriver_version=$(cat $chrome_versions_json | jq -r '.builds["'"$chrome_version"'"].version')
echo "Installing Chrome Driver version $chromedriver_version"

chromedriver_url=$(cat $chrome_versions_json | jq -r '.builds["'"$chrome_version"'"].downloads.chromedriver[] | select(.platform=="'"${chrome_platform}"'").url')
chromedriver_dir="/usr/local/share/chromedriver-$chrome_platform"
chromedriver_bin="$chromedriver_dir/chromedriver"

chromedriver_archive_path=$(download_with_retry $chromedriver_url)
unzip -qq $chromedriver_archive_path -d /tmp/
sudo mv /tmp/chromedriver-$chrome_platform $chromedriver_dir
ln -s $chromedriver_bin /usr/local/bin/chromedriver
echo "export CHROMEWEBDRIVER=$chromedriver_dir" >> ${HOME}/.bashrc

# Download and unpack the latest release of Google Chrome for Testing
chrome_for_testing_version=$(cat $chrome_versions_json | jq -r '.builds["'"$chrome_version"'"].version')
echo "Installing Google Chrome for Testing version $chrome_for_testing_version"

chrome_for_testing_url=$(cat $chrome_versions_json | jq -r '.builds["'"$chrome_version"'"].downloads.chrome[] | select(.platform=="'"${chrome_platform}"'").url')
chrome_for_testing_app="Google Chrome for Testing.app"

chrome_for_testing_archive_path=$(download_with_retry $chrome_for_testing_url)
unzip -qq $chrome_for_testing_archive_path -d /tmp/
mv "/tmp/chrome-$chrome_platform/$chrome_for_testing_app" "/Applications/$chrome_for_testing_app"

echo "Installing Selenium"
brew_smart_install "selenium-server"

invoke_tests "Browsers" "Chrome"
