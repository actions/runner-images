Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Dotnet and tools" {

    BeforeAll {
        $dotnetSDKs = dotnet --list-sdks | ConvertTo-Json
        $dotnetRuntimes = dotnet --list-runtimes | ConvertTo-Json
    }
    
    $dotnetVersions = (Get-ToolsetContent).dotnet.versions

    Context "Default" {
        It "Default Dotnet SDK is available" {
            "dotnet --version" | Should -ReturnZeroExitCode
        }
    }

    foreach ($version in $dotnetVersions) {
        Context "Dotnet $version" {
            $dotnet = @{ dotnetVersion = $version }

            It "SDK $version is available" -TestCases $dotnet {
                $dotnetSDKs | Should -Match "$dotnetVersion.[1-9]*"
            }

            It "Runtime $version is available" -TestCases $dotnet {
                $dotnetRuntimes | Should -Match "$dotnetVersion.[1-9]*"
            }
        }
    }

    $dotnetTools = (Get-ToolsetContent).dotnet.tools
    foreach ($dotnetTool in $dotnetTools) {
        Context "Dotnet tool $dotnetTool.name" {
            It "dotnet tool '$dotnetTool.name' is available" {
                $dotnetTool.test | Should -Not -BeNullOrEmpty
            }
        }
    }
}