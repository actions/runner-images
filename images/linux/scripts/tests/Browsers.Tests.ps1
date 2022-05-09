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
}

Describe "Chromium" {
    It "Chromium" {
        "chromium-browser --version" | Should -ReturnZeroExitCode
    }
} 
