Describe "Node.JS" {
    Context "Basic modules"{
        It "<ToolName> " -TestCases @(
            @{ ToolName = "node" }
            @{ ToolName = "npm" }
        ) {
        "$ToolName --version" | Should -ReturnZeroExitCode
        }
    }

    $npmToolset = (Get-ToolsetContent).npm
    $globalNpmPackages = $npmToolset.global_packages | Where-Object { $_.test } | ForEach-Object { $_.test }

    Context "Global NPM Packages" {
        It "<ToolName> " -TestCases $globalNpmPackages {
            $test | Should -ReturnZeroExitCode
        }
    }
}