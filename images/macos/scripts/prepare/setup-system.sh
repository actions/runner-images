#!/bin/bash -e -o pipefail

echo "Setting up system ..."

# check if password is set
if [ -z "$PASSWORD" ]; then
  echo "PASSWORD environment variable is not set"
  exit 1
fi

# get current user
USERNAME=$(id -un)
echo "Current user is $USERNAME"

echo "Enabling passwordless sudo for $USERNAME"
# Enable passwordless sudo
echo "${PASSWORD}" | sudo -S sh -c "mkdir -p /etc/sudoers.d/; echo '$USERNAME ALL=(ALL) NOPASSWD: ALL' | EDITOR=tee visudo /etc/sudoers.d/$USERNAME-nopasswd"

echo "Enabling auto-login for $USERNAME"
# Enable auto-login
#
# See https:#github.com/xfreebird/kcpassword for details.
echo '00000000: 1ced 3f4a bcbc ba2c caca 4e82' | sudo xxd -r - /etc/kcpassword

echo "Disabling screensaver at login screen"
sudo defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser $USERNAME

echo "Disabling screensaver for admin user at login screen"
# Disable screensaver at login screen
sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime 0

echo "Disabling screensaver for admin user"
# Disable screensaver for admin user
defaults -currentHost write com.apple.screensaver idleTime 0

echo "Prevent the VM from sleeping"
# Prevent the VM from sleeping
sudo systemsetup -setdisplaysleep Off 2>/dev/null
sudo systemsetup -setsleep Off 2>/dev/null
sudo systemsetup -setcomputersleep Off 2>/dev/null

echo "Launching Safari to populate the defaults"
# Launch Safari to populate the defaults
/Applications/Safari.app/Contents/MacOS/Safari &
SAFARI_PID=$!
disown
sleep 30
kill -9 $SAFARI_PID

echo "Enabling Safari's remote automation and \"Develop\" menu"
# Enable Safari's remote automation and "Develop" menu
sudo safaridriver --enable
defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true

echo "Disabling screen lock"
# Disable screen lock
#
# Note that this only works if the user is logged-in,
# i.e. not on login screen.
sysadminctl -screenLock off -password $PASSWORD

echo "Disabling screensaver"
defaults -currentHost write com.apple.screensaver idleTime 0
