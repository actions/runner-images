#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Enabling safari driver..."
# https://developer.apple.com/documentation/webkit/testing_with_webdriver_in_safari
# Safari’s executable is located at /usr/bin/safaridriver
# Configure Safari to Enable WebDriver Support
sudo safaridriver --enable

echo "Enabling developer mode..."
sudo /usr/sbin/DevToolsSecurity --enable

# Turn off hibernation and get rid of the sleepimage
sudo pmset hibernatemode 0
sudo rm -f /var/vm/sleepimage

# Disable App Nap System Wide
defaults write NSGlobalDomain NSAppSleepDisabled -bool YES

# Change screen resolution to the maximum supported for 4Mb video memory
sudo "/Library/Application Support/VMware Tools/vmware-resolutionSet" 1176 885

# https://developer.apple.com/support/expiration/
# Enterprise iOS Distribution Certificates generated between February 7 and September 1st, 2020 will expire on February 7, 2023.
# Rotate the certificate before expiration to ensure your apps are installed and signed with an active certificate.
# Confirm that the correct intermediate certificate is installed by verifying the expiration date is set to 2030.
# sudo security delete-certificate -Z FF6797793A3CD798DC5B2ABEF56F73EDC9F83A64 /Library/Keychains/System.keychain
curl https://www.apple.com/certificateauthority/AppleWWDRCAG3.cer --output $HOME/AppleWWDRCAG3.cer --silent
# Big Sur requires user interaction to add a cert https://developer.apple.com/forums/thread/671582, we need to use a workaround with SecItemAdd swift method
if is_Less_BigSur; then
    sudo security add-trusted-cert -d -r unspecified -k /Library/Keychains/System.keychain $HOME/AppleWWDRCAG3.cer
else
    swiftc $HOME/image-generation/add-certificate.swift
    sudo ./add-certificate $HOME/AppleWWDRCAG3.cer
    rm add-certificate
fi
rm $HOME/AppleWWDRCAG3.cer

# Create symlink for tests running
if [ ! -d "/usr/local/bin" ];then
    sudo mkdir -p -m 775 /usr/local/bin
    sudo chown $USER:admin /usr/local/bin
fi
chmod +x $HOME/utils/invoke-tests.sh
sudo ln -s $HOME/utils/invoke-tests.sh /usr/local/bin/invoke_tests
