Describe "Node.JS" {
    Context "Basic modules"{
        It "<ToolName> " -TestCases @(
            @{ ToolName = "node" }
            @{ ToolName = "npm" }
        ) {
            "$ToolName --version" | Should -ReturnZeroExitCode
        }
    }

    $globalNpmPackages = (Get-ToolsetContent).npm.global_packages
    $globalNpmPackagesWithTests = $globalNpmPackages | Where-Object { $_.test } | ForEach-Object { @{ Name = $_.name; Test = $_.test } }

    Context "Global NPM Packages" {
        It "<Name>" -TestCases $globalNpmPackagesWithTests {
            $Test | Should -ReturnZeroExitCode
        }
    }

    Context "Node.js version" {
        It "Node.js version should correspond to the version in the toolset" {
            node --version | Should -BeLike "v$((Get-ToolsetContent).node.default)*"
        }
    }
}