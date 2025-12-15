#!/bin/bash -e

# delete all .gz and rotated file
find /var/log -type f -regex ".*\.gz$" -delete
find /var/log -type f -regex ".*\.[0-9]$" -delete

# wipe log files
find /var/log/ -type f -exec cp /dev/null {} \;

rm -rf /tmp/downloads /tmp/installers

apt-get clean && rm -rf /var/lib/apt/lists/*