#!/bin/bash -e -o pipefail

Launch_Daemons="/Library/LaunchDaemons"

# EOF in quotes to disable variable expansion
echo "Creating limit.maxfiles.plist"
cat > "${Launch_Daemons}/limit.maxfiles.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>limit.maxfiles</string>
    <key>Program</key>
    <string>/Users/runner/limit-maxfiles.sh</string>
    <key>RunAtLoad</key>
    <true/>
    <key>ServiceIPC</key>
    <false/>
  </dict>
</plist>
EOF

# Creating script for applying workaround https://developer.apple.com/forums/thread/735798

cat > "/Users/runner/limit-maxfiles.sh" << EOF
#!/bin/bash
sudo launchctl limit maxfiles 256 unlimited
sudo launchctl limit maxfiles 65536 524288
EOF

echo "limit.maxfiles.sh permissions changing"
chmod +x "/Users/runner/limit-maxfiles.sh"

echo "limit.maxfiles.plist permissions changing"
chown root:wheel "${Launch_Daemons}/limit.maxfiles.plist"
chmod 0644 "${Launch_Daemons}/limit.maxfiles.plist"


echo "Done, limit.maxfiles has been updated"

