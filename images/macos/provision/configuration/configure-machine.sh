#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

echo "Enabling developer mode..."
sudo /usr/sbin/DevToolsSecurity --enable

# Turn off hibernation and get rid of the sleepimage
sudo pmset hibernatemode 0
sudo rm -f /var/vm/sleepimage

# Disable App Nap System Wide
defaults write NSGlobalDomain NSAppSleepDisabled -bool YES

# Disable Keyboard Setup Assistant window
if is_Veertu; then
    sudo defaults write /Library/Preferences/com.apple.keyboardtype "keyboardtype" -dict-add "3-7582-0" -int 40
fi

# Change screen resolution to the maximum supported for 4Mb video memory
if [ -d "/Library/Application Support/VMware Tools" ]; then
    sudo "/Library/Application Support/VMware Tools/vmware-resolutionSet" 1176 885
fi

# Update VoiceOver Utility to allow VoiceOver to be controlled with AppleScript
# by creating a special Accessibility DB file (SIP must be disabled) and
# updating the user defaults system to reflect this change.
if csrutil status | grep -Eq  "System Integrity Protection status: (disabled|unknown)"; then
    sudo bash -c 'echo -n "a" > /private/var/db/Accessibility/.VoiceOverAppleScriptEnabled'
fi
defaults write com.apple.VoiceOver4/default SCREnableAppleScript -bool YES

# https://developer.apple.com/support/expiration/
# Enterprise iOS Distribution Certificates generated between February 7 and September 1st, 2020 will expire on February 7, 2023.
# Rotate the certificate before expiration to ensure your apps are installed and signed with an active certificate.
# Confirm that the correct intermediate certificate is installed by verifying the expiration date is set to 2030.
# sudo security delete-certificate -Z FF6797793A3CD798DC5B2ABEF56F73EDC9F83A64 /Library/Keychains/System.keychain
# Big Sur requires user interaction to add a cert https://developer.apple.com/forums/thread/671582, we need to use a workaround with SecItemAdd swift method

swiftc "${HOME}/image-generation/add-certificate.swift"


certs=(
    AppleWWDRCAG3.cer
    DeveloperIDG2CA.cer
)
for cert in ${certs[@]}; do
    echo "Adding ${cert} certificate"
    cert_path="${HOME}/${cert}"
    curl "https://www.apple.com/certificateauthority/${cert}" --output ${cert_path} --silent

    sudo ./add-certificate ${cert_path}

    rm ${cert_path}
done

rm -f ./add-certificate

# enable-automationmode-without-authentication
if is_Monterey; then
retry=10
while [ $retry -gt 0 ]; do
{
osascript <<EOF
    tell application "Terminal"
        activate
        do script "automationmodetool enable-automationmode-without-authentication"
        delay 2
        tell application "System Events"
            keystroke "${PASSWORD}"
            keystroke return
        end tell
    end tell
    delay 5
EOF
} && break

    retry=$((retry-1))
    if [ $retry -eq 0 ]; then
        echo "No retry attempts left"
        exit 1
    fi
    sleep 10
done

    echo "Getting terminal windows"
    term_service=$(launchctl list | grep -i terminal | cut -f3)
    echo "Close terminal windows: gui/501/${term_service}"
    launchctl bootout gui/501/${term_service} && sleep 5

    # test enable-automationmode-without-authentication
    if [[ ! "$(automationmodetool)" =~ "DOES NOT REQUIRE" ]]; then
        echo "Failed to enable enable-automationmode-without-authentication option"
        exit 1
    fi
fi

# Create symlink for tests running
if [ ! -d "/usr/local/bin" ];then
    sudo mkdir -p -m 775 /usr/local/bin
    sudo chown $USER:admin /usr/local/bin
fi
chmod +x $HOME/utils/invoke-tests.sh
sudo ln -s $HOME/utils/invoke-tests.sh /usr/local/bin/invoke_tests
