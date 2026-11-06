Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Xcode.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$arch = Get-Architecture
$xcodeVersions = (Get-ToolsetContent).xcode.${arch}.versions
$defaultXcode = (Get-ToolsetContent).xcode.default
$latestXcodeVersion = $xcodeVersions | Select-Object -First 1
$os = Get-OSVersion

Describe "Xcode" {
    $testCases = $xcodeVersions | ForEach-Object {
        @{
            XcodeVersion = $_.link;
            LatestXcodeVersion = $xcodeVersions[0].link;
            Symlinks = $_.symlinks
        }
    }

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
            If ($DefaultXcode -ilike "*_*") {
                Write-Host "Composite version detected (beta/RC/preview)"
                $DefaultXcode = $DefaultXcode.split("_")[0]
                If ($DefaultXcode -notlike "*.*") {
                    $DefaultXcode = "${DefaultXcode}.0"
                }
            }
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
        It "Xcode <XcodeVersion> tools are installed" -TestCases $testCases {
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
        $actualPath = [System.Environment]::GetEnvironmentVariable($variableName)
        $expectedVersion = $VersionsList | Where-Object { $_.Version.Major -eq $MajorVersion } | Select-Object -First 1
        $expectedPath = "$($expectedVersion.RootPath)/Contents/Developer"
        $actualPath | Should -Exist
        $actualPath | Should -Be $expectedPath
    }
}

Describe "Xcode Command Line Tools" {
    $cltVersion = (Get-ToolsetContent).xcode.command_line_tools
    $cltTestCase = @{
        CltVersion = $cltVersion
        CltSdkPath = "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"
    }

    It "Command Line Tools version matches toolset" -TestCases $cltTestCase -Skip:(-not $cltVersion) {
        $installedVersion = (Get-CommandResult "pkgutil --pkg-info com.apple.pkg.CLTools_Executables | awk '/^version:/ {print `$2}'").Output.Trim()
        ($installedVersion -eq $CltVersion -or $installedVersion -like "${CltVersion}.*") | Should -BeTrue -Because "installed version is '$installedVersion'"
    }

    # Tools like GHC hardcode the CLT SDK library path, so the default Xcode linker must be able to read it
    # https://github.com/actions/runner-images/issues/14940
    It "Default Xcode toolchain links against Command Line Tools SDK libraries" -TestCases $cltTestCase -Skip:(-not $cltVersion) {
        $binaryPath = "/tmp/clt-sdk-link-test"
        "echo 'int main(void) { return 0; }' | env -u SDKROOT /usr/bin/clang -x c - -L${CltSdkPath}/usr/lib -lffi -liconv -o $binaryPath && $binaryPath" | Should -ReturnZeroExitCode
        Remove-Item -Path $binaryPath -Force -ErrorAction SilentlyContinue
    }
}

Describe "Xcode simulators" {
    $xcodeVersions.link | Where-Object { Test-XcodeStableRelease -Version $_ } | ForEach-Object {
        Context "$_" {
            $testCase = @{ XcodeVersion = $_ }
            It "No duplicates in devices" -TestCases $testCase {
                Switch-Xcode -Version $XcodeVersion
                [array]$devicesList = @(Get-XcodeDevicesList | Where-Object { $_ })
                Write-Host "Devices for $XcodeVersion"
                Write-Host ($devicesList -join "`n")
                Confirm-ArrayWithoutDuplicates $devicesList -Because "Found duplicate device simulators"
            }
        }
    }

    AfterEach {
        $defaultXcode = (Get-ToolsetContent).xcode.default
        Switch-Xcode -Version $defaultXcode
    }
}
