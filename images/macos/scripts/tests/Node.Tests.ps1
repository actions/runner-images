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

Describe "nvm" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    BeforeAll {
        $nvmPath = Join-Path $env:HOME ".nvm" "nvm.sh"
        $nvmInitCommand = ". $nvmPath > /dev/null 2>&1 || true"
    }

    It "nvm is installed" {
        $nvmPath | Should -Exist
        "$nvmInitCommand && nvm --version" | Should -ReturnZeroExitCode
    }

    Context "nvm versions" {
        [array]$nvmVersions = (Get-ToolsetContent).node.nvm_versions
        $testCases = $nvmVersions | ForEach-Object { @{NvmVersion = $_} }

        It "<NvmVersion>" -TestCases $testCases {
            param (
                [string] $NvmVersion
            )

            "$nvmInitCommand && nvm ls $($NvmVersion)" | Should -ReturnZeroExitCode
        }
    }
}

Describe "Global NPM Packages" {
    $globalNpmPackages = (Get-ToolsetContent).npm.global_packages
    $globalNpmPackagesWithTests = $globalNpmPackages | Where-Object { $_.test } | ForEach-Object { @{ Name = $_.name; Test = $_.test } }

    It "<Name>" -TestCases $globalNpmPackagesWithTests {
        $Test | Should -ReturnZeroExitCode
    }
}
