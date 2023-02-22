Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

Describe ".NET" {
    It ".NET" {
        "dotnet --version" | Should -ReturnZeroExitCode
    }
}

Describe "GCC" {
    $testCases = Get-ToolsetValue -KeyPath gcc.versions | ForEach-Object { @{Version = $_} }

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

Describe "Miniconda" {
    It "Conda" {
        Get-EnvironmentVariable "CONDA" | Should -Not -BeNullOrEmpty
        $condaBinPath = Join-Path $env:CONDA "bin" "conda"
        "$condaBinPath --version" | Should -ReturnZeroExitCode
    }
}

Describe "Stack" {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "CocoaPods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "VSMac" {
    $vsMacVersions = Get-ToolsetValue "xamarin.vsmac.versions"
    $defaultVSMacVersion = Get-ToolsetValue "xamarin.vsmac.default"

    $testCases = $vsMacVersions | ForEach-Object {
        $vsPath = "/Applications/Visual Studio $_.app"
        if ($_ -eq $defaultVSMacVersion) {
            $vsPath = "/Applications/Visual Studio.app"
        }

        @{ vsversion = $_ ; vspath = $vsPath }
    }

    It "Visual Studio <vsversion> for Mac is installed" -TestCases $testCases {
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }

    It "Visual Studio $defaultVSMacVersion for Mac is default" {
        $vsPath = "/Applications/Visual Studio.app"
        $vstoolPath = Join-Path $vsPath "Contents/MacOS/vstool"
        $vsPath | Should -Exist
        $vstoolPath | Should -Exist
    }
}

Describe "Swig" {
    It "Swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "Go" {
    It "Go" {
        "go version" | Should -ReturnZeroExitCode
    }
}

Describe "GraalVM" {
    It "graalvm" {
        '$GRAALVM_11_ROOT/java -version' | Should -ReturnZeroExitCode
    }

    It "native-image" {
        '$GRAALVM_11_ROOT/native-image --version' | Should -ReturnZeroExitCode
    }
}

Describe "VirtualBox" -Skip:($os.IsBigSur) {
    It "Check kext kernel modules" {
        kextstat | Out-String | Should -Match "org.virtualbox.kext"
    }
}

Describe "CodeQLBundles" {
    It "Latest CodeQL Bundle" {
        $CodeQLVersionWildcards = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
        $LatestCodeQLVersionPath = Get-ChildItem $CodeQLVersionWildcards | Sort-Object -Property { [SemVer]$_.name } -Descending | Select-Object -First 1 -Expand FullName
        $LatestCodeQLPath = Join-Path $LatestCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
        "$LatestCodeQLPath version --quiet" | Should -ReturnZeroExitCode

        $LatestCodeQLPacksPath = Join-Path $LatestCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "qlpacks"
        $LatestCodeQLPacksPath | Should -Exist
    }

    It "Prior CodeQL Bundle" {
        $CodeQLVersionWildcards = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
        $PriorCodeQLVersionPath = Get-ChildItem $CodeQLVersionWildcards | Sort-Object -Property { [SemVer]$_.name } -Descending | Select-Object -Last 1 -Expand FullName
        $PriorCodeQLPath = Join-Path $PriorCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
        "$PriorCodeQLPath version --quiet" | Should -ReturnZeroExitCode

        $PriorCodeQLPacksPath = Join-Path $PriorCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "qlpacks"
        $PriorCodeQLPacksPath | Should -Exist
    }

    It "Latest and Prior CodeQL Bundles are unique" {
        $CodeQLVersionWildcards = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"

        $LatestCodeQLVersionPath = Get-ChildItem $CodeQLVersionWildcards | Sort-Object -Property { [SemVer]$_.name } -Descending | Select-Object -First 1 -Expand FullName
        $LatestCodeQLPath = Join-Path $LatestCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
        $LatestCodeQLVersion = & $LatestCodeQLPath version --quiet

        $PriorCodeQLVersionPath = Get-ChildItem $CodeQLVersionWildcards | Sort-Object -Property { [SemVer]$_.name } -Descending | Select-Object -Last 1 -Expand FullName
        $PriorCodeQLPath = Join-Path $PriorCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql"
        $PriorCodeQLVersion = & $PriorCodeQLPath version --quiet

        $LatestCodeQLVersion | Should -Not -Match $PriorCodeQLVersion
    }
}

Describe "Colima" {
    It "Colima" {
        "colima version" | Should -ReturnZeroExitCode
    }
}
