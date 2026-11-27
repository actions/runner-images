Import-Module "$PSScriptRoot/../SoftwareReport/SoftwareReport.Java.psm1" -DisableNameChecking

Describe "Java" {
    $toolsetJava = (Get-ToolsetContent).java
    $defaultVersion = $toolsetJava.default
    $jdkVersions = $toolsetJava.versions

    [array] $testCases = $jdkVersions | ForEach-Object { @{Version = $_ } }

    BeforeAll {
        if (Test-IsArm64) {
            $expectedArch = "AARCH64"
        } else {
            $expectedArch = "X64"
        }
    }

    It "Java <DefaultJavaVersion> is default" -TestCases @(@{ DefaultJavaVersion = $defaultVersion }) {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${DefaultJavaVersion}_${expectedArch}"

        $actualJavaPath | Should -Not -BeNullOrEmpty
        $expectedJavaPath | Should -Not -BeNullOrEmpty
        $actualJavaPath | Should -Be $expectedJavaPath
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "java" }
        @{ ToolName = "mvn" }
        @{ ToolName = "ant" }
        @{ ToolName = "gradle" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }

    It "Java <Version>" -TestCases $testCases {
        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${Version}_${expectedArch}"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin\java"

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
        $outputPattern = "openjdk version `"${Version}"

        $outputLines = (& $env:comspec /c "`"$javaPath`" -version 2>&1") -as [string[]]
        $LASTEXITCODE | Should -Be 0
        $outputLines[0] | Should -Match $outputPattern
    }

    It "Reports the installed Java <Version> full version" -TestCases $testCases {
        $variable = "JAVA_HOME_${Version}_${expectedArch}"
        $javaHome = Get-EnvironmentVariable $variable
        $java = Join-Path $javaHome "bin/java.exe"
        $output = & $env:comspec /c "`"$java`" -fullversion 2>&1"
        $LASTEXITCODE | Should -Be 0
        $match = [regex]::Match("$output", '^openjdk full version "([^"]+)"$')
        $match.Success | Should -BeTrue
        $expected = $match.Groups[1].Value -replace '-LTS$', ''
        if ($expected -match '^1\.8\.0_(\d+)-b(\d+)$') {
            $expected = "8.0.$($Matches[1])+$([int]$Matches[2])"
        }
        if ($javaHome -eq $env:JAVA_HOME) {
            $expected += " (default)"
        }

        $row = Get-JavaVersions | Where-Object { $_.'Environment Variable' -eq $variable }
        $row.Version | Should -BeExactly $expected
    }
}
