function Get-ChromeVersion {
    $googleChromeVersion = google-chrome --version | Take-Part -Part 2
    return "Google Chrome $googleChromeVersion"
}

function Get-ChromeDriverVersion {
    $chromeDriverVersion = chromedriver --version | Take-Part -Part 1
    return "ChromeDriver $chromeDriverVersion"
}

function Get-FirefoxVersion {
    $firefoxVersion = firefox --version
    return $firefoxVersion
}

function Get-GeckodriverVersion {
    $geckodriverVersion = geckodriver --version | Select-Object -First 1 | Take-Part -Part 1
    return "Geckodriver $geckodriverVersion"
}