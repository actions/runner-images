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

$seleniumDownloadUrl = Get-GitHubPackageDownloadUrl `
  -RepoOwner "SeleniumHQ" `
  -RepoName "selenium" `
  -BinaryName "$seleniumBinaryName" `
  -Version $seleniumMajorVersion `
  -UrlFilter "*{BinaryName}-{Version}.jar"

Start-DownloadWithRetry -Url $seleniumDownloadUrl -Name $seleniumFileName -DownloadPath $seleniumDirectory

# Create an empty file to retrive Selenium version
$seleniumFullVersion = $seleniumDownloadUrl.Split("-")[1].Split("/")[0]
New-Item -Path $seleniumDirectory -Name "$seleniumBinaryName-$seleniumFullVersion"

# Add SELENIUM_JAR_PATH environment variable
$seleniumBinPath = Join-Path $seleniumDirectory $seleniumFileName
setx "SELENIUM_JAR_PATH" "$($seleniumBinPath)" /M

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
