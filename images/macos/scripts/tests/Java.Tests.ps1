Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/Helpers.psm1" -DisableNameChecking

$os = Get-OSVersion
$arch = Get-Architecture

function Get-NativeVersionFormat {
    param($Version)
    if ($Version -in "8") {
        return "1.${Version}"
    }
    return $Version
}

Describe "Java" {
    BeforeAll {
        function Confirm-JavaVersion {
            param($JavaCommand, $ExpectedVersion)

            $commandResult = Get-CommandResult $JavaCommand
            $commandResult.ExitCode | Should -Be 0
            $matchResult = $commandResult.Output | Select-String '^openjdk version \"([\d\._]+)\"'
            $matchResult.Matches.Success | Should -BeTrue
            $version = $matchResult.Matches.Groups[1].Value
            $version | Should -BeLike "${ExpectedVersion}*"
        }
    }

    $toolsetJava = (Get-ToolsetContent).java
    $defaultVersion = $toolsetJava.$arch.default
    $jdkVersions = $toolsetJava.$arch.versions

    if ($os.IsArm64) {
        $testCases = $jdkVersions | ForEach-Object { @{ Title = $_; Version = (Get-NativeVersionFormat $_); EnvVariable = "JAVA_HOME_${_}_arm64" } }
    } else {
        $testCases = $jdkVersions | ForEach-Object { @{ Title = $_; Version = (Get-NativeVersionFormat $_); EnvVariable = "JAVA_HOME_${_}_X64" } }
    }
    $testCases += @{ Title = "Default"; Version = (Get-NativeVersionFormat $defaultVersion); EnvVariable = "JAVA_HOME" }

    $testCases | ForEach-Object {
        Context $_.Title {
            It "Version is found by 'java_home'" -TestCases $_ {
                "/usr/libexec/java_home -v${Version}" | Should -ReturnZeroExitCode
            }

            It "Java <Version>" -TestCases $_ {
                $envVariablePath = [System.Environment]::GetEnvironmentVariable($EnvVariable)
                $javaBinPath = Join-Path $envVariablePath "/bin/java"
                Confirm-JavaVersion -JavaCommand "$javaBinPath -version" -ExpectedVersion $Version
            }

            if ($_.Title -eq "Default") {
                It "Version is default" -TestCases $_ {
                    Confirm-JavaVersion -JavaCommand "java -version" -ExpectedVersion $Version
                }
            }
        }
    }

    Context "Maven" {
        Describe "Maven" {
            It "Maven" {
                "mvn --version" | Should -ReturnZeroExitCode
            }
        }
    }

    Context "Gradle" {
        Describe "Gradle" {
            It "Gradle is installed" {
                "gradle --version" | Should -ReturnZeroExitCode
            }

            It "Gradle is installed to /usr/local/bin" -Skip:($os.IsArm64) {
                (Get-Command "gradle").Path | Should -BeExactly "/usr/local/bin/gradle"
            }

            It "Gradle is installed to /opt/homebrew/bin/gradle" -Skip:(-not $os.IsArm64) {
                (Get-Command "gradle").Path | Should -BeExactly "/opt/homebrew/bin/gradle"
            }
        }
    }
}
