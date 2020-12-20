Describe "xcpretty" {
    It "xcpretty" {
    "xcpretty --version" | Should -ReturnZeroExitCode
    }
}

Describe "Fastlane" {
    It "Fastlane" {
        "fastlane --version" | Should -ReturnZeroExitCode
    }
}

Describe "Bundler" {
    It "Bundler" {
        "bundler --version" | Should -ReturnZeroExitCode
    }
}

Describe "Cocoapods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "Nomad" -Skip:($os.IsBigSur) {
    It "Nomad CLI" {
        $result = Get-CommandResult "gem list"
        $result.Output | Should -BeLike "*nomad-cli*"
    }

    It "Nomad CLI IPA" {
        "ipa --version" | Should -ReturnZeroExitCode
    }
}