################################################################################
##  File:  Install-Selenium.ps1
##  Desc:  Install Selenium Server standalone
################################################################################

# Create Selenium directory
$seleniumDirectory = "C:\selenium\"
New-Item -ItemType directory -Path $seleniumDirectory

# Download Selenium
$seleniumMajorVersion = (Get-ToolsetContent).selenium.version

$seleniumDownloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "SeleniumHQ/selenium" `
    -Version "$seleniumMajorVersion.*" `
    -Asset "selenium-server-*.jar" `
    -AllowMultipleMatches

$seleniumBinPath = Join-Path $seleniumDirectory "selenium-server.jar"
Invoke-DownloadWithRetry -Url $seleniumDownloadUrl -Path $seleniumBinPath

# Create an empty file to retrieve Selenium version
$seleniumFullVersion = $seleniumDownloadUrl.Split("-")[1].Split("/")[0]
New-Item -Path $seleniumDirectory -Name "selenium-server-$seleniumFullVersion"

# Add SELENIUM_JAR_PATH environment variable
[Environment]::SetEnvironmentVariable("SELENIUM_JAR_PATH", $seleniumBinPath, "Machine")

Invoke-PesterTests -TestFile "Browsers" -TestName "Selenium"
