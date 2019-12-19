################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Acquire latest Selenium release number from GitHub API
$latestReleaseUrl = "https://api.github.com/repos/SeleniumHQ/selenium/releases/latest"
$latestReleaseInfo = Invoke-RestMethod -Uri $latestReleaseUrl
$seleniumVersionString = $latestReleaseInfo.name.Split(" ")[1]
$seleniumVersion = [version]::Parse($seleniumVersionString)

# Download Selenium
Write-Host "Downloading selenium-server-standalone v$seleniumVersion..."

$seleniumReleaseUrl = "https://selenium-release.storage.googleapis.com/$($seleniumVersion.ToString(2))/selenium-server-standalone-$($seleniumVersion.ToString(3)).jar"
New-Item -ItemType directory -Path "C:\selenium\"
$seleniumBinPath = "C:\selenium\selenium-server-standalone.jar"
Invoke-WebRequest -UseBasicParsing -Uri $seleniumReleaseUrl -OutFile $seleniumBinPath

setx "CLASSPATH" "$($seleniumBinPath):$($env:CLASSPATH)" /M

exit 0
