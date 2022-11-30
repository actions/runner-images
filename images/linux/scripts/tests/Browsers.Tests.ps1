Describe "Firefox" {
    It "Firefox" {
        "sudo -i firefox --version" | Should -ReturnZeroExitCode
    }

    It "Geckodriver" {
        "geckodriver --version" | Should -ReturnZeroExitCode
    }
}

Describe "Chrome" {
    It "Chrome" {
        "google-chrome --version" | Should -ReturnZeroExitCode
    }

    It "Chrome Driver" {
        "chromedriver --version" | Should -ReturnZeroExitCode
    }

    It "Chrome and Chrome Driver major versions are the same" {
        $chromeMajor = (google-chrome --version).Trim("Google Chrome ").Split(".")[0]
        $chromeDriverMajor = (chromedriver --version).Trim("ChromeDriver ").Split(".")[0]
        $chromeMajor | Should -BeExactly $chromeDriverMajor
    }
}

Describe "Edge" {
    It "Edge" {
        "microsoft-edge --version" | Should -ReturnZeroExitCode
    }

    It "Edge Driver" {
        "msedgedriver --version" | Should -ReturnZeroExitCode
    }
}

Describe "Chromium" {
    It "Chromium" {
        "chromium-browser --version" | Should -ReturnZeroExitCode
    }
}
