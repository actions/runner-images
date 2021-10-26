################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Create Selenium directory
$seleniumDirectory = "C:\selenium\"
$seleniumFileName = "selenium-server-standalone.jar"

New-Item -ItemType directory -Path $seleniumDirectory

# Download Selenium
$seleniumMajorVersion = (Get-ToolsetContent).selenium.version
$json = Invoke-RestMethod -Uri "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100"
$seleniumDownloadUrl = $json.Where{-not $_.prerelease}.assets.browser_download_url | Where-Object { $_ -like "*selenium-server*-${seleniumMajorVersion}.*jar" } | Select-Object -First 1

Start-DownloadWithRetry -Url $seleniumDownloadUrl -Name $seleniumFileName -DownloadPath $seleniumDirectory

# Add SELENIUM_JAR_PATH environment variable
$seleniumBinPath = Join-Path $seleniumDirectory $seleniumFileName
setx "SELENIUM_JAR_PATH" "$($seleniumBinPath)" /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
