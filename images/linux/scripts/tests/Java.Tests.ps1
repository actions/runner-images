Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

Describe "Java" {

    if (Test-IsUbuntu20) {
        $defaultJavaVersion = "11"
        $javaTestCases = @(
            @{ Version = "1.8" }
            @{ Version = "11" }
        )
    }

    if ((Test-IsUbuntu16) -or (Test-IsUbuntu18)) {
        $defaultJavaVersion = "8"
        $javaTestCases = @(
            @{ Version = "1.7" }
            @{ Version = "1.8" }
            @{ Version = "11" }
            @{ Version = "12" }
        )
    }

    It "Java <DefaultJavaVersion> is default" -TestCases @{ defaultJavaVersion = $defaultJavaVersion } {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${defaultJavaVersion}_X64"

        $actualJavaPath | Should -Not -BeNullOrEmpty
        $expectedJavaPath | Should -Not -BeNullOrEmpty
        $actualJavaPath | Should -Be $expectedJavaPath
    }

    It "<ToolName>" -TestCases @(
        @{ ToolName = "java" }
        @{ ToolName = "javac" }
        @{ ToolName = "mvn" }
        @{ ToolName = "ant" }
        @{ ToolName = "gradle" }
    ) {
        "$ToolName -version" | Should -ReturnZeroExitCode
    }

    It "Java <Version>" -TestCases $javaTestCases {
        $versionNumber = $version.Split(".") | Select-Object -Last 1

        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${versionNumber}_X64"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin/java"

        $result = Get-CommandResult "`"$javaPath`" -version"
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match ([regex]::Escape("openjdk version `"${Version}."))
    }
}