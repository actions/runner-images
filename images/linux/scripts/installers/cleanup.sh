#!/bin/bash

# before cleanup
before=$(df / -Pm | awk 'NR==2{print $4}')

# clears out the local repository of retrieved package files
# It removes everything but the lock file from /var/cache/apt/archives/ and /var/cache/apt/archives/partial
apt-get clean

# after cleanup
after=$(df / -Pm | awk 'NR==2{print $4}')

# display size
 echo "Before: $before MB"
 echo "After : $after MB"
 echo "Delta : $(($after-$before)) MB"