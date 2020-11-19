#!/bin/bash -e

set -x
# A temporary workaround for https://github.com/Azure/azure-linux-extensions/issues/1238

prefix=/usr/local/bin

for tool in apt apt-get apt-fast;do
  real_tool=`which $tool`
  cat >$prefix/$tool <<EOT
#!/bin/sh

i=1
while [ \$i -le 30 ];do
  err=\$(mktemp)
  $real_tool "\$@" 2>\$err
  result=\$?
  cat \$err >&2
  if [ \$result -eq  0 ];then
    # no errors, continue
    rm \$err
    break
  fi
  # some error exists, check for apt db locked
  grep -q 'Could not get lock' \$err
  result=\$?
  if [ \$result -ne  0 ];then
    # some error exists, check for apt update is not complete
    grep -q 'Could not open file /var/lib/apt/lists' \$err
    result=\$?
    if [ \$result -ne  0 ];then
      # some error exists, check for gpg-agent is busy or not run yet
      grep -q 'IPC connect call failed' \$err
      result=\$?
      if [ \$result -ne  0 ];then
        # some unhandled error, continue
        rm \$err
        break
      # # TODO:
      # # the delay should help with gpg-agent not ready
      # # if it is not uncomment the folloing lines in order to
      # # force restart gpg-agent
      # else
      #  pkill -9 gpg-agent
      #  sleep 1
      #  source <(gpg-agent --daemon)
      fi
    fi
  fi
  rm \$err
  sleep 5
  echo "...retry \$i"
  i=\$((i + 1))
done
EOT
  chmod +x $prefix/$tool
done

