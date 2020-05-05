################################################################################
##  File:  Validate-JavaTools.ps1
##  Desc:  Validate various JDKs and java tools
################################################################################

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


if( $( $(& $env:comspec "/s /c java -version 2>&1") | Out-String) -match  '^(?<vendor>.+) version "(?<version>.+)".*' )
{
   $javaVersion = $Matches.version
}

$env:Path = $env:JAVA_HOME_7_X64 + "\bin;" + $env:Path

if( $( $(& $env:comspec "/s /c java -version 2>&1") | Out-String) -match  '^(?<vendor>.+) version "(?<version>.+)".*' )
{
   $java7Version = $Matches.version
}

$env:Path = $env:JAVA_HOME_11_X64 + "\bin;" + $env:Path

if( $( $(& $env:comspec "/s /c java -version 2>&1") | Out-String) -match  '^(?<vendor>.+) version "(?<version>.+)".*' )
{
   $java11Version = $Matches.version
}

$env:Path = $env:JAVA_HOME_13_X64 + "\bin;" + $env:Path

if( $( $(& $env:comspec "/s /c java -version 2>&1") | Out-String) -match  '^(?<vendor>.+) version "(?<version>.+)".*' )
{
   $java13Version = $Matches.version
}

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
#### $javaVersion (default)

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
