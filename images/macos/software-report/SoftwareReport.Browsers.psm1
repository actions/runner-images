using module ./../helpers/SoftwareReport.Helpers.psm1

function Get-BrowserSection {
    param (
        [ArchiveItems] $Archive
    )

    $output = @(
        ((Get-SafariVersion), "Safari"),
        ((Get-SafariDriverVersion), "SafariDriver"),
        ((Get-ChromeVersion), "Chrome"),
        ((Get-ChromeDriverVersion), "ChromeDriver"),
        ((Get-EdgeVersion), "Edge"),
        ((Get-EdgeDriverVersion), "EdgeDriver"),
        ((Get-FirefoxVersion), "Firefox"),
        ((Get-GeckodriverVersion), "GeckoDriver"),
        ((Get-SeleniumVersion), "Selenium")
    )
    $outputTitles = $output | ForEach-Object {$archive.Add($_)}

    return New-MDList -Style Unordered -Lines $outputTitles
}

function Get-SafariVersion {
    $version = Run-Command "defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString"
    $build = Run-Command "defaults read /Applications/Safari.app/Contents/Info CFBundleVersion"
    "Safari $version ($build)"
}

function Get-SafariDriverVersion {
    $version = Run-Command "safaridriver --version" | Take-Part -Part 3,4
    "SafariDriver $version"
}

function Get-ChromeVersion {
    $chromePath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    return Run-Command "'${chromePath}' --version"
}

function Get-ChromeDriverVersion {
    $rawOutput = Run-Command "chromedriver --version"
    $version = $rawOutput | Take-Part -Part 1
    return "ChromeDriver ${version}"
}

function Get-EdgeVersion {
    $edgePath = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
    return Run-Command "'${edgePath}' --version"
}

function Get-EdgeDriverVersion {
    return Run-Command "msedgedriver --version" | Take-Part -Part 0,1,2,3
}

function Get-FirefoxVersion {
    $firefoxPath = "/Applications/Firefox.app/Contents/MacOS/firefox"
    return Run-Command "'${firefoxPath}' --version"
}

function Get-GeckodriverVersion {
    return Run-Command "geckodriver --version" | Select-Object -First 1
}

function Get-SeleniumVersion {
    $seleniumVersion = (Get-ChildItem -Path "/usr/local/Cellar/selenium-server*/*").Name
    return "Selenium server $seleniumVersion"
}

function Build-BrowserWebdriversEnvironmentTable {
    param (
        [ArchiveItems] $Archive
    )

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
        $Archive.Add("$($_.Name)|$($_.Value)", "Env_$($_.Name)") | Out-Null
    }
}
