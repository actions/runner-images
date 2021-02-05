Describe "Java" {
    [array]$jdkVersions = (Get-ToolsetContent).java.versions | ForEach-Object { @{Version = $_} }
    $defaultVersion = (Get-ToolsetContent).java.default

    It "Java <DefaultJavaVersion> is default" -TestCases @(@{ DefaultJavaVersion = $defaultVersion }) {
        $actualJavaPath = Get-EnvironmentVariable "JAVA_HOME"
        $expectedJavaPath = Get-EnvironmentVariable "JAVA_HOME_${DefaultJavaVersion}_X64"

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

    It "Java <Version>" -TestCases $jdkVersions {
        $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${Version}_X64"
        $javaVariableValue | Should -Not -BeNullOrEmpty
        $javaPath = Join-Path $javaVariableValue "bin\java"

        $result = Get-CommandResult "`"$javaPath`" -version"
        $result.ExitCode | Should -Be 0

        if ($Version -eq 8) {
            $Version = "1.${Version}"
        }
        $result.Output[0] | Should -Match ([regex]::Escape("openjdk version `"${Version}."))
    }
}
