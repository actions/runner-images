#!/bin/bash -e

# A temporary workaround for https://github.com/Azure/azure-linux-extensions/issues/1238

prefix=/usr/local/bin

for tool in apt apt-get apt-fast;do
  real_tool=`which $tool`
  cat >$prefix/$tool <<EOT
#!/bin/sh

i=1
while [ \$i -le 30 ];do
  fuser /var/lib/dpkg/lock >/dev/null 2>&1
  result=\$?
  if [ \$result -eq  0 ];then
    sleep 1
    echo "/var/lib/dpkg/locked... retry \$i"
    i=\$((i + 1))
  else
    break
  fi
done
$real_tool "\$@"
EOT
  chmod +x $prefix/$tool
done
