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
