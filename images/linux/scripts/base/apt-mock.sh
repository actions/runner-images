#!/bin/sh -x

prefix=/usr/local/bin
mkdir -p $prefix

for tool in apt apt-get apt-fast deb;do
  real_tool=`which $tool`
  cat >$prefix/$tool <<EOT
#!/bin/sh
$real_tool "\$@"
result=\$?
if [ \$result -ne  0 ];then
  ps axjf
fi
EOT
  chmod +x $prefix/$tool
  ls -la $prefix/$tool
  cat $prefix/$tool
done
