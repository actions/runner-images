################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Create Selenium directory
$seleniumDirectory = "C:\selenium\"
$seleniumFileName = "selenium-server-standalone.jar"

New-Item -ItemType directory -Path $seleniumDirectory

# Download Selenium
$url = "https://api.github.com/repos/SeleniumHQ/selenium/releases/latest"
[System.String] $seleniumReleaseUrl = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "selenium-server-standalone-.+.jar"

Start-DownloadWithRetry -Url $seleniumReleaseUrl -Name $seleniumFileName -DownloadPath $seleniumDirectory

# Add SELENIUM_JAR_PATH environment variable
$seleniumBinPath = Join-Path $seleniumDirectory $seleniumFileName
setx "SELENIUM_JAR_PATH" "$($seleniumBinPath)" /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
