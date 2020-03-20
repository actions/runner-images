source $HELPER_SCRIPTS/document.sh

#groupadd nvm
#usermod -aG nvm root
#chown :nvm ./nvm
export NVM_DIR="/opt/.nvm"
mkdir -m 777 $NVM_DIR
#chmod g+ws $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
ls $NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "/etc/profile"
#echo "source $NVM_DIR/nvm.sh --install" >> /etc/profile
#sudo source /etc/profile
#exec bash
if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

#DocumentInstalledItem "nvm ($(nvm --version))"