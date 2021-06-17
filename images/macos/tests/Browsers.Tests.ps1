Describe "Chrome" {
    It "Chrome" {
        $chromeLocation = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        $chromeLocation | Should -Exist
        "'$chromeLocation' --version" | Should -ReturnZeroExitCode
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

Describe "Firefox" {
    It "Firefox" {
        $firefoxLocation = "/Applications/Firefox.app/Contents/MacOS/firefox"
        $firefoxLocation | Should -Exist
        "'$firefoxLocation' --version" | Should -ReturnZeroExitCode
    }
    It "Geckodriver" {
        "geckodriver --version" | Should -ReturnZeroExitCode
    }
}