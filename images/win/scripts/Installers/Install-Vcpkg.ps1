################################################################################
##  File:  Install-Vcpkg.ps1
##  Desc:  Install vcpkg
################################################################################

Write-Host "Download the latest vcpkg version..."
$vcpkgDownloadUrl = (Invoke-RestMethod "https://api.github.com/repos/microsoft/vcpkg/releases/latest").tarball_url
$installDir = 'C:\vcpkg'
New-Item $installDir -type directory
$tempPath = Join-Path -Path "${env:Temp}" -ChildPath "vcpkg.tar.gz"
Invoke-WebRequest $vcpkgDownloadUrl -OutFile $tempPath

Write-Host "Expand vcpkg archive"
tar -xzvf $tempPath -C $installDir --strip-components=1

# Build and integrate vcpkg
Invoke-Expression "$installDir\bootstrap-vcpkg.bat"
Invoke-Expression "$installDir\vcpkg.exe integrate install"

# Add vcpkg to system environment
Add-MachinePathItem $installDir
$env:Path = Get-MachinePath
setx VCPKG_INSTALLATION_ROOT $installDir /M

Invoke-PesterTests -TestFile "Tools" -TestName "Vcpkg"
