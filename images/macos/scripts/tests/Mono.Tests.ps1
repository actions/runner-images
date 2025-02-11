Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion

BeforeAll {
    function Get-ShortSymlink {
        param (
            [string] $Version
        )

        $versionParts = $Version.Split(".")
        return [String]::Join(".", $versionParts[0..1])
    }
}

if ($os.IsVentura -or $os.IsSonoma) {
    Describe "Mono" {
        $MONO_VERSIONS_PATH = "/Library/Frameworks/Mono.framework/Versions"
        $monoToolsetVersion = @((Get-ToolsetContent).mono.framework.version)
        $versionFolderPath = Join-Path $MONO_VERSIONS_PATH ([System.Version]::Parse($monoToolsetVersion).ToString(3))
        $testCase = @{ MonoVersion = $monoToolsetVersion; VersionFolderPath = $versionFolderPath; MonoVersionsPath = $MONO_VERSIONS_PATH }

        It "is installed" -TestCases $testCase {
            param ( [string] $VersionFolderPath )

            $monoBinPath = Join-Path $VersionFolderPath "bin" "mono"
            $VersionFolderPath | Should -Exist
            $monoBinPath | Should -Exist
        }

        It "is available via short link" -TestCases $testCase {
            param (
                [string] $MonoVersion,
                [string] $MonoVersionsPath,
                [string] $VersionFolderPath
            )

            $shortSymlink = Get-ShortSymlink $MonoVersion # only 'major.minor'
            $shortSymlinkFolderPath = Join-Path $MonoVersionsPath $shortSymlink
            if ($shortSymlink -eq "4.8") { return } # Skip this test for Mono 4.8 because it doesn't contain VERSION file
            $shortVersionPath = Join-Path $shortSymlinkFolderPath "VERSION"
            $fullVersionPath = Join-Path $VersionFolderPath "VERSION"
            Confirm-IdenticalFileContent -File1 $shortVersionPath -File2 $fullVersionPath
        }

        It "NUnit console is installed" -TestCases $testCase {
            param ( [string] $VersionFolderPath )

            $nunitPath = Join-Path $VersionFolderPath "Commands" "nunit3-console"
            $nunitPath | Should -Exist
        }

        It "Nuget is installed" -TestCases $testCase {
            param ( [string] $VersionFolderPath )

            $nugetBinaryPath = Join-Path $VersionFolderPath "lib" "mono" "nuget" "nuget.exe"
            $nugetBinaryWrapperPath = Join-Path $VersionFolderPath "bin" "nuget"
            $nugetCommandPath = Join-Path $VersionFolderPath "Commands" "nuget"
            $nugetBinaryPath | Should -Exist
            $nugetCommandPath | Should -Exist
            $nugetBinaryWrapperPath | Should -Exist
        }

        It "Nuget is valid" -TestCases $testCase {
            param ( [string] $VersionFolderPath )

            $nugetBinaryWrapperPath = Join-Path $VersionFolderPath "bin" "nuget"
            "$nugetBinaryWrapperPath" | Should -ReturnZeroExitCode
        }

        It "MSBuild is available" {
            "msbuild -version" | Should -ReturnZeroExitCode
        }
    }
}
