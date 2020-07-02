$JAVA_VERSIONS = @(7, 8, 11, 13)

Describe "Java" {
    It "Java 8 is default" {
        $java8Path = Get-EnvironmentVariable "JAVA_HOME_8_X64"
        $javaHomePath = Get-EnvironmentVariable "JAVA_HOME"
        $java8Path | Should -Not -BeNullOrEmpty
        $javaHomePath | Should -Not -BeNullOrEmpty
        $java8Path | Should -Be "$javaHomePath"
    }

    @("java", "mvn", "ant", "gradle") | ForEach-Object {
        It "$($_) added to the PATH:" {
            "$($_) -version" | Should -ReturnZeroExitCode
        }
    }

    $JAVA_VERSIONS | ForEach-Object {
        $version = $_
        if ($version -In @(7, 8)) {
            # old Java versions look like "1.7", "1.8"
            $version = "1." + $version
        }

        It "Java $version" {
            $javaVariableValue = Get-EnvironmentVariable "JAVA_HOME_${_}_X64"
            $javaVariableValue | Should -Not -BeNullOrEmpty

            $javaPath = Join-Path $javaVariableValue "bin\java"
            "'$javaPath' version" | Should -ReturnZeroExitCode
        }
    }
}