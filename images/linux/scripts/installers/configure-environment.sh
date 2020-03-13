#Set ImageVersion and ImageOS env variables
echo ImageVersion=$IMAGE_VERSION | tee -a /etc/environment
echo ImageOS=$IMAGE_OS | tee -a /etc/environment

# This directory is supposed to be created in $HOME and owned by user(https://github.com/actions/virtual-environments/issues/491)
mkdir -p /etc/skel/.config/configstore
echo 'export XDG_CONFIG_HOME=$HOME/.config' | tee -a /etc/skel/.bashrc
