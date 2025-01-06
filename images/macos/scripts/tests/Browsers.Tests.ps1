Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "Chrome" {
    BeforeAll {
        $chromeLocation = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
        $chromeForTestingLocation = "/Applications/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"
    }

    It "Chrome" {
        $chromeLocation | Should -Exist
        "'$chromeLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Chrome for Testing" {
        $chromeForTestingLocation | Should -Exist
        "'$chromeForTestingLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Chrome Driver" {
        "chromedriver --version" | Should -ReturnZeroExitCode
    }

    It "Chrome for Testing and Chrome Driver major versions are the same" {
        $chromeMajor = (& $chromeForTestingLocation --version).Trim("Google Chrome for Testing ").Split(".")[0]
        $chromeDriverMajor = (chromedriver --version).Trim("ChromeDriver ").Split(".")[0]
        $chromeMajor | Should -BeExactly $chromeDriverMajor
    }
}

Describe "Selenium server" {
    It "Selenium server" {
        $os = Get-OSVersion
        if ($os.IsArm64) {
            $cellarPath = "/opt/homebrew/Cellar"
        } else {
            $cellarPath = "/usr/local/Cellar"
        }
        (Get-ChildItem -Path "$cellarPath/selenium-server*/*").Name | Should -BeLike "4.*"
    }
}

Describe "Edge" -Skip:($os.IsVenturaArm64 -or $os.IsSonomaArm64 -or $os.IsSequoiaArm64) {
    It "Microsoft Edge" {
        $edgeLocation = "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"
        $edgeLocation | Should -Exist
        "'$edgeLocation' --version" | Should -ReturnZeroExitCode
    }

    It "Microsoft Edge Driver" {
        "msedgedriver --version" | Should -ReturnZeroExitCode
    }
}

Describe "Firefox" -Skip:($os.IsVenturaArm64 -or $os.IsSonomaArm64 -or $os.IsSequoiaArm64) {
    It "Firefox" {
        $firefoxLocation = "/Applications/Firefox.app/Contents/MacOS/firefox"
        $firefoxLocation | Should -Exist
        "'$firefoxLocation' --version" | Should -ReturnZeroExitCode
    }
    It "Geckodriver" {
        "geckodriver --version" | Should -ReturnZeroExitCode
    }
}

Describe "Safari" {
    It "'Allow Remote Automation' option is activated" {
        $plistPath = "$env:HOME/Library/WebDriver/com.apple.Safari.plist"
        $command = "/usr/libexec/PlistBuddy -c 'print AllowRemoteAutomation' $plistPath"
        $plistPath | Should -Exist
        $commandResult = Get-CommandResult $command
        $commandResult.ExitCode | Should -Be 0
        $commandResult.Output | Should -Be "true"
    }
}
