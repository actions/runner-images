################################################################################
##  File:  Install-Vcpkg.ps1
##  Desc:  Install vcpkg
################################################################################

$Uri = 'https://github.com/Microsoft/vcpkg.git'
$InstallDir = 'C:\vcpkg'
$VcpkgExecPath = 'vcpkg.exe'

git clone $Uri $InstallDir -q

# Build and integrate vcpkg
Invoke-Expression "$InstallDir\bootstrap-vcpkg.bat"
Invoke-Expression "$InstallDir\$VcpkgExecPath integrate install"

# Add vcpkg to system environment
Add-MachinePathItem $InstallDir
[Environment]::SetEnvironmentVariable("VCPKG_INSTALLATION_ROOT", $InstallDir, "Machine")
Update-Environment

Invoke-PesterTests -TestFile "Tools" -TestName "Vcpkg"
