#!/bin/bash -e -o pipefail

source ~/utils/utils.sh

imagedata_file="$HOME/imagedata.json"
image_version=$(echo $IMAGE_VERSION | cut -d _ -f 2)
os_name=$(sw_vers -productName)
os_version=$(sw_vers -productVersion)
os_build=$(sw_vers -buildVersion)
label_version=$(echo $os_version | cut -d. -f1,2)
if is_Catalina; then
    label_version=$(echo $os_version | cut -d. -f1,2)
else
    label_version=$(echo $os_version | cut -d. -f1)
fi
image_label="macos-${label_version}"
release_label="macOS-${label_version}"
software_url="https://github.com/actions/runner-images/blob/${release_label}/${image_version}/images/macos/${image_label}-Readme.md"
releaseUrl="https://github.com/actions/runner-images/releases/tag/${release_label}%2F${image_version}"

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