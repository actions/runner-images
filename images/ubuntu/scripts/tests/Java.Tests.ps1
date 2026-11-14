Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

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

    $testCases = @(
        $jdkVersions |
            ForEach-Object { [string]$_ } |
            ForEach-Object { $_.Trim() } |
            Where-Object { $_ } |
            ForEach-Object { @{ Version = $_ } }
    )

    $testCases.Count | Should -BeGreaterThan 0

    It "Java <Version>" -TestCases $testCases {
        param([string] $Version)

        $javaVersion = [string]$Version
        $javaVariableValue = [System.Environment]::GetEnvironmentVariable("JAVA_HOME_${javaVersion}_X64")
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin/java"

        "`"$javaPath`" -version" | Should -ReturnZeroExitCode

        $expectedJavaVersion = if ($javaVersion -eq "8") { "1.8" } else { $javaVersion }
        "`"$javaPath`" -version" | Should -OutputTextMatchingRegex "openjdk\ version\ `"${expectedJavaVersion}(\.[0-9_\.]+)?`""
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
