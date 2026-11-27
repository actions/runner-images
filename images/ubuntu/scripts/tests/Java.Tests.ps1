Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../SoftwareReport/SoftwareReport.Java.psm1" -DisableNameChecking

Describe "Java" {
    $toolsetJava = (Get-ToolsetContent).java
    $defaultVersion = $toolsetJava.default
    $jdkVersions = $toolsetJava.versions

    It "Java <DefaultJavaVersion> is default" -TestCases @{ DefaultJavaVersion = $defaultVersion } {
        $actualJavaPath = [System.Environment]::GetEnvironmentVariable("JAVA_HOME")
        $expectedJavaPath = [System.Environment]::GetEnvironmentVariable("JAVA_HOME_${DefaultJavaVersion}_X64")

        $actualJavaPath | Should -Not -BeNullOrEmpty
        $expectedJavaPath | Should -Not -BeNullOrEmpty
        $actualJavaPath | Should -Be $expectedJavaPath
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "java" }
        @{ ToolName = "javac" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }

    $testCases = $jdkVersions | ForEach-Object { @{Version = $_ } }

    It "Java <Version>" -TestCases $testCases {
        $javaVariableValue = [System.Environment]::GetEnvironmentVariable("JAVA_HOME_${Version}_X64")
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin/java"

        "`"$javaPath`" -version" | Should -ReturnZeroExitCode

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
        "`"$javaPath`" -version" | Should -OutputTextMatchingRegex "openjdk\ version\ `"${Version}(\.[0-9_\.]+)?`""
    }

    It "Reports the installed Java <Version> full version" -TestCases $testCases {
        $variable = "JAVA_HOME_${Version}_X64"
        $javaHome = [System.Environment]::GetEnvironmentVariable($variable)
        $output = & (Join-Path $javaHome "bin/java") -fullversion 2>&1
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

        $row = Get-JavaVersionsTable | Where-Object { $_.'Environment Variable' -eq $variable }
        $row.Version | Should -BeExactly $expected
    }
}

Describe "Java-Tools" {
    It "Gradle" {
        "gradle -version" | Should -ReturnZeroExitCode

        $gradleVariableValue = [System.Environment]::GetEnvironmentVariable("GRADLE_HOME")
        $gradleVariableValue | Should -BeLike "/usr/share/gradle-*"

        $gradlePath = Join-Path $env:GRADLE_HOME "bin/gradle"
        "`"$GradlePath`" -version" | Should -ReturnZeroExitCode
    }
    It "<ToolName>" -TestCases @(
        @{ ToolName = "mvn" }
        @{ ToolName = "ant" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }
}
