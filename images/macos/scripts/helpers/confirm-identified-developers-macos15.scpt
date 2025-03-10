# This AppleScript clicks "Allow" for "System Software from developer "Parallels International GmbH"
# Steps:
# - Open System Settings -> Privacy & Security
# - Click 'Allow' for 'System Software from developer "Parallels International GmbH'
# - Enter password for runner

on run argv
  set userpassword to item 1 of argv
  
  -- Open System Settings
  tell application "System Settings"
    activate
    delay 5
  end tell

  tell application "System Events"
    tell process "System Settings"
      set frontmost to true

      -- Navigate to "Privacy & Security"
      repeat until exists window "Privacy & Security"
        delay 2
      end repeat
      
      -- Click the "Allow" button for Parallels International GmbH
      try
        click button "Allow" of scroll area 1 of window "Privacy & Security"
        delay 5
        
        -- Enter password
        keystroke userpassword
        delay 2
        keystroke return
        delay 3
      on error
        display dialog "Failed to find the 'Allow' button. Please check UI changes."
      end try
    end tell
  end tell
end run
