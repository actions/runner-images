source $HELPER_SCRIPTS/document.sh

export NVM_DIR="$HOME/.nvm"
mkdir $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo "source $NVM_DIR/nvm.sh --install" >> "$HOME/.bash_profile"
source $HOME/.bash_profile

if ! command -v nvm; then
    echo "nvm was not installed"
    exit 1
fi

DocumentInstalledItem "nvm ($(nvm --version))"