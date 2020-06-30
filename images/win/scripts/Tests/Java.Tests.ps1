################################################################################
##  File:  Validate-Java.ps1
##  Desc:  Validate Java
################################################################################

Import-Module "./Utils.psm1" -DisableNameChecking

$JAVA_VERSIONS = @(7, 8, 11, 13)

Describe "Java" {
    # Checking the default JAVA 
    It "Java 8 is default" {
        $java8Path = Get-EnvironmentVariable "JAVA_HOME_8_X64"
        $javaHomePath = Get-EnvironmentVariable "JAVA_HOME"
        $java8Path | Should -Be "$javaHomePath"
    }
    
    # Checking that Java and pluging are in PATH.
    It "Java, Gradle, Maven, Ant added to the PATH:" {
        if((Get-Command -Name 'java') -and (Get-Command -Name 'mvn') -and (Get-Command -Name 'ant') -and (Get-Command -Name 'gradle'))
        {
            Write-Host "Java $(java -version) on path"
            Write-Host "Maven $(mvn -version) on path"
            Write-Host "Ant $(ant -version) on path"
            Write-Host "Gradle $(gradle -version) on path"
        }
        else
            {
            Write-Host "one of Java,Maven,Ant,Gradle is not on path."
            exit 1
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
            Validate-ZeroExitCode "Start-Process $javapath -Argument version"
            Get-EnvironmentVariable "JAVA_HOME_$($_)_X64" | Should -Not -BeNullOrEmpty
        }
    }
}