################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Create Selenium directory
$seleniumDirectory = "C:\selenium\"
$seleniumFileName = "selenium-server-standalone.jar"

New-Item -ItemType directory -Path $seleniumDirectory

# Temporarily download Selenium 3.*, since 4.* can contain some breaking changes
$seleniumMajorVersion = (Get-ToolsetContent).selenium.version
$json = Invoke-RestMethod -Uri "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100"
$seleniumFullVersion = $json.Where{-not $_.prerelease}.tag_name |
                             ForEach-Object {$_.Split("-")[1]} |
                             Where-Object {$_ -like "$seleniumMajorVersion.*"} |
                             Select-Object -First 1
[System.String] $seleniumDownloadUrl = $json.assets.browser_download_url -match "selenium-server-standalone-$seleniumFullVersion.jar"

Start-DownloadWithRetry -Url $seleniumDownloadUrl -Name $seleniumFileName -DownloadPath $seleniumDirectory

# Add SELENIUM_JAR_PATH environment variable
$seleniumBinPath = Join-Path $seleniumDirectory $seleniumFileName
setx "SELENIUM_JAR_PATH" "$($seleniumBinPath)" /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
