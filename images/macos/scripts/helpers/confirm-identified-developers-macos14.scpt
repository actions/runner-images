# This AppleScript clicks "Allow" for "System Software from developer "Parallels International GmbH"
# Steps:
# - Open System Settings -> Privacy & Security
# - Click 'Allow' for 'System Software from developer "Parallels International GmbH'
# - Enter password for runner

on run argv
  set userpassword to item 1 of argv

  tell application "System Settings"
    activate
    delay 5
  end tell

  tell application "System Events"
    tell process "System Settings"
      set frontmost to true
      repeat until exists window 1
        delay 2
      end repeat

      tell splitter group 1 of group 1 of window 1
          select row 18 of outline 1 of scroll area 1 of group 1
          delay 5
          click UI Element 2 of group 5 of scroll area 1 of group 1 of group 2
          delay 5
          keystroke userpassword
          delay 5
          keystroke return
          delay 5
      end tell
    end tell
  end tell
end run
