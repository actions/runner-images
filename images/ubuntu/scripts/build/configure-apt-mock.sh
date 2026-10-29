#!/bin/bash -e
################################################################################
##  File:  configure-apt-mock.sh
##  Desc:  A temporary workaround for https://github.com/Azure/azure-linux-extensions/issues/1238.
##         Cleaned up during cleanup.sh.
################################################################################

prefix=/usr/local/bin

for real_tool in /usr/bin/apt /usr/bin/apt-get /usr/bin/apt-key; do
    tool=$(basename $real_tool)
    cat >$prefix/$tool <<EOT
#!/bin/sh

i=1
network_retries=0
while [ \$i -le 30 ];do
  err=\$(mktemp)
  rc=0
  $real_tool "\$@" 2>\$err || rc=\$?
  cat \$err >&2

  retry=false
  delay=5

  if grep -q 'Could not get lock' \$err;then
    # apt db locked needs retry
    retry=true
  elif grep -q 'Could not get lock /var/lib/apt/lists/lock' \$err;then
    # apt update did not complete (race condition), needs retry
    retry=true
  elif grep -q 'Problem renaming the file /var/cache/apt/pkgcache.bin.* to /var/cache/apt/pkgcache.bin' \$err;then
    # apt-get did not complete (race condition), needs retry
    retry=true
  elif grep -q 'Problem renaming the file /var/cache/apt/srcpkgcache.bin.* to /var/cache/apt/srcpkgcache.bin' \$err;then
    # apt update did not complete (race condition), needs retry
    retry=true
  elif grep -q 'Could not open file /var/lib/apt/lists' \$err;then
    # apt update is not completed, needs retry
    retry=true
  elif grep -q 'IPC connect call failed' \$err;then
    # the delay should help with gpg-agent not ready
    retry=true
  elif grep -q 'Temporary failure in name resolution' \$err;then
    # It looks like DNS is not updated with random generated hostname yet
    retry=true
  elif grep -q 'dpkg frontend is locked by another process' \$err;then
    # dpkg process is busy by another process
    retry=true
  elif [ \$rc -ne 0 ] && [ \$network_retries -lt 9 ] && ! grep -q ' 404 ' \$err \\
    && grep -qE 'Failed to fetch|Unable to fetch some archives|Hash Sum mismatch|Could not connect to|Connection timed out| 50[234] ' \$err;then
    # transient mirror or network failure (404 is not transient), retry up to 10 attempts with a longer delay
    retry=true
    delay=30
    network_retries=\$((network_retries + 1))
  fi

  rm \$err
  if [ \$retry = false ]; then
    break
  fi

  sleep \$delay
  echo "...retry \$i"
  i=\$((i + 1))
done

# propagate the real tool's exit code, otherwise every apt failure is reported as success
exit \$rc
EOT
    chmod +x $prefix/$tool
done
