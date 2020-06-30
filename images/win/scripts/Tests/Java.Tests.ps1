$JAVA_VERSIONS = @(7, 8, 11, 13)

Describe "Java" {
    # Checking the default JAVA 
    It "Java 8 is default" {
        $java8Path = Get-EnvironmentVariable "JAVA_HOME_8_X64"
        $javaHomePath = Get-EnvironmentVariable "JAVA_HOME"
        $java8Path | Should -Be "$javaHomePath"
    }
    
    # Checking that Java and pluging are in PATH.
    @("java", "mvn", "ant", "gradle") | ForEach-Object {
        It "$($_) added to the PATH:" {
            "$($_) -version" | Should -ReturnZeroExitCode
        }
    }
    # Checking that all required versions of JAVA are in place.
    $JAVA_VERSIONS | ForEach-Object {
        $version = $_
        if ($version -In @(7, 8)) {
            # old Java versions look like "1.7", "1.8"
            $version = "1." + $version
        }

        It "Java $version" {
            $javaenv = "JAVA_HOME_${_}_X64"
            $javavar = Get-EnvironmentVariable $javaenv
            $javapath = Join-Path $javavar "bin\java"
            Start-Process $javapath -Argument version | Should -ReturnZeroExitCode
            Get-EnvironmentVariable "JAVA_HOME_$($_)_X64" | Should -Not -BeNullOrEmpty
        }
    }
}