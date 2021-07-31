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
    $globalNpmPackagesWithTests = $globalNpmPackages.global_packages | Where-Object { $_.test }

    Context "Global NPM Packages" {
        It "<name>" -TestCases $globalNpmPackagesWithTests {
            $test | Should -ReturnZeroExitCode
        }
    }
}