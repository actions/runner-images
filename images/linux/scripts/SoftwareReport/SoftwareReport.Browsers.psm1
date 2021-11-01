function Get-ChromeVersion {
    $googleChromeVersion = google-chrome --version | Take-OutputPart -Part 2
    return "Google Chrome $googleChromeVersion"
}

function Get-ChromeDriverVersion {
    $chromeDriverVersion = chromedriver --version | Take-OutputPart -Part 1
    return "ChromeDriver $chromeDriverVersion"
}

function Get-FirefoxVersion {
    $firefoxVersion = firefox --version
    return $firefoxVersion
}

function Get-GeckodriverVersion {
    $geckodriverVersion = geckodriver --version | Select-Object -First 1 | Take-OutputPart -Part 1
    return "Geckodriver $geckodriverVersion"
}

function Get-ChromiumVersion {
    $chromiumVersion = chromium-browser --version | Take-OutputPart -Part 0,1
    return $chromiumVersion
}

function Get-SeleniumVersion {
    $seleniumBinaryName = Get-ToolsetValue "selenium.binary_name"
    $fullSeleniumVersion = (Get-ChildItem "/usr/share/java/${seleniumBinaryName}-*").Name -replace "${seleniumBinaryName}-"
    return "Selenium server $fullSeleniumVersion"
}

function Build-BrowserWebdriversEnvironmentTable {
    return @(
        @{
            "Name" = "CHROMEWEBDRIVER"
            "Value" = $env:CHROMEWEBDRIVER
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
