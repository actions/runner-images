Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

$os = Get-OSVersion

Describe "RubyGems" {
    $gemTestCases = (Get-ToolsetContent).ruby.rubygems | ForEach-Object {
        @{gemName = $_}
    }

    if ($gemTestCases) {
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

Describe "Nomad shenzhen CLI" -Skip:($os.IsMonterey -or $os.IsVentura -or $os.IsSonoma) {
    It "Nomad shenzhen CLI" {
        "ipa --version" | Should -ReturnZeroExitCode
    }
}

Describe "Fastlane" {
    It "Fastlane" {
        "fastlane --version" | Should -ReturnZeroExitCode
    }
}

Describe "xcpretty" -Skip:($os.IsVentura -or $os.IsSonoma) {
    It "xcpretty" {
        "xcpretty --version" | Should -ReturnZeroExitCode
    }
}

Describe "jazzy" -Skip:($os.IsVentura -or $os.IsSonoma) {
    It "jazzy" {
        "jazzy --version" | Should -ReturnZeroExitCode
    }
}
