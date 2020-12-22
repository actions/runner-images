Describe "Firefox" {
    It "Firefox" {
        "/usr/lib/firefox/firefox --version" | Should -ReturnZeroExitCode
    }

    It "Geckodriver" {
        "geckodriver --version" | Should -ReturnZeroExitCode
    }
}

Describe "Chrome" {
    It "Chrome" {
        "/usr/bin/google-chrome --version" | Should -ReturnZeroExitCode
    }

    It "Chrome Driver" {
        "chromedriver --version" | Should -ReturnZeroExitCode
    }
}