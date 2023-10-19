function Get-ChromeVersion {
    $googleChromeVersion = google-chrome --version | Take-OutputPart -Part 2
    return $googleChromeVersion
}

function Get-ChromeDriverVersion {
    $chromeDriverVersion = chromedriver --version | Take-OutputPart -Part 1
    return $chromeDriverVersion
}

function Get-FirefoxVersion {
    $firefoxVersion = $(firefox --version) | Take-OutputPart -Part 2
    return $firefoxVersion
}

function Get-GeckodriverVersion {
    $geckodriverVersion = geckodriver --version | Select-Object -First 1 | Take-OutputPart -Part 1
    return $geckodriverVersion
}

function Get-ChromiumVersion {
    $chromiumVersion = chromium-browser --version | Take-OutputPart -Part 1
    return $chromiumVersion
}

function Get-EdgeVersion {
    $edgeVersion = (microsoft-edge --version).Trim() | Take-OutputPart -Part 2
    return $edgeVersion
}

function Get-EdgeDriverVersion {
    $edgeDriverVersion = msedgedriver --version | Take-OutputPart -Part 3
    return $edgeDriverVersion
}

function Get-SeleniumVersion {
    $seleniumBinaryName = Get-ToolsetValue "selenium.binary_name"
    $fullSeleniumVersion = (Get-ChildItem "/usr/share/java/${seleniumBinaryName}-*").Name -replace "${seleniumBinaryName}-"
    return $fullSeleniumVersion
}

function Build-BrowserWebdriversEnvironmentTable {
    return @(
        [PSCustomObject] @{
            "Name" = "CHROMEWEBDRIVER"
            "Value" = $env:CHROMEWEBDRIVER
        },
        [PSCustomObject] @{
            "Name" = "EDGEWEBDRIVER"
            "Value" = $env:EDGEWEBDRIVER
        },
        [PSCustomObject] @{
            "Name" = "GECKOWEBDRIVER"
            "Value" = $env:GECKOWEBDRIVER
        },
        [PSCustomObject] @{
            "Name" = "SELENIUM_JAR_PATH"
            "Value" = $env:SELENIUM_JAR_PATH
        }
    )
}
