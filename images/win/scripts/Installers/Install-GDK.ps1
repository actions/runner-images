################################################################################
##  File:  Install-GDK.ps1
##  Desc:  Install Microsoft Game Developement Kit
################################################################################

# Preparation
$tempFolder = Join-Path $env:Tmp "GDK"

# Fetching Microsoft GDK release version
$GDKReleaseVersion = (Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/GDK/releases/latest").tag_name

# Cloning GDK repo and checking out to release
git clone --depth 1 --branch $GDKReleaseVersion "https://github.com/microsoft/GDK.git" $tempFolder

# Installing GDK
$GDKInstaller = Join-Path $tempFolder "pgdk.exe"
Install-Binary -FilePath $GDKInstaller -ArgumentList ("/quiet", "/norestart")

Invoke-PesterTests -Testfile "Tools" -TestName "Microsoft GDK"