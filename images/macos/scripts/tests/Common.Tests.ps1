Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe ".NET" {
    $arch = Get-Architecture
    $dotnetVersions = (Get-ToolsetContent).dotnet.arch.${arch}.versions

    Context "Default" {
        It "Default Dotnet SDK is available" {
            "dotnet --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Latest" {
        $latestVersion = @($dotnetVersions | Sort-Object { [Version] $_ })[-1]
        $dotnetLatest = @{ dotnetVersion = $latestVersion }

        It "Latest SDK $latestVersion is available" -TestCases $dotnetLatest {
            (dotnet --list-sdks | Where-Object { $_ -match "${dotnetVersion}\.[0-9]*" }).Count | Should -BeGreaterThan 0
        }

        It "Default 'dotnet --version' resolves to the latest SDK $latestVersion" -TestCases $dotnetLatest {
            (dotnet --version) | Should -BeLike "${dotnetVersion}.*"
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
        $dotnetTools = (Get-ToolsetContent).dotnet.tools
        $testCases = @($dotnetTools | Where-Object { $_ } | ForEach-Object { @{ ToolName = $_.name; TestInstance = $_.test } })

        if ($testCases.Count -gt 0) {
            $env:PATH = "$HOME/.dotnet/tools:$env:PATH"

            It "<ToolName> is available" -TestCases $testCases {
                "$TestInstance" | Should -ReturnZeroExitCode
            }
        } else {
            It "has no dotnet tools defined in toolset" -Skip:$true {}
        }
    }
}

Describe "GCC" {
    $testCases = (Get-ToolsetContent).gcc.versions | ForEach-Object { @{Version = $_ } }

    It "GCC <Version>" -TestCases $testCases {
        param (
            [string] $Version
        )

        "gcc-$Version --version" | Should -ReturnZeroExitCode
    }

    It "Gfortran <Version>" -TestCases $testCases {
        param (
            [string] $Version
        )

        "gfortran-$Version --version" | Should -ReturnZeroExitCode
    }

    It "Gfortran is not found in the default path" {
        "$(which gfortran)" | Should -BeNullOrEmpty
    }
}

Describe "vcpkg" {
    It "vcpkg" {
        "vcpkg version" | Should -ReturnZeroExitCode
    }
}

Describe "AWS" {
    It "AWS CLI" {
        "aws --version" | Should -ReturnZeroExitCode
    }
    It "AWS SAM CLI" {
        "sam --version" | Should -ReturnZeroExitCode
    }

    It "AWS Session Manager CLI" {
        "session-manager-plugin --version" | Should -ReturnZeroExitCode
    }
}

Describe "AzCopy" {
    It "AzCopy" {
        "azcopy --version" | Should -ReturnZeroExitCode
    }
}

Describe "CocoaPods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "CodeQL Bundle" {
    It "Is installed" {
        $CodeQLVersionWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
        $CodeQLVersionPath = Get-ChildItem $CodeQLVersionWildcard | Select-Object -First 1 -Expand FullName
        $CodeQLPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
        "$CodeQLPath version --quiet" | Should -ReturnZeroExitCode

        $CodeQLPacksPath = Join-Path $CodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "qlpacks"
        $CodeQLPacksPath | Should -Exist
    }
}

Describe "Unxip" {
    It "Unxip" {
        "unxip --version" | Should -ReturnZeroExitCode
    }
}

Describe "Sudoers" {
    It "Sudo Cache" {
        "sudo -v" | Should -ReturnZeroExitCode
    }
    It "Sudoers files" {
        "sudo visudo -c" | Should -ReturnZeroExitCode
    }
}
