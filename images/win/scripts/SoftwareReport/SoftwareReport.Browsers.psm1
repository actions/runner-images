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

function Get-BrowserVersion {
    param(
        [string] $Browser
    )
    $browserName = $browsers.$Browser.Name
    $browserFile = $browsers.$Browser.File
    $registryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$browserFile"
    $browserVersion = (Get-Item (Get-ItemProperty $registryKey)."(Default)").VersionInfo.FileVersion
    return "$browserName $browserVersion"
}

function Get-SeleniumWebDriverVersion {
    param(
        [string] $Driver
    )
    $driverName = $webDrivers.$Driver.Name
    $driverPath = $webDrivers.$Driver.Path
    $versionFileName = "versioninfo.txt";
	$webDriverVersion = Get-Content -Path "$driverPath\$versionFileName"
    return "$driverName $webDriverVersion"
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
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}
