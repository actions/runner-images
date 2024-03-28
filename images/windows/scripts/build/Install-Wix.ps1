################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Install-ChocoPackage wixtoolset -ArgumentList "--force"

Update-Environment

$wixBinPath = Join-Path -Path $env:WIX -ChildPath 'bin'
if (Test-Path $wixBinPath) {
    $currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $newPath = $currentPath + ";$wixBinPath"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
} else {
    Write-Error "WIX binaries folder ($wixBinPath) not found."
}

Invoke-PesterTests -TestFile "Wix"
