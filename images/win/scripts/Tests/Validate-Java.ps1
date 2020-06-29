################################################################################
##  File:  Validate-Java.ps1
##  Desc:  Validate Java
################################################################################

Import-Module "./Utils.psm1" -DisableNameChecking

$JAVA_VERSIONS = @(7, 8, 11, 13)

Describe "Java" {
    It "Java 8 is default" {
        $java8Path = Get-EnvironmentVariable "JAVA_HOME_8_X64"
        $javaHomePath = Get-EnvironmentVariable "JAVA_HOME"
        $java8Path | Should -Be "$javaHomePath"
    }

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
            Validate-ZeroExitCode "Start-Process $javapath -Argument version"
            Get-EnvironmentVariable "JAVA_HOME_$($_)_X64" | Should -Not -BeNullOrEmpty
        }
    }
}