Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

Describe "Java" {
    $jdkVersions = (Get-ToolsetContent).java.versions
    $defaultJavaVersion = (Get-ToolsetContent).java.default

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

    foreach ($version in $jdkVersions) {
        It "Java ${version}" {
            $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${version}_X64"
            $javaVariableValue | Should -Not -BeNullOrEmpty
            $javaPath = Join-Path $javaVariableValue "bin\java"
    
            $result = Get-CommandResult "`"$javaPath`" -version"
            $result.ExitCode | Should -Be 0
            $result.Output[0] | Should -Match ([regex]::Escape("openjdk version `"${Version}."))
        }
    }
}
