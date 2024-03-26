################################################################################
##  File:  Install-Wix.ps1
##  Desc:  Install WIX.
################################################################################

Install-ChocoPackage wixtoolset -ArgumentList "--force"

# Add WIX binaries to PATH
$wixBinPath = Join-Path -Path $env:WIX -ChildPath 'bin'
if (Test-Path $wixBinPath) {
    $currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
    $newPath = $currentPath + ";$wixBinPath"
    Write-Host "Add $wixBinPath to PATH"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")
    $env:Path += ";$wixBinPath"
}else{
    Write-Error "WIX binaries folder ($wixBinPath) not found."
}

Invoke-PesterTests -TestFile "Wix"
