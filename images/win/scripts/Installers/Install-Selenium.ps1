################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Create Selenium directory
$seleniumDirectory = "C:\selenium\"
New-Item -ItemType directory -Path $seleniumDirectory

# Download Selenium
$seleniumMajorVersion = (Get-ToolsetContent).selenium.version
$seleniumBinaryName = (Get-ToolsetContent).selenium.binary_name
$seleniumFileName = "$seleniumBinaryName.jar"
$json = Invoke-RestMethod -Uri "https://api.github.com/repos/SeleniumHQ/selenium/releases?per_page=100"
$seleniumDownloadUrl = $json.Where{-not $_.prerelease}.assets.browser_download_url | Where-Object { $_ -like "*${seleniumBinaryName}-${seleniumMajorVersion}.*jar" } | Select-Object -First 1

Start-DownloadWithRetry -Url $seleniumDownloadUrl -Name $seleniumFileName -DownloadPath $seleniumDirectory

# Create an epmty file to retrive selenium version
$seleniumFullVersion = $seleniumDownloadUrl.Split("-")[1].Split("/")[0]
New-Item -Path $seleniumDirectory -Name "$seleniumBinaryName-$seleniumFullVersion"

# Add SELENIUM_JAR_PATH environment variable
$seleniumBinPath = Join-Path $seleniumDirectory $seleniumFileName
setx "SELENIUM_JAR_PATH" "$($seleniumBinPath)" /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
