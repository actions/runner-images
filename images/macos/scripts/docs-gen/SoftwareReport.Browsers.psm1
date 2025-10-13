function Build-BrowserSection {

    $nodes = @()
    $os = Get-OSVersion

    $nodes += @(
        [ToolVersionNode]::new("Safari", $(Get-SafariVersion))
        [ToolVersionNode]::new("SafariDriver", $(Get-SafariDriverVersion))
        [ToolVersionNode]::new("Google Chrome", $(Get-ChromeVersion))
        [ToolVersionNode]::new("Google Chrome for Testing", $(Get-ChromeForTestingVersion))
        [ToolVersionNode]::new("ChromeDriver", $(Get-ChromeDriverVersion))
        [ToolVersionNode]::new("Microsoft Edge", $(Get-EdgeVersion))
        [ToolVersionNode]::new("Microsoft Edge WebDriver", $(Get-EdgeDriverVersion))
    )

    $nodes += @(
        [ToolVersionNode]::new("Mozilla Firefox", $(Get-FirefoxVersion))
        [ToolVersionNode]::new("geckodriver", $(Get-GeckodriverVersion))
        [ToolVersionNode]::new("Selenium server", $(Get-SeleniumVersion))
    )

    return $nodes
}

function Get-SafariVersion {
    $version = Run-Command "defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString"
    $build = Run-Command "defaults read /Applications/Safari.app/Contents/Info CFBundleVersion"
    return "$version ($build)"
}

function Get-SafariDriverVersion {
    $version = Run-Command "safaridriver --version" | Take-Part -Part 3, 4
    return $version
}

function Get-ChromeVersion {
    $chromePath = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    $version = Run-Command "'${chromePath}' --version"
    return ($version -replace ("^Google Chrome")).Trim()
}

function Get-ChromeForTestingVersion {
    $chromePath = "/Applications/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"
    $version = Run-Command "'${chromePath}' --version"
    return ($version -replace ("^Google Chrome for Testing")).Trim()
}

function Get-ChromeDriverVersion {
    $rawOutput = Run-Command "chromedriver --version"
    $version = $rawOutput | Take-Part -Part 1
    return $version
}

function Get-EdgeVersion {
    $edgePath = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
    $version = Run-Command "'${edgePath}' --version"
    return ($version -replace ("^Microsoft Edge")).Trim()
}

function Get-EdgeDriverVersion {
    return Run-Command "msedgedriver --version" | Take-Part -Part 3
}

function Get-FirefoxVersion {
    $firefoxPath = "/Applications/Firefox.app/Contents/MacOS/firefox"
    $version = Run-Command "'${firefoxPath}' --version"
    return ($version -replace "^Mozilla Firefox").Trim()
}

function Get-GeckodriverVersion {
    $version = Run-Command "geckodriver --version" | Select-Object -First 1
    return ($version -replace "^geckodriver").Trim()
}

function Get-SeleniumVersion {
    $os = Get-OSVersion
    if ($os.IsArm64) {
        $cellarPath = "/opt/homebrew/Cellar"
    } else {
        $cellarPath = "/usr/local/Cellar"
    }
    $seleniumVersion = (Get-ChildItem -Path "$cellarPath/selenium-server*/*").Name
    return $seleniumVersion
}

function Build-BrowserWebdriversEnvironmentTable {
    $node = [HeaderNode]::new("Environment variables")

    $table = @(
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

    $node.AddTable($table)

    return $node
}
