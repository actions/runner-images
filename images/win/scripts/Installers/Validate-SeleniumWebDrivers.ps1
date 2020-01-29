################################################################################
##  File:  Validate-Chrome.ps1
##  Desc:  Validate Google Chrome installation.
################################################################################

$IEDriverPath = $env:IEWebDriver
$GeckoDriverPath = $env:GeckoWebDriver
$ChromeDriverPath = $env:ChromeWebDriver
$EdgeDriverPath = $env:EdgeWebDriver

if (
	($IEDriverPath -like "C:\SeleniumWebDrivers\IEDriver") -and
	($GeckoDriverPath -like "C:\SeleniumWebDrivers\GeckoDriver") -and
	($ChromeDriverPath -like "C:\SeleniumWebDrivers\ChromeDriver") -and
	($EdgeDriverPath -like "C:\SeleniumWebDrivers\EdgeDriver")
)
{

	Write-Host "IEDriver installed at "
	(Get-Item "C:\SeleniumWebDrivers\IEDriver\IEDriverServer.exe").VersionInfo


	Write-Host "Gecko Driver installed at "
	(Get-Item "C:\SeleniumWebDrivers\GeckoDriver\geckodriver.exe").VersionInfo


	Write-Host "Chrome Driver installed at "
	(Get-Item "C:\SeleniumWebDrivers\ChromeDriver\chromedriver.exe").VersionInfo


	Write-Host "Edge Driver installed at "
	(Get-Item "C:\SeleniumWebDrivers\EdgeDriver\msedgedriver.exe").VersionInfo

	$chromedriverversion = Get-Content -Path "C:\SeleniumWebDrivers\ChromeDriver\versioninfo.txt"
	$geckodriverversion = Get-Content -Path "C:\SeleniumWebDrivers\GeckoDriver\versioninfo.txt"
	$iedriverversion = Get-Content -Path "C:\SeleniumWebDrivers\IEDriver\versioninfo.txt"
	$edgedriverversion = Get-Content -Path "C:\SeleniumWebDrivers\EdgeDriver\versioninfo.txt"

	# Adding description of the software to Markdown
	$SoftwareName = "Selenium Web Drivers"

	$Description = @"

#### Chrome Driver

_version:_
$chromedriverversion

_Environment:_
* ChromeWebDriver: location of chromedriver.exe

#### Gecko Driver

_version:_
$geckodriverversion

_Environment:_
* GeckoWebDriver: location of geckodriver.exe

#### IE Driver

_version:_
$iedriverversion

_Environment:_
* IEWebDriver: location of IEDriverServer.exe

#### Microsoft Edge Driver

_version:_
$edgedriverversion

_Environment:_
* EdgeWebDriver: location of msedgedriver.exe

"@

	Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

	exit 0
}
else
{
	Write-Host "Selenium Web Drivers are not installed."
    exit 1
}
