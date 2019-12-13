################################################################################
##  File:  Install-SeleniumWebDrivers.ps1
##  Desc:  Install Selenium Web Drivers
################################################################################

Invoke-WebRequest -UseBasicParsing -Uri "https://seleniumwebdrivers.blob.core.windows.net/seleniumwebdrivers/SeleniumWebDrivers.zip" -OutFile SeleniumWebDrivers.zip

Expand-Archive -Path SeleniumWebDrivers.zip -DestinationPath "C:\" -Force

Remove-Item SeleniumWebDrivers.zip

setx IEWebDriver "C:\SeleniumWebDrivers\IEDriver" /M
setx GeckoWebDriver "C:\SeleniumWebDrivers\GeckoDriver" /M
setx ChromeWebDriver "C:\SeleniumWebDrivers\ChromeDriver" /M

exit 0

