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

Describe "vcpkg" -Skip:($os.IsVenturaArm64 -or $os.IsSonoma -or $os.IsSequoia) {
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

Describe "Miniconda" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Conda" {
        [System.Environment]::GetEnvironmentVariable("CONDA") | Should -Not -BeNullOrEmpty
        $condaBinPath = Join-Path $env:CONDA "bin" "conda"
        "$condaBinPath --version" | Should -ReturnZeroExitCode
    }
}

Describe "Stack" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Stack" {
        "stack --version" | Should -ReturnZeroExitCode
    }
}

Describe "CocoaPods" {
    It "CocoaPods" {
        "pod --version" | Should -ReturnZeroExitCode
    }
}

Describe "VSMac" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    $vsMacVersions = (Get-ToolsetContent).xamarin.vsmac.versions
    $defaultVSMacVersion = (Get-ToolsetContent).xamarin.vsmac.default

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

Describe "Swig" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Swig" {
        "swig -version" | Should -ReturnZeroExitCode
    }
}

Describe "Bicep" {
    It "Bicep" {
        "bicep --version" | Should -ReturnZeroExitCode
    }
}

Describe "Go" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Go" {
        "go version" | Should -ReturnZeroExitCode
    }
}

Describe "VirtualBox" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Check kext kernel modules" {
        kextstat | Out-String | Should -Match "org.virtualbox.kext"
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

Describe "Colima" -Skip:($os.IsVentura -or $os.IsSonoma -or $os.IsSequoia) {
    It "Colima" {
        "colima version" | Should -ReturnZeroExitCode
    }
}

Describe "Compiled" -Skip:(-not $os.IsMonterey) {
    It "Apache Ant" {
        "ant -version" | Should -ReturnZeroExitCode
    }

    $kotlinPackages = @("kapt", "kotlin", "kotlinc", "kotlinc-jvm", "kotlin-dce-js")

    It "<toolName> is available" -TestCases ($kotlinPackages | ForEach-Object { @{ toolName = $_ } }) {
        "$toolName -version" | Should -ReturnZeroExitCode
    }

    It "sbt" {
        "sbt -version" | Should -ReturnZeroExitCode
    }
}

Describe "Unxip" {
    It "Unxip" {
        "unxip --version" | Should -ReturnZeroExitCode
    }
}
