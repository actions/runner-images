################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################
$DestinationPath = "$($env:SystemDrive)\"
$DriversZipFile = "SeleniumWebDrivers.zip"
Write-Host "Destination path: [$DestinationPath]"
Write-Host "Selenium drivers download and install..."
try {
    Invoke-WebRequest -UseBasicParsing -Uri "https://seleniumwebdrivers.blob.core.windows.net/seleniumwebdrivers/${DriversZipFile}" -OutFile $DriversZipFile
}
catch {
    Write-Error "[!] Failed to download $DriversZipFile"
    exit 1
}

$TempSeleniumDir = Join-Path $Env:TEMP "SeleniumWebDrivers"
Extract-7Zip -Path $DriversZipFile -DestinationPath $Env:TEMP
Remove-Item $DriversZipFile

$SeleniumWebDriverPath = Join-Path $DestinationPath "SeleniumWebDrivers"
$IEDriverPathTemp = Join-Path $TempSeleniumDir 'IEDriver'

if (-not (Test-Path -Path $SeleniumWebDriverPath)) {
    New-Item -Path $SeleniumWebDriverPath -ItemType "directory"
}

Move-Item -Path "$IEDriverPathTemp" -Destination $SeleniumWebDriverPath

Write-Host "Setting the environment variables"

setx IEWebDriver "C:\SeleniumWebDrivers\IEDriver" /M
