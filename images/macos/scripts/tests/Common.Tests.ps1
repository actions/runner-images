Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe ".NET" {
    It ".NET" {
        "dotnet --version" | Should -ReturnZeroExitCode
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

Describe "vcpkg" -Skip:($os.IsVenturaArm64) {
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
