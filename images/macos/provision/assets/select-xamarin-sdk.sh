#!/bin/bash -e -o pipefail
if [ -z "$1" ]; then
  echo "No Xamarin SDK specified."
  exit 0
fi

XAMARIN_SDK=$1

echo "Set Xamarin SDK to ${XAMARIN_SDK}"
FOLDERS_LIST=(
        '/Library/Frameworks/Mono.framework/Versions'
        '/Library/Frameworks/Xamarin.iOS.framework/Versions'
        '/Library/Frameworks/Xamarin.Android.framework/Versions'
        '/Library/Frameworks/Xamarin.Mac.framework/Versions'
    )

for FOLDER in "${FOLDERS_LIST[@]}"
do
    echo "Set Current folder for ${FOLDER}"
    sudo rm -f ${FOLDER}/Current
    sudo ln -s ${FOLDER}/${XAMARIN_SDK} ${FOLDER}/Current
done
