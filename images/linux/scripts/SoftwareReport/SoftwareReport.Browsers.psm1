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
    $chromiumVersion = chromium --version | Take-OutputPart -Part 0,1
    return $chromiumVersion
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
        }
    ) | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}
