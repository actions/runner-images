#!/bin/bash

prefix=/usr/local/bin

for tool in apt apt-get apt-fast;do
  real_tool=`which $tool`
  cat >$prefix/$tool <<EOT
#!/bin/sh

i=1
while [ \$i -le 10 ];do
  $real_tool "\$@"
  result=\$?
  if [ \$result -eq  0 ];then
    break
  else
    sleep 5
    echo "...retry \$i"
    i=\$((i + 1))
  fi
done
EOT
  chmod +x $prefix/$tool
done
