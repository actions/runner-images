# Source the helpers for use with the script
    source $HELPER_SCRIPTS/install.sh

    # Install Eksctl CLI  
    downloadUrl="https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    mv /tmp/eksctl /usr/local/bin