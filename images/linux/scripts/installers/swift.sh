#!/bin/bash
################################################################################
##  File:  swift.sh
##  Desc:  Installs Swift
################################################################################

# Install # Install
image_label="$(lsb_release -rs)"
wget https://swift.org/builds/swift-5.1.5-release/ubuntu${image_label//./}/swift-5.1.5-RELEASE/swift-5.1.5-RELEASE-ubuntu$image_label.tar.gz
tar xzf swift-5.1.5-RELEASE-ubuntu$image_label.tar.gz
sudo mv swift-5.1.5-RELEASE-ubuntu$image_label /usr/share/swift
sudo echo "PATH=/usr/share/swift/usr/bin:$PATH" | sudo tee -a /etc/environment
source  ~/.bashrc

# Run tests to determine that the software installed as expected
echo "Testing to make sure that script performed as expected, and basic scenarios work"
if ! command -v swift; then
    echo "Swift was not installed"
    exit 1
fi

# Document what was added to the image
echo "Lastly, documenting what we added to the metadata file"
DocumentInstalledItem "$(swift --version)"