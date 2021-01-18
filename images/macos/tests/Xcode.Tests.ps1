Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

$xcodeVersions = Get-ToolsetValue "xcode.versions"
$defaultXcode = Get-ToolsetValue "xcode.default"
$latestXcodeVersion = $xcodeVersions | Select-Object -First 1
$os = Get-OSVersion

Describe "Xcode" {
    $testCases = $xcodeVersions | ForEach-Object { @{ XcodeVersion = $_.link; LatestXcodeVersion = $xcodeVersions[0].link; Symlinks = $_.symlinks } }

    Context "Versions" {
        It "<XcodeVersion>" -TestCases $testCases {
            $xcodebuildPath = Get-XcodeToolPath -Version $XcodeVersion -ToolName "xcodebuild"
            "$xcodebuildPath -version" | Should -ReturnZeroExitCode
        }
    }

    Context "Default" {
        $defaultXcodeTestCase = @{ DefaultXcode = $defaultXcode }
        It "Default Xcode is <DefaultXcode>" -TestCases $defaultXcodeTestCase {
            "xcodebuild -version" | Should -ReturnZeroExitCode
            (Get-CommandResult "xcodebuild -version").Output | Should -BeLike "Xcode ${DefaultXcode}*"
        }

        It "Xcode.app points to default Xcode" -TestCases $defaultXcodeTestCase {
            $xcodeApp = "/Applications/Xcode.app"
            $expectedTarget = Get-XcodeRootPath -Version $DefaultXcode
            $xcodeApp | Should -Exist
            $expectedTarget | Should -Exist
            (Get-Item $xcodeApp).Target | Should -Be $expectedTarget
        }
    }

    Context "Additional tools" {
        It "Xcode <XcodeVersion> tools are installed" -TestCases $testCases -Skip:($os.IsHighSierra) {
            $TOOLS_NOT_INSTALLED_EXIT_CODE = 69
            $xcodebuildPath = Get-XcodeToolPath -Version $XcodeVersion -ToolName "xcodebuild"
            $result = Get-CommandResult "$xcodebuildPath -checkFirstLaunchStatus"

            if ($XcodeVersion -ne $LatestXcodeVersion) {
                $result.ExitCode | Should -Not -Be $TOOLS_NOT_INSTALLED_EXIT_CODE
            } else {
                $result.ExitCode | Should -BeIn (0, $TOOLS_NOT_INSTALLED_EXIT_CODE)
            }
        }
    }

    Context "Symlinks" {
        It "Xcode <XcodeVersion> has correct symlinks" -TestCases $testCases {
            $sourcePath = Get-XcodeRootPath -Version $XcodeVersion
            $Symlinks | Where-Object { $_ } | ForEach-Object {
                $targetPath = Get-XcodeRootPath -Version $_
                $targetPath | Should -Exist
                (Get-Item $targetPath).Target | Should -Be $sourcePath
            }
        }
    }

    It "/Applications/Xcode* symlinks are valid" {
        $symlinks = Get-ChildItem "/Applications" -Filter "Xcode*" | Where-Object { $_.LinkType }

        $symlinks.Target | ForEach-Object {
            $_ | Should -Exist
        }
    }
}

Describe "XCODE_DEVELOPER_DIR variables" {
    $exactVersionsList = $xcodeVersions.link | Where-Object { Test-XcodeStableRelease -Version $_ } | ForEach-Object {
        $xcodeRootPath = Get-XcodeRootPath -Version $_
        $xcodeVersionInfo = Get-XcodeVersionInfo -XcodeRootPath $xcodeRootPath
        return @{
            RootPath = $xcodeRootPath
            Version = [SemVer]::Parse($xcodeVersionInfo.Version)
        }
    } | Sort-Object -Property Version -Descending
    $majorVersions = $exactVersionsList.Version.Major | Select-Object -Unique
    $testCases = $majorVersions | ForEach-Object { @{ MajorVersion = $_; VersionsList = $exactVersionsList } }

    It "XCODE_<MajorVersion>_DEVELOPER_DIR" -TestCases $testCases {
        $variableName = "XCODE_${MajorVersion}_DEVELOPER_DIR"
        $actualPath = Get-EnvironmentVariable $variableName
        $expectedVersion = $VersionsList | Where-Object { $_.Version.Major -eq $MajorVersion } | Select-Object -First 1
        $expectedPath = "$($expectedVersion.RootPath)/Contents/Developer"
        $actualPath | Should -Exist
        $actualPath | Should -Be $expectedPath
    }
}

Describe "Xcode simulators" {
    $xcodeVersions.link | Where-Object { Test-XcodeStableRelease -Version $_ } | ForEach-Object {
        Context "$_" {
            $testCase = @{ XcodeVersion = $_ }
            It "No duplicates in devices" -TestCases $testCase {
                Switch-Xcode -Version $XcodeVersion
                [array]$devicesList = @(Get-XcodeDevicesList | Where-Object { $_ })
                Validate-ArrayWithoutDuplicates $devicesList -Because "Found duplicate device simulators"
            }

            It "No duplicates in pairs" -TestCases $testCase {
                Switch-Xcode -Version $XcodeVersion
                [array]$pairsList = @(Get-XcodePairsList | Where-Object { $_ })
                Validate-ArrayWithoutDuplicates $pairsList -Because "Found duplicate pairs simulators"
            }
        }
    }

    AfterEach {
        $defaultXcode = Get-ToolsetValue "xcode.default"
        Switch-Xcode -Version $defaultXcode
    }
}