################################################################################
##  File:  Install-JavaTools.ps1
##  Desc:  Install various JDKs and java tools
################################################################################

# Download the Azul Systems Zulu JDKs
# See https://www.azul.com/downloads/azure-only/zulu/
$azulJDK7Uri = 'https://repos.azul.com/azure-only/zulu/packages/zulu-7/7u232/zulu-7-azure-jdk_7.31.0.5-7.0.232-win_x64.zip'
$azulJDK8Uri = 'https://repos.azul.com/azure-only/zulu/packages/zulu-8/8u222/zulu-8-azure-jdk_8.40.0.25-8.0.222-win_x64.zip'
$azulJDK11Uri = 'https://repos.azul.com/azure-only/zulu/packages/zulu-11/11.0.4/zulu-11-azure-jdk_11.33.15-11.0.4-win_x64.zip'

cd $env:TEMP

Invoke-WebRequest -UseBasicParsing -Uri $azulJDK7Uri -OutFile azulJDK7.zip
Invoke-WebRequest -UseBasicParsing -Uri $azulJDK8Uri -OutFile azulJDK8.zip
Invoke-WebRequest -UseBasicParsing -Uri $azulJDK11Uri -OutFile azulJDK11.zip

# Expand the zips
Expand-Archive -Path azulJDK7.zip -DestinationPath "C:\Program Files\Java\" -Force
Expand-Archive -Path azulJDK8.zip -DestinationPath "C:\Program Files\Java\" -Force
Expand-Archive -Path azulJDK11.zip -DestinationPath "C:\Program Files\Java\" -Force

# Deleting zip folders
Remove-Item -Recurse -Force azulJDK7.zip
Remove-Item -Recurse -Force azulJDK8.zip
Remove-Item -Recurse -Force azulJDK11.zip

Import-Module -Name ImageHelpers -Force

$currentPath = Get-MachinePath

$pathSegments = $currentPath.Split(';')
$newPathSegments = @()

foreach ($pathSegment in $pathSegments)
{
    if($pathSegment -notlike '*java*')
    {
        $newPathSegments += $pathSegment
    }
}

$java7Installs = Get-ChildItem -Path 'C:\Program Files\Java' -Filter '*azure-jdk*7*' | Sort-Object -Property Name -Descending | Select-Object -First 1
$latestJava7Install = $java7Installs.FullName;

$java8Installs = Get-ChildItem -Path 'C:\Program Files\Java' -Filter '*azure-jdk*8*' | Sort-Object -Property Name -Descending | Select-Object -First 1
$latestJava8Install = $java8Installs.FullName;

$java11Installs = Get-ChildItem -Path 'C:\Program Files\Java' -Filter '*azure-jdk*11*' | Sort-Object -Property Name -Descending | Select-Object -First 1
$latestJava11Install = $java11Installs.FullName;

$newPath = [string]::Join(';', $newPathSegments)
$newPath = $latestJava8Install + '\bin;' + $newPath

Set-MachinePath -NewPath $newPath

setx JAVA_HOME $latestJava8Install /M
setx JAVA_HOME_7_X64 $latestJava7Install /M
setx JAVA_HOME_8_X64 $latestJava8Install /M
setx JAVA_HOME_11_X64 $latestJava11Install /M

# Install Java tools
# Force chocolatey to ignore dependencies on Ant and Maven or else they will download the Oracle JDK
choco install ant -y -i
choco install maven -y -i --version=3.6.3
choco install gradle -y

# Move maven variables to Machine. They may not be in the environment for this script so we need to read them from the registry.
$userSid = (Get-WmiObject win32_useraccount -Filter "name = '$env:USERNAME' AND domain = '$env:USERDOMAIN'").SID
$userEnvironmentKey = 'Registry::HKEY_USERS\' + $userSid + '\Environment'

$m2_home = (Get-ItemProperty -Path $userEnvironmentKey -Name M2_HOME).M2_HOME
$m2 = $m2_home + '\bin'
$maven_opts = '-Xms256m'

$m2_repo = 'C:\ProgramData\m2'
New-Item -Path $m2_repo -ItemType Directory -Force

setx M2 $m2 /M
setx M2_HOME $m2_home /M
setx M2_REPO $m2_repo /M
setx MAVEN_OPTS $maven_opts /M

# Download cobertura jars
$uri = 'https://ayera.dl.sourceforge.net/project/cobertura/cobertura/2.1.1/cobertura-2.1.1-bin.zip'
$coberturaPath = "C:\cobertura-2.1.1"

cd $env:TEMP

Invoke-WebRequest -UseBasicParsing -Uri $uri -OutFile cobertura.zip

# Expand the zip
Expand-Archive -Path cobertura.zip -DestinationPath "C:\" -Force

# Deleting zip folder
Remove-Item -Recurse -Force cobertura.zip

setx COBERTURA_HOME $coberturaPath /M
