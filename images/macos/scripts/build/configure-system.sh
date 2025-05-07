#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-system.sh
##  Desc:  Post deployment system configuration actions
################################################################################

source ~/utils/utils.sh

echo "Set solid color wallpaper"
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/System/Library/Desktop Pictures/Solid Colors/Black.png"'

echo "Close all finder windows because they can interfere with UI tests"
close_finder_window

echo "Disable Handoff and Continuity"
defaults write com.apple.coreservices.useractivityd ActivityReceivingEnabled -bool false
defaults write com.apple.coreservices.useractivityd ActivityAdvertisingAllowed -bool false

echo "Disable graphic effects in System"
defaults write com.apple.universalaccess reduceMotion -bool true
defaults write com.apple.universalaccess reduceTransparency -bool true

echo "Disable analytics daemon (requires SIP to be disabled)"
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist

echo "Disable notification center agent"
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

echo "Disable Time Machine and it's daemon"
sudo tmutil disable
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.backupd.plist

echo "Disable Apple Push Notification Service daemon"
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist

# Remove Parallels Desktop
# https://github.com/actions/runner-images/issues/6105
# https://github.com/actions/runner-images/issues/10143
if is_SonomaX64 || is_VenturaX64 || is_SequoiaX64; then
    brew uninstall parallels
fi

echo "Put documentation to $HOME root"
cp $HOME/image-generation/output/software-report/systeminfo.* $HOME/

echo "Remove fastlane cached cookie"
rm -rf ~/.fastlane

# Clean up npm cache which collected during image-generation
# we have to do that here because `npm install` is run in a few different places during image-generation
echo "Clean up npm cache"
npm cache clean --force

# Clean yarn cache
yarn cache clean

echo "Clean up temporary directories"
sudo rm -rf ~/utils /tmp/*

# Erase all indexes and wait until the rebuilding process ends,
# for now there is no clear way to get status of indexing process on macOS, it takes around 3-6 minutes to accomplish
echo "Erase all MDS indexes and wait until the rebuilding process ends"
sudo mdutil -E / > /dev/null

echo "Wait for 6 minutes or until the indexing process end signal is found in logs"
for _ in {1..12}; do
    sleep 30
    result=$(sudo log show --last 1m | grep -E 'mds.*Released.*BackgroundTask' || true)
    if [[ -n "$result" ]]; then
        echo "Sign of indexing completion found:"
        echo "$result"
        break
    fi
done

echo "Check if the indexing process or other CPU intensive process (5% and more) is still running"

cool=0
while true; do
  usage=$(top -l 2 | grep "CPU usage" | awk '{print int($3)}' | tr -d '%' | tail -n 1)
  echo "Current CPU usage: ${usage}%"
  if [ $usage -lt 5 ]; then
    cool=$((cool + 1))
  else
    ps -arcwwwxo ppid,pid,%cpu,%mem,time,command | head -n 2 || true
    cool=0
  fi
 
  echo "Feeling cool for $cool intervals"

  if [ $cool -gt 5 ]; then
    echo "Cooled down, exiting..."
    break
  fi

  sleep 1
done

echo "Delete symlink for tests running"
sudo rm -f /usr/local/bin/invoke_tests

echo "Clean Homebrew downloads"
sudo rm -rf /Users/$USER/Library/Caches/Homebrew/downloads/*

# Uninstall expect used in configure-machine.sh
brew uninstall expect
