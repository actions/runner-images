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
    rm \$err
    break
  fi
  grep -q 'Could not get lock' \$err
  held=\$?
  if [ \$held -ne  0 ];then
    grep -q 'Could not open file /var/lib/apt/lists' \$err
    held=\$?
    if [ \$held -ne  0 ];then
      rm \$err
      break
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

