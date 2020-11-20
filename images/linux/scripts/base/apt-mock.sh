#!/bin/bash -e

# A temporary workaround for https://github.com/Azure/azure-linux-extensions/issues/1238

prefix=/usr/local/bin

for tool in apt apt-get apt-fast apt-key;do
  which $tool || continue
  real_tool=`which $tool`
  cat >$prefix/$tool <<EOT
#!/bin/sh

i=1
while [ \$i -le 30 ];do
  err=\$(mktemp)
  $real_tool "\$@" 2>\$err
  result=\$?
  cat \$err >&2

  # no errors, continue
  test \$result -eq  0 && break

  retry=false

  if grep -q 'Could not get lock' \$err;then
    # apt db locked needs retry
    retry=true
  elif grep -q 'Could not open file /var/lib/apt/lists' \$err;then
    # apt update is not completed, needs retry
    retry=true
  elif grep -q 'IPC connect call failed' \$err;then
    ## TODO:
    ## the delay should help with gpg-agent not ready
    ## if it is not then uncomment the folloing lines in order to
    ## force restart gpg-agent
    #  pkill -9 gpg-agent
    #  sleep 1
    #  source <(gpg-agent --daemon)
    retry=true
  fi

  rm \$err
  if [ \$retry = false ]; then
    break
  fi

  sleep 5
  echo "...retry \$i"
  i=\$((i + 1))
done
EOT
  chmod +x $prefix/$tool
done
