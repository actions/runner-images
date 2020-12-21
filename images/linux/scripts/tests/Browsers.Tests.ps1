Describe "Firefox" {
    It "Firefox" {
        "firefox --version" | Should -ReturnZeroExitCode
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

Describe "Edge" {
    It "Microsoft Edge" {
        $edgeLocation = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
        $edgeLocation | Should -Exist
        "'$edgeLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Microsoft Edge Driver" {
        "msedgedriver --version" | Should -ReturnZeroExitCode
    }
}