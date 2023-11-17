#!/bin/bash -e
################################################################################
##  File: post-deployment.sh
##  Desc: Post deployment actions
################################################################################

mv -f /imagegeneration/post-generation /opt

echo "chmod -R 777 /opt"
chmod -R 777 /opt
echo "chmod -R 777 /usr/share"
chmod -R 777 /usr/share

chmod 755 $IMAGE_FOLDER

# Remove quotes around PATH
ENVPATH=$(grep 'PATH=' /etc/environment | head -n 1 | sed -z 's/^PATH=*//')
ENVPATH=${ENVPATH#"\""}
ENVPATH=${ENVPATH%"\""}
echo "PATH=$ENVPATH" | sudo tee -a /etc/environment
echo "Updated /etc/environment: $(cat /etc/environment)"

# Clean yarn and npm cache
if yarn --version > /dev/null
then
  yarn cache clean
fi
if npm --version
then
  npm cache clean --force
fi
