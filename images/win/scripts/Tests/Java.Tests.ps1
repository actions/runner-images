Describe "Java" {
    $jdkVersions = (Get-ToolsetContent).java.versions
    $defaultVersion = (Get-ToolsetContent).java.default

    It "Java ${defaultVersion} is default" {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${defaultVersion}_X64"

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