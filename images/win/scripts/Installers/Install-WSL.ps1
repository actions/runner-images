################################################################################
##  File:  Install-WSL.ps1
##  Desc:  Install WSLv1 for Windows
################################################################################

# Download Ubuntu 20.04 LTS distro
$url = "https://aka.ms/wslubuntu2004"
$name = "wslubuntu2004.zip"
$archive = Start-DownloadWithRetry -Url $url -Name $name
Extract-7Zip -Path $archive -DestinationPath C:\WSLUbuntu

# Install Ubuntu distro and set up the default user as root
C:\WSLUbuntu\ubuntu2004.exe install --root

# Update repos
bash -c "apt update && apt -y upgrade"

Invoke-PesterTests -TestFile "WSL"
