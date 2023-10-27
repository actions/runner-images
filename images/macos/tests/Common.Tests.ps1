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

Describe "vcpkg" -Skip:($os.IsVenturaArm64) {
    It "vcpkg" {
        "vcpkg version" | Should -ReturnZeroExitCode
    }
}

Describe "AWS" -Skip:($os.IsVenturaArm64) {
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

Describe "Miniconda" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "Conda" {
        Get-EnvironmentVariable "CONDA" | Should -Not -BeNullOrEmpty
        $condaBinPath = Join-Path $env:CONDA "bin" "conda"
        "$condaBinPath --version" | Should -ReturnZeroExitCode
    }
}

Describe "Stack" -Skip:($os.IsVenturaArm64) {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "CocoaPods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "VSMac" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
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

Describe "Swig" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "Swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "Go" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "Go" {
        "go version" | Should -ReturnZeroExitCode
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

Describe "Colima" -Skip:($os.IsVentura -or $os.IsVenturaArm64) {
    It "Colima" {
        "colima version" | Should -ReturnZeroExitCode
    }
}
