Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

Describe "Java" {

    if (Test-IsUbuntu20) {
        $DefaultJavaVersion = "11"
    }

    if ((Test-IsUbuntu16) -or (Test-IsUbuntu18)) {
        $DefaultJavaVersion = "8"
    }

    Update-Environment

    It "Java <DefaultJavaVersion> is default" -TestCases @{ DefaultJavaVersion = $DefaultJavaVersion } {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${DefaultJavaVersion}_X64"

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

    It "Java <Version>" -TestCases @(
        @{ Version = "1.7" }
        @{ Version = "1.8" }
        @{ Version = "11" }
        @{ Version = "12" }
    ) {
        $versionNumber = $version.Split(".") | Select-Object -Last 1

        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${versionNumber}_X64"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin/java"

        $result = Get-CommandResult "`"$javaPath`" -version"
        $result.ExitCode | Should -Be 0
        $result.Output | Should -Match ([regex]::Escape("openjdk version `"${Version}."))
    }
}