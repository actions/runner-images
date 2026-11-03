#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-hostname.sh
##  Desc:  Change the hostname at startup to prevent duplicates
##         Keep the system hostname locally resolvable without depending on mDNS
################################################################################

source ~/utils/utils.sh

cp "$HOME/image-generation/tests/hostname-resolution.py" /usr/local/bin/check_hostname_resolution.py

tee /usr/local/bin/change_hostname.sh > /dev/null <<\EOF
#!/bin/bash -e -o pipefail

name="Mac-$(python3 -c 'from time import time; print(int(round(time() * 1000)))')"
# Replace only our previous boot's aliases, retaining all other hosts entries.
sed -i '' '/[[:space:]]# runner-image-hostname$/d' /etc/hosts
printf '127.0.0.1\t%s # runner-image-hostname\n' "$name" >> /etc/hosts

scutil --set HostName "$name"
scutil --set LocalHostName "$name"
scutil --set ComputerName "${name}.local"

# Check each deployed VM after assigning its new hostname, not just the image.
python3 /usr/local/bin/check_hostname_resolution.py
EOF

chmod +x /usr/local/bin/change_hostname.sh

sudo tee /Library/LaunchDaemons/change_hostname.plist > /dev/null <<\EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "https://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
        <dict>
                <key>Label</key>
                <string>change-hostname</string>
                <key>Program</key>
                <string>/usr/local/bin/change_hostname.sh</string>
                <key>RunAtLoad</key>
                <true/>
                <key>StandardOutPath</key>
                <string>/var/log/runner-hostname.log</string>
                <key>StandardErrorPath</key>
                <string>/var/log/runner-hostname.log</string>
        </dict>
</plist>
EOF

# Apply the same boot-time path before the image's regression tests run.
sudo /usr/local/bin/change_hostname.sh
invoke_tests "Hostname"
