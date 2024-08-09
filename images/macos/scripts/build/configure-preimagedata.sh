#!/bin/bash -e -o pipefail
################################################################################
##  File:  configure-preimagedata.sh
##  Desc:  Configure data used in the image
################################################################################

source ~/utils/utils.sh

arch=$(get_arch)
imagedata_file="$HOME/imagedata.json"
image_version=$(echo $IMAGE_VERSION | cut -d _ -f 2)
os_name=$(sw_vers -productName)
os_version=$(sw_vers -productVersion)
os_build=$(sw_vers -buildVersion)
label_version=$(echo $os_version | cut -d. -f1)

if [[ $arch == "arm64" ]]; then
  image_label="macos-${label_version}-arm64"
else
  image_label="macos-${label_version}"
fi

software_url="https://github.com/actions/runner-images/blob/${image_label}/${image_version}/images/macos/${image_label}-Readme.md"
releaseUrl="https://github.com/actions/runner-images/releases/tag/${image_label}%2F${image_version}"

cat <<EOF > $imagedata_file
    [
      {
        "group": "Operating System",
        "detail": "${os_name}\n${os_version}\n${os_build}"
      },
      {
        "group": "Runner Image",
        "detail": "Image: ${image_label}\nVersion: ${image_version}\nIncluded Software: ${software_url}\nImage Release: ${releaseUrl}"
      }
    ]
EOF

echo "export ImageVersion=$image_version" >> $HOME/.bashrc
echo "export ImageOS=$IMAGE_OS" >> $HOME/.bashrc
