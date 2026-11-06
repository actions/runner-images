Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Dotnet and tools" {
    BeforeAll {
        $env:PATH = "/etc/skel/.dotnet/tools:$($env:PATH)"
        $dotnetSDKs = dotnet --list-sdks | ConvertTo-Json
        $dotnetRuntimes = dotnet --list-runtimes | ConvertTo-Json
    }

    $dotnetVersions = (Get-ToolsetContent).dotnet.versions

    Context "Default" {
        It "Default Dotnet SDK is available" {
            "dotnet --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Latest" {
        $latestVersion = @($dotnetVersions | Sort-Object { [Version] $_ })[-1]
        $dotnetLatest = @{ dotnetVersion = $latestVersion }

        It "Latest SDK <dotnetVersion> is available" -TestCases $dotnetLatest {
            $dotnetSDKs | Should -Match "$dotnetVersion.[1-9]*"
        }

        It "Default 'dotnet --version' resolves to the latest SDK <dotnetVersion>" -TestCases $dotnetLatest {
            (dotnet --version) | Should -BeLike "$dotnetVersion.*"
        }
    }

    foreach ($version in $dotnetVersions) {
        Context "Dotnet $version" {
            $dotnet = @{ dotnetVersion = $version }

            It "SDK <dotnetVersion> is available" -TestCases $dotnet {
                $dotnetSDKs | Should -Match "$dotnetVersion.[1-9]*"
            }

            It "Runtime <dotnetVersion> is available" -TestCases $dotnet {
                $dotnetRuntimes | Should -Match "$dotnetVersion.[1-9]*"
            }
        }
    }

    Context "Dotnet tools" {
        $dotnetTools = (Get-ToolsetContent).dotnet.tools
        $testCases = $dotnetTools | ForEach-Object { @{ ToolName = $_.name; TestInstance = $_.test }}

        It "<ToolName> is available" -TestCases $testCases {
            "$TestInstance" | Should -ReturnZeroExitCode
        }
    }
}
