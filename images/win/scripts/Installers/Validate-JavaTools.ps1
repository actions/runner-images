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
      return $javaVersion
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

$java7Version = Validate-JavaVersion -Version "1.7"
$java8Version = Validate-JavaVersion -Version "1.8" -Default
$java11Version = Validate-JavaVersion -Version "11"
$java13Version = Validate-JavaVersion -Version "13"

if( $(ant -version) -match  'Apache Ant\(TM\) version (?<version>.*) compiled.*' )
{
   $antVersion = $Matches.version
}

if( $( $(mvn -version) | Out-String) -match  'Apache Maven (?<version>.*) \(.*' )
{
   $mvnVersion = $Matches.version
}

if( $( $(gradle -version) | Out-String) -match  'Gradle (?<version>.*)' )
{
   $gradleVersion = $Matches.version.Trim()
}

# Adding description of the software to Markdown
$SoftwareName = "Java Development Kit"

$Description = @"
#### $java8Version (default)

_Environment:_
* JAVA_HOME: location of JDK
* PATH: contains bin folder of JDK

#### $java7Version

_Location:_ $env:JAVA_HOME_7_X64

#### $java11Version

_Location:_ $env:JAVA_HOME_11_X64

#### $java13Version

_Location:_ $env:JAVA_HOME_13_X64
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description


# Adding description of the software to Markdown
$SoftwareName = "Ant"

$Description = @"
_Version:_ $antVersion<br/>
_Environment:_
* PATH: contains location of ant.cmd
* ANT_HOME: location of ant.cmd
* COBERTURA_HOME: location of cobertura-2.1.1.jar
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description


# Adding description of the software to Markdown
$SoftwareName = "Maven"

$Description = @"
_Version:_ $mvnVersion<br/>
_Environment:_
* PATH: contains location of mvn.bat
* M2_HOME: Maven installation root
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description


# Adding description of the software to Markdown
$SoftwareName = "Gradle"

$Description = @"
_Version:_ $gradleVersion<br/>
_Environment:_
* PATH: contains location of gradle
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
