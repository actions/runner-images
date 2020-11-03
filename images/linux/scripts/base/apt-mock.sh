#!/bin/bash -e

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
  if [ \$result -eq  0 ];then
    break
  fi
  grep -q 'It is held by process' \$err
  held=\$?
  if [ \$held -ne  0 ];then
    break
  fi
  sleep 1
  echo "...retry \$i"
  i=\$((i + 1))
done
EOT
  chmod +x $prefix/$tool
done
