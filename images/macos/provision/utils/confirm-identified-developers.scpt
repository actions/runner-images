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
  set secpane to "Security & Privacy"

  activate application "System Preferences"
  delay 5

  tell application "System Events"
    tell process "System Preferences"
        set frontmost to true
        delay 2
        click menu item secpane of menu "View" of menu bar 1
        delay 5
        click button 1 of window 1
        delay 5
        keystroke userpassword
        delay 5
        keystroke return
        delay 5
        click radio button "General" of tab group 1 of window 1
        delay 5
        if exists of UI element "Details…" of tab group 1 of window 1 then
          click button "Details…" of tab group 1 of window 1
          delay 5
          keystroke return
          delay 5
          keystroke return
          delay 5
        end if
        if exists of UI element "Allow" of tab group 1 of window 1 then
          click button "Allow" of tab group 1 of window 1
          delay 5
          keystroke return
          delay 5
        end if
        click button 5 of window 1
    end tell
  end tell
end run