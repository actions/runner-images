$browsers = @{
    chrome = @{
        Name="Google Chrome";
        File="chrome.exe"
    };
    edge = @{
        Name="Microsoft Edge";
        File="msedge.exe"
    };
    firefox = @{
        Name="Mozilla Firefox";
        File="firefox.exe"
    }
}

$webDrivers = @{
    chrome = @{
        Name="Chrome Driver";
        Path="C:\SeleniumWebDrivers\ChromeDriver"
    };
    edge = @{
        Name="Microsoft Edge Driver";
        Path="C:\SeleniumWebDrivers\EdgeDriver"
    };
    firefox = @{
        Name="Gecko Driver";
        Path="C:\SeleniumWebDrivers\GeckoDriver"
    };
    iexplorer = @{
        Name="IE Driver";
        Path="C:\SeleniumWebDrivers\IEDriver"
    }
}

function Build-BrowserSection {
    return @(
        $(Get-BrowserVersion -Browser "chrome"),
        $(Get-SeleniumWebDriverVersion -Driver "chrome"),
        $(Get-BrowserVersion -Browser "edge"),
        $(Get-SeleniumWebDriverVersion -Driver "edge"),
        $(Get-BrowserVersion -Browser "firefox"),
        $(Get-SeleniumWebDriverVersion -Driver "firefox"),
        $(Get-SeleniumWebDriverVersion -Driver "iexplorer"),
        $(Get-SeleniumVersion)
    )
}

function Get-BrowserVersion {
    param(
        [string] $Browser
    )
    $browserName = $browsers.$Browser.Name
    $browserFile = $browsers.$Browser.File
    $registryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$browserFile"
    $browserVersion = (Get-Item (Get-ItemProperty $registryKey)."(Default)").VersionInfo.FileVersion
    return [ToolVersionNode]::new($browserName, $browserVersion)
}

function Get-SeleniumWebDriverVersion {
    param(
        [string] $Driver
    )
    $driverName = $webDrivers.$Driver.Name
    $driverPath = $webDrivers.$Driver.Path
    $versionFileName = "versioninfo.txt";
	$webDriverVersion = Get-Content -Path "$driverPath\$versionFileName"
    return [ToolVersionNode]::new($driverName, $webDriverVersion)
}

function Get-SeleniumVersion {
    $seleniumBinaryName = (Get-ToolsetContent).selenium.binary_name
    $fullSeleniumVersion = (Get-ChildItem "C:\selenium\${seleniumBinaryName}-*").Name -replace "${seleniumBinaryName}-"
    return [ToolVersionNode]::new("Selenium server", $fullSeleniumVersion)
}

function Build-BrowserWebdriversEnvironmentTable {
    return @(
        @{
            "Name" = "CHROMEWEBDRIVER"
            "Value" = $env:CHROMEWEBDRIVER
        },
        @{
            "Name" = "EDGEWEBDRIVER"
            "Value" = $env:EDGEWEBDRIVER
        },
        @{
            "Name" = "GECKOWEBDRIVER"
            "Value" = $env:GECKOWEBDRIVER
        },
        @{
            "Name" = "SELENIUM_JAR_PATH"
            "Value" = $env:SELENIUM_JAR_PATH
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}
