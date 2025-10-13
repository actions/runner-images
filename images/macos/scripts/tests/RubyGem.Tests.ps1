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

Describe "Fastlane" {
    It "Fastlane" {
        "fastlane --version" | Should -ReturnZeroExitCode
    }
}
