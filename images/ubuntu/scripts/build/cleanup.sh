#!/bin/bash -e
################################################################################
##  File:  cleanup.sh
##  Desc:  Perform cleanup
################################################################################

# before cleanup
before=$(df / -Pm | awk 'NR==2{print $4}')

# clears out the local repository of retrieved package files
# It removes everything but the lock file from /var/cache/apt/archives/ and /var/cache/apt/archives/partial
apt-get clean
rm -rf /tmp/*
rm -rf /root/.cache

# journalctl
if command -v journalctl; then
    journalctl --rotate
    journalctl --vacuum-time=1s
fi

# delete all .gz and rotated file
find /var/log -type f -regex ".*\.gz$" -delete
find /var/log -type f -regex ".*\.[0-9]$" -delete

# wipe log files
find /var/log/ -type f -exec cp /dev/null {} \;

# delete symlink for tests running
rm -f /usr/local/bin/invoke_tests

# remove apt mock
prefix=/usr/local/bin
for tool in apt apt-get apt-key;do
    sudo rm -f $prefix/$tool
done

# after cleanup
after=$(df / -Pm | awk 'NR==2{print $4}')

# display size
echo "Before: $before MB"
echo "After : $after MB"
echo "Delta : $(($after-$before)) MB"
