################################################################################
##  File:  Validate-Chrome.ps1
##  Desc:  Validate Google Chrome installation.
################################################################################

$IEDriverPath = $env:IEWebDriver
Write-Host "IEDriverPath: $IEDriverPath"
$GeckoDriverPath = $env:GeckoWebDriver
Write-Host "GeckoDriverPath: $GeckoDriverPath"
$ChromeDriverPath = $env:ChromeWebDriver
Write-Host "ChromeDriverPath: $ChromeDriverPath"
$EdgeDriverPath = $env:EdgeWebDriver
Write-Host "EdgeDriverPath: $EdgeDriverPath"

if (
    ($IEDriverPath -like "C:\SeleniumWebDrivers\IEDriver") -and
    ($GeckoDriverPath -like "C:\SeleniumWebDrivers\GeckoDriver") -and
    ($ChromeDriverPath -like "C:\SeleniumWebDrivers\ChromeDriver") -and
    ($EdgeDriverPath -like "C:\SeleniumWebDrivers\EdgeDriver")
)
{
    Write-Host "IEDriver installed at "
    (Get-Item "$IEDriverPath\IEDriverServer.exe").VersionInfo

    Write-Host "Gecko Driver installed at "
    (Get-Item "$GeckoDriverPath\geckodriver.exe").VersionInfo

    Write-Host "Chrome Driver installed at "
    (Get-Item "$ChromeDriverPath\chromedriver.exe").VersionInfo

    Write-Host "Edge Driver installed at "
    (Get-Item "$EdgeDriverPath\msedgedriver.exe").VersionInfo
}
else
{
    Write-Host "Selenium Web Drivers are not installed."
    exit 1
}
