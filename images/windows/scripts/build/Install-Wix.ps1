################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Install-ChocoPackage wixtoolset -ArgumentList "--force"

Update-Environment
$currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
$newPath = $currentPath + ";$(Join-Path -Path $env:WIX -ChildPath "bin")"
[Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
Update-Environment

Invoke-PesterTests -TestFile "Wix"
