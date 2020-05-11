################################################################################
##  File:  Install-JavaTools.ps1
##  Desc:  Install various JDKs and java tools
################################################################################

Import-Module -Name ImageHelpers -Force

# Download the Azul Systems Zulu JDKs
# See https://www.azul.com/downloads/azure-only/zulu/
$azulJDKURLs = @(
    'https://repos.azul.com/azure-only/zulu/packages/zulu-7/7u232/zulu-7-azure-jdk_7.31.0.5-7.0.232-win_x64.zip',
    'https://repos.azul.com/azure-only/zulu/packages/zulu-8/8u222/zulu-8-azure-jdk_8.40.0.25-8.0.222-win_x64.zip',
    'https://repos.azul.com/azure-only/zulu/packages/zulu-11/11.0.4/zulu-11-azure-jdk_11.33.15-11.0.4-win_x64.zip',
    'https://repos.azul.com/azure-only/zulu/packages/zulu-13/13.0.3/zulu-13-azure-jdk_13.31.11-13.0.3-win_x64.zip'
)

foreach ($azulJDKURL in $azulJDKURLs)
{
    $archivePath = Start-DownloadWithRetry -Url $azulJDKURL -Name $([IO.Path]::GetFileName($azulJDKURL))
    Expand-Archive -Path $archivePath -DestinationPath "C:\Program Files\Java\"
}

$currentPath = Get-MachinePath

$pathSegments = $currentPath.Split(';')
$newPathSegments = @()

foreach ($pathSegment in $pathSegments)
{
    if ($pathSegment -notlike '*java*')
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

$java13Installs = Get-ChildItem -Path 'C:\Program Files\Java' -Filter '*azure-jdk*13*' | Sort-Object -Property Name -Descending | Select-Object -First 1
$latestJava13Install = $java13Installs.FullName;

$newPath = [string]::Join(';', $newPathSegments)
$newPath = $latestJava8Install + '\bin;' + $newPath

Set-MachinePath -NewPath $newPath

setx JAVA_HOME $latestJava8Install /M
setx JAVA_HOME_7_X64 $latestJava7Install /M
setx JAVA_HOME_8_X64 $latestJava8Install /M
setx JAVA_HOME_11_X64 $latestJava11Install /M
setx JAVA_HOME_13_X64 $latestJava13Install /M

# Install Java tools
# Force chocolatey to ignore dependencies on Ant and Maven or else they will download the Oracle JDK
Choco-Install -PackageName ant -ArgumentList "-i"
Choco-Install -PackageName maven -ArgumentList "-i", "--version=3.6.3"
Choco-Install -PackageName gradle

# Move maven variables to Machine. They may not be in the environment for this script so we need to read them from the registry.
$userEnvironmentKey = 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'

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

$archivePath = Start-DownloadWithRetry -Url $uri -Name "cobertura.zip"
Expand-Archive -Path $archivePath -DestinationPath "C:\"

setx COBERTURA_HOME $coberturaPath /M
