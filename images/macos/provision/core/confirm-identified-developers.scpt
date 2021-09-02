on run argv
  set userpassword to item 1 of argv
  set secpane to "Security & Privacy"

  tell application "System Events"
    tell security preferences
      keystroke return
      delay 5
    end tell
  end tell

  activate application "System Preferences"
  delay 5
  tell application "System Events"
    tell process "System Preferences"
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