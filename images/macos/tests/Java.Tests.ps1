Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"
Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1" -DisableNameChecking

function Get-NativeVersionFormat {
    param($Version)
    if ($Version -in "8") {
        return "1.${Version}"
    }
    return $Version
}

Describe "Java" {
    BeforeAll {
        function Validate-JavaVersion {
            param($JavaCommand, $ExpectedVersion)

            $commandResult = Get-CommandResult $JavaCommand
            $commandResult.ExitCode | Should -Be 0
            $matchResult = $commandResult.Output | Select-String '^openjdk version \"([\d\._]+)\"'
            $matchResult.Matches.Success | Should -BeTrue
            $version = $matchResult.Matches.Groups[1].Value
            $version | Should -BeLike "${ExpectedVersion}*"
        }
    }

    $toolsetJava = Get-ToolsetValue "java"
    $defaultVersion = $toolsetJava.default
    $defaultVendor = $toolsetJava.default_vendor
    $javaVendors = $toolsetJava.vendors

    [array]$jdkVersions = ($javaVendors | Where-Object {$_.name -eq $defaultVendor}).versions
    [array]$adoptJdkVersions = ($javaVendors | Where-Object {$_.name -eq "Adopt"}).versions

    $adoptCases = $adoptJdkVersions | ForEach-Object { @{Version = $_} }
    $testCases = $jdkVersions | ForEach-Object { @{ Title = $_; Version = (Get-NativeVersionFormat $_); EnvVariable = "JAVA_HOME_${_}_X64" } }
    $testCases += @{ Title = "Default"; Version = (Get-NativeVersionFormat $defaultVersion); EnvVariable = "JAVA_HOME" }

    $testCases | ForEach-Object {
        Context $_.Title {
            It "Version is found by 'java_home'" -TestCases $_ {
                "/usr/libexec/java_home -v${Version}" | Should -ReturnZeroExitCode
            }

            It "Java <Version>" -TestCases $_ {
                $envVariablePath = Get-EnvironmentVariable $EnvVariable
                $javaBinPath = Join-Path $envVariablePath "/bin/java"
                Validate-JavaVersion -JavaCommand "$javaBinPath -version" -ExpectedVersion $Version
            }

            if ($_.Title -eq "Default") {
                It "Version is default" -TestCases $_ {
                    Validate-JavaVersion -JavaCommand "java -version" -ExpectedVersion $Version
                }
            }
        }
    }

    Context "Java Adopt" {
        Describe "Java Adopt" {
                It "Java Adopt <Version>" -TestCases $adoptCases {
                $adoptPath = Join-Path (Get-ChildItem ${env:AGENT_TOOLSDIRECTORY}\Java_Adopt_jdk\${Version}*) "x64\Contents\Home\bin\java"

                $result = Get-CommandResult "`"$adoptPath`" -version"
                $result.ExitCode | Should -Be 0
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
        
            It "Gradle is installed to /usr/local/bin" {
                (Get-Command "gradle").Path | Should -BeExactly "/usr/local/bin/gradle"
            }
        }
    }
}