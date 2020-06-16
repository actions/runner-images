################################################################################
##  File:  Validate-JavaTools.ps1
##  Desc:  Validate various JDKs and java tools
################################################################################

Function Validate-JavaVersion {
   param (
      [Parameter(Mandatory)] [string] $Version,
      [switch] $Default
   )

   Write-Host "Checking Java $version"

   # Set Path to get Java
   if (-not $Default)
   {
      # Take 7 & 8 for versions 1.7 and 1.8
      $versionNumber = $version.Split(".") | Select-Object -Last 1

      $javaBin = [System.Environment]::GetEnvironmentVariable("JAVA_HOME_${versionNumber}_X64") + "\bin;"
      $env:Path = $javaBin + $env:Path
   }

   $isJavaExists =  $($(& $env:comspec "/s /c java -version 2>&1") | Out-String) -match '^(?<vendor>.+) version "(?<version>.+)".*'

   if ($isJavaExists)
   {
      $javaVersion = $matches.version
   }
   else
   {
      Write-Host "Java $version was not found"
      exit 1
   }

   $isJavaCorrect = $javaVersion.StartsWith($version)

   if($isJavaCorrect)
   {
      Write-Host "Java $javaVersion found"
      # Reset Path to the default one in case we need to check the default Java later
      $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
   }
   else
   {
      Write-Host "Expected Java $version, but found $javaVersion"
      exit 1
   }
}

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

Write-Host "Checking installed Java versions"
Validate-JavaVersion -Version "1.7"
Validate-JavaVersion -Version "1.8" -Default
Validate-JavaVersion -Version "11"
Validate-JavaVersion -Version "13"
