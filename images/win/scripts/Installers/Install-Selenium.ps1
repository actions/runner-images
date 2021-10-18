################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Create Selenium directory
$seleniumDirectory = "C:\selenium\"
$seleniumFileName = "selenium-server-standalone.jar"

New-Item -ItemType directory -Path $seleniumDirectory

# Temporarily download Selenium 3.141.59, since 4.* can contain some breaking changes
#$url = "https://api.github.com/repos/SeleniumHQ/selenium/releases"
#[System.String] $seleniumReleaseUrl = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "selenium-server-standalone-.+.jar"

$seleniumDownloadUrl = "https://github.com/SeleniumHQ/selenium/releases/download/selenium-3.141.59/selenium-server-standalone-3.141.59.jar"
Start-DownloadWithRetry -Url $seleniumDownloadUrl -Name $seleniumFileName -DownloadPath $seleniumDirectory

# Add SELENIUM_JAR_PATH environment variable
$seleniumBinPath = Join-Path $seleniumDirectory $seleniumFileName
setx "SELENIUM_JAR_PATH" "$($seleniumBinPath)" /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
