$dotnetVersions = (Get-ToolsetContent).dotnet.versions
$dotnetTools = (Get-ToolsetContent).dotnet.tools

Describe "Dotnet SDK and tools" {

    Context "Default" {
        It "Default Dotnet SDK is available" {
            "dotnet --version" | Should -ReturnZeroExitCode
        }
    }

    foreach ($version in $dotnetVersions) {
        Context "Dotnet $version" {
            $dotnet = @{ dotnetVersion = $version }

            It "SDK $version is available" -TestCases $dotnet {
                (dotnet --list-sdks | Where-Object { $_ -match "${dotnetVersion}\.[0-9]*" }).Count | Should -BeGreaterThan 0
            }

            It "Runtime $version is available" -TestCases $dotnet {
                (dotnet --list-runtimes | Where-Object { $_ -match "${dotnetVersion}\.[0-9]*" }).Count | Should -BeGreaterThan 0
            }
        }
    }

    Context "Dotnet tools" {
        $env:Path += ";C:\Users\Default\.dotnet\tools"
        $testCases = $dotnetTools | ForEach-Object { @{ ToolName = $_.name; TestInstance = $_.test }}

        It "<ToolName> is available" -TestCases $testCases {
            "$TestInstance" | Should -ReturnZeroExitCode
        }
    }
}
