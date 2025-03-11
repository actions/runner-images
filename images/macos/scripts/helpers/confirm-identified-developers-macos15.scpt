# This AppleScript clicks "Allow" for "System Software from developer "Parallels International GmbH"
# Steps:
# - Open System Settings -> Privacy & Security
# - Click 'Allow' for 'System Software from developer "Parallels International GmbH'
# - Enter password for runner

on run argv
  set userpassword to item 1 of argv -- Retrieve the user's password from the arguments

  -- Open System Settings
  tell application "System Settings"
    activate
    delay 2
  end tell

  tell application "System Events"
    tell process "System Settings"
      set frontmost to true
      -- Wait until the window appears
      repeat until exists window 1
        delay 1
      end repeat

      -- Navigate to "Privacy & Security" in the sidebar
      tell window 1
        select row 20 of outline 1 of scroll area 1
        delay 2
      end tell

      -- Click the "Allow" button for Parallels International GmbH
      tell window 1
        click button "Allow" of group 1 of scroll area 1
        delay 2
      end tell

      -- Enter the administrator password if prompted
      if exists sheet 1 of window 1 then
        tell sheet 1 of window 1
          set value of text field 1 to userpassword
          delay 1
          click button "OK"
        end tell
      end if
    end tell
  end tell
end run


 
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
          select row 27 of outline 1 of scroll area 1 of group 1
          delay 5
          click UI Element 2 of group 4 of scroll area 1 of group 1 of group 2      
          delay 5
          keystroke userpassword
          delay 5
          keystroke return
          delay 5
      end tell
    end tell
  end tell
end run
