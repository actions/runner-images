################################################################################
##  File:  Install-EdgeDriver.ps1
##  Desc:  Install Edge WebDriver and configure Microsoft Edge
################################################################################

if (Test-IsArm64) {
    $driverArch = "arm64"
    $edgeArch = "arm64"
} else {
    $driverArch = "win64"
    $edgeArch = "x64"
}

# Install the latest Edge Stable explicitly, the background updater can fail during the build
Write-Host "Get the latest Microsoft Edge Stable version..."
$edgeProducts = Invoke-RestMethod -Uri "https://edgeupdates.microsoft.com/api/products"
$edgeRelease = ($edgeProducts | Where-Object { $_.Product -eq "Stable" }).Releases |
    Where-Object { $_.Platform -eq "Windows" -and $_.Architecture -eq $edgeArch } |
    Sort-Object { [version] $_.ProductVersion } -Descending |
    Select-Object -First 1
$edgeMsi = $edgeRelease.Artifacts | Where-Object { $_.ArtifactName -eq "msi" }

Write-Host "Install Microsoft Edge $($edgeRelease.ProductVersion)..."
Install-Binary -Type MSI `
    -Url $edgeMsi.Location `
    -ExpectedSHA256Sum $edgeMsi.Hash `
    -ExpectedSubject $(Get-MicrosoftPublisher)

# Disable Edge auto-updates
# The MSI starts Edge Update in the background, let it finish so it does not restore the executable after the rename
Get-Process -Name "MicrosoftEdgeUpdate*" -ErrorAction SilentlyContinue | Wait-Process -Timeout 300 -ErrorAction SilentlyContinue
Stop-Service -Name "edgeupdate", "edgeupdatem" -Force -ErrorAction SilentlyContinue
$edgeUpdatePath = "${env:ProgramFiles(x86)}\Microsoft\EdgeUpdate"
Rename-Item -Path "$edgeUpdatePath\MicrosoftEdgeUpdate.exe" -NewName "Disabled_MicrosoftEdgeUpdate.exe" -ErrorAction Stop

Write-Host "Get the Microsoft Edge WebDriver version..."
$edgeBinaryPath = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe").'(default)'
[version] $edgeVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($edgeBinaryPath).ProductVersion
if ($edgeVersion -lt [version] $edgeRelease.ProductVersion) {
    throw "Microsoft Edge $edgeVersion is installed, expected $($edgeRelease.ProductVersion)"
}

$edgeDriverPath = "$($env:SystemDrive)\SeleniumWebDrivers\EdgeDriver"
if (-not (Test-Path -Path $edgeDriverPath)) {
    New-Item -Path $edgeDriverPath -ItemType Directory -Force
}

$versionInfoUrl = "https://msedgedriver.microsoft.com/LATEST_RELEASE_$($edgeVersion.Major)_WINDOWS"
$versionInfoFile = Invoke-DownloadWithRetry -Url $versionInfoUrl -Path "$edgeDriverPath\versioninfo.txt"
$latestVersion = Get-Content -Path $versionInfoFile

Write-Host "Download Microsoft Edge WebDriver..."
$downloadUrl = "https://msedgedriver.microsoft.com/$latestVersion/edgedriver_$driverArch.zip"
$archivePath = Invoke-DownloadWithRetry $downloadUrl

Write-Host "Expand Microsoft Edge WebDriver archive..."
Expand-7ZipArchive -Path $archivePath -DestinationPath $edgeDriverPath

#Validate the EdgeDriver signature
Test-FileSignature -Path "$edgeDriverPath\msedgedriver.exe" -ExpectedSubject $(Get-MicrosoftPublisher)

Write-Host "Setting the environment variables..."
[Environment]::SetEnvironmentVariable("EdgeWebDriver", $EdgeDriverPath, "Machine")
Add-MachinePathItem "$edgeDriverPath\"

if (Test-Path -Path "$edgeUpdatePath\MicrosoftEdgeUpdate.exe") {
    throw "Microsoft Edge Update was restored after it was disabled"
}

Invoke-PesterTests -TestFile "Browsers" -TestName "Edge"
