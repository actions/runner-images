################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Install-ChocoPackage wixtoolset -ArgumentList "--force"

# Add WiX bin folder to the PATH
$currentPath = [Environment]::GetEnvironmentVariable("PATH", "Machine")
$NewPath = "$currentPath;$($Env:WIX)\bin"
[Environment]::SetEnvironmentVariable("PATH", $NewPath, "Machine")

Invoke-PesterTests -TestFile "Wix"
