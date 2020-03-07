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

	$versionFileName = "versioninfo.txt";
	$chromedriverversion = Get-Content -Path "$ChromeDriverPath\$versionFileName"
	$geckodriverversion = Get-Content -Path "$GeckoDriverPath\$versionFileName"
	$iedriverversion = Get-Content -Path "$IEDriverPath\$versionFileName"
	$edgedriverversion = Get-Content -Path "$EdgeDriverPath\$versionFileName"

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
