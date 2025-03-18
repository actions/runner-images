Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe "Node.js" {
    It "Node.js is installed" {
        "node --version" | Should -ReturnZeroExitCode
    }

    It "Node.js version should correspond to the version in the toolset" {
        node --version | Should -BeLike "v$((Get-ToolsetContent).node.default)*"
    }

    It "NPM is installed" {
        "npm --version" | Should -ReturnZeroExitCode
    }

    It "Yarn is installed" {
        "yarn --version" | Should -ReturnZeroExitCode
    }
}

Describe "Global NPM Packages" {
    $globalNpmPackages = (Get-ToolsetContent).npm.global_packages
    $globalNpmPackagesWithTests = $globalNpmPackages | Where-Object { $_.test } | ForEach-Object { @{ Name = $_.name; Test = $_.test } }

    It "<Name>" -TestCases $globalNpmPackagesWithTests {
        $Test | Should -ReturnZeroExitCode
    }
}
