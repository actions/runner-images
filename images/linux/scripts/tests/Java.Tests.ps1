Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking

Describe "Java" {
    $jdkVersions = (Get-ToolsetContent).java.versions
    $defaultJavaVersion = (Get-ToolsetContent).java.default

    It "Java <DefaultJavaVersion> is default" -TestCases @{ DefaultJavaVersion = $defaultJavaVersion } {
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

    foreach ($version in $jdkVersions) {
        $jdk = @{ jdkVersion = $version }

        It "Java ${version}" -TestCases $jdk {
            $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${jdkVersion}_X64"
            $javaVariableValue | Should -Not -BeNullOrEmpty
            $javaPath = Join-Path $javaVariableValue "bin\java"
    
            $result = Get-CommandResult "`"$javaPath`" -version"
            $result.ExitCode | Should -Be 0
            $result.Output[0] | Should -Match ([regex]::Escape("openjdk version `"${jdkVersion}."))
        }
    }
}