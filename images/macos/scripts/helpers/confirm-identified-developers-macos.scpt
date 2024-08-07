# This AppleScript confirms developers in security preferences via macOS UI.
# It uses after VirtualBox installation to add 'Oracle Inc' as identified developer.
# Steps:
# - Close security preferences pop-up (it can be open after VirtualBox installation)
# - Open System Preferences -> Security & Privacy -> General
# - Unlock security preferences with user password (button 'Click the lock to make changes')
# - Click 'Allow' or 'Details…' button to confirm developers
# - Click 'Not now' button on restarting pop-up
# - Close System Preferences

on run argv
  set userpassword to item 1 of argv

  tell application "System Settings"
    activate
    delay 5
    set current pane to pane id "com.apple.preferences.security"
  end tell

  delay 5

  tell application "System Events"
    tell process "System Settings"
      repeat until exists window "Privacy & Security"
        delay 2
      end repeat

      tell window "Privacy & Security"
        set theSecuritySection to scroll area 1 of group 1 of group 1
        set theAllowButton to (first button whose name contains "Allow") of theSecuritySection

        if exists theAllowButton then
          display dialog "Click 'Allow' to approve system software from 'Parallels International GmbH'."
          delay 5
          keystroke return
          delay 5
        else
          display dialog "No software approval needed at this time."
        end if
      end tell
    end tell
  end tell
end run
