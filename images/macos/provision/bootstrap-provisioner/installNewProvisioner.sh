#!/bin/bash -e -o pipefail
BOOTSTRAP_PATH="$1"
ProvisionerPackageUri="$2"
ProvisionerScriptUri="$3"
ScriptName="$4"
ScriptParam="$5"
Username="$6"
arch=$(arch)

if [[ $arch == "arm64" ]]; then
  export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/bin:/sbin:/opt/homebrew/bin
else
  export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/bin:/sbin
fi

PROVISIONER_ROOT=/usr/local/opt/${Username}
sudo mkdir -p ${PROVISIONER_ROOT}
sudo chown ${Username} ${PROVISIONER_ROOT}

tee -a ${PROVISIONER_ROOT}/runprovisioner.sh > /dev/null <<\EOF
#!/bin/bash

. ${HOME}/.bashrc

/usr/local/opt/$USER/provisioner/provisioner
EOF

chmod +x $PROVISIONER_ROOT/runprovisioner.sh

aria2c \
  --enable-color=false \
  --file-allocation=none \
  -d ${BOOTSTRAP_PATH} "${ProvisionerPackageUri}" >> ${BOOTSTRAP_PATH}/download.log

aria2c \
  --enable-color=false \
  --file-allocation=none \
  -d ${BOOTSTRAP_PATH} "${ProvisionerScriptUri}" >> ${BOOTSTRAP_PATH}/download.log

chmod +x ${BOOTSTRAP_PATH}/${ScriptName}

# Install Provisioner with provided scripts
eval "$BOOTSTRAP_PATH/$ScriptName $BOOTSTRAP_PATH/$ScriptParam $Username" 2>&1 | tee "$BOOTSTRAP_PATH/install.log"
# State File
touch $BOOTSTRAP_PATH/provisionerDone