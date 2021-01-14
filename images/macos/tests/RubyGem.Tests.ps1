$os = Get-OSVersion

Describe "Bundler" {
    It "Bundler" {
        "bundler --version" | Should -ReturnZeroExitCode
    }
}

Describe "Nomad" -Skip:($os.IsBigSur) {
    Context "Nomad" {
        It "Nomad CLI" {
            $result = Get-CommandResult "gem list"
            $result.Output | Should -BeLike "*nomad-cli*"
        }
    }
    Context "Nomad CLI" {
        It "Nomad CLI IPA" {
            "ipa --version" | Should -ReturnZeroExitCode
        }
    }
}

Describe "Fastlane" {
    It "Fastlane" {
        "fastlane --version" | Should -ReturnZeroExitCode
    }
}

Describe "xcpretty" {
    It "xcpretty" {
        "xcpretty --version" | Should -ReturnZeroExitCode
    }
}