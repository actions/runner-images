$os = Get-OSVersion

Describe "RubyGems" {
    $gemTestCases = Get-ToolsetValue -KeyPath "ruby.rubygems" | ForEach-Object {
        @{gemName = $_}
    }

    if ($gemTestCases)
    {
        It "Gem <gemName> is installed" -TestCases $gemTestCases {
            "gem list -i '^$gemName$'" | Should -MatchCommandOutput "true"
        }
    }
}

Describe "Bundler" {
    It "Bundler" {
        "bundler --version" | Should -ReturnZeroExitCode
    }
}

Describe "Nomad shenzhen CLI" -Skip:($os.IsMonterey -or $os.IsVentura) {
    It "Nomad shenzhen CLI" {
        "ipa --version" | Should -ReturnZeroExitCode
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

Describe "jazzy" -Skip:($os.IsVentura) {
    It "jazzy" {
        "jazzy --version" | Should -ReturnZeroExitCode
    }
}