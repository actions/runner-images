################################################################################
##  File:  Install-JavaTools.ps1
##  Desc:  Install various JDKs and java tools
################################################################################

function Set-JavaPath {
    param (
        [string] $Version,
        [string] $Architecture = "x64",
        [switch] $Default
    )

    $javaPathPattern = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Java_Adopt_jdk/${Version}*/${Architecture}"
    $javaPath = (Get-Item -Path $javaPathPattern).FullName

    if ([string]::IsNullOrEmpty($javaPath)) {
        Write-Host "Not found path to Java '${Version}'"
        exit 1
    }

    Write-Host "Set 'JAVA_HOME_${Version}_X64' environmental variable as $javaPath"
    setx JAVA_HOME_${Version}_X64 $javaPath /M

    if ($Default)
    {
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

        $newPath = [string]::Join(';', $newPathSegments)
        $newPath = $javaPath + '\bin;' + $newPath

        Write-Host "Add $javaPath\bin to PATH"
        Set-MachinePath -NewPath $newPath

        Write-Host "Set JAVA_HOME environmental variable as $javaPath"
        setx JAVA_HOME $javaPath /M
    }
}

function Install-JavaFromAdoptOpenJDK {
    param(
        [string] $JDKVersion,
        [string] $Architecture = "x64"
    )

    # Get Java version from adopt openjdk api
    $assetUrl = Invoke-RestMethod -Uri "https://api.adoptopenjdk.net/v3/assets/latest/${JDKVersion}/hotspot"
    $asset = $assetUrl | Where-Object {
        $_.binary.os -eq "windows" `
        -and $_.binary.architecture -eq $Architecture `
        -and $_.binary.image_type -eq "jdk"
    }
    $downloadUrl = $asset.binary.package.link
    # We have to replace '+' sign in the version to '-' due to the issue with incorrect path in Android builds https://github.com/actions/virtual-environments/issues/3014
    $fullJavaVersion = $asset.version.semver -replace '\+', '-'

    # Download and extract java binaries to temporary folder
    $archivePath = Start-DownloadWithRetry -Url $downloadUrl -Name $([IO.Path]::GetFileName($downloadUrl))
    $javaTempPath = Join-Path -Path $env:TEMP -ChildPath "Java_$fullJavaVersion"
    Extract-7Zip -Path $archivePath -DestinationPath $javaTempPath
    $javaTempBinariesPath = Join-Path -Path $javaTempPath -ChildPath "\jdk*\"

    # Create directories in toolcache path
    $javaToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Java_Adopt_jdk"
    $javaVersionPath = Join-Path -Path $javaToolcachePath -ChildPath $fullJavaVersion
    $javaArchPath = Join-Path -Path $javaVersionPath -ChildPath $Architecture

    if (-not (Test-Path $javaToolcachePath))
    {
        Write-Host "Creating Adopt openjdk toolcache folder"
        New-Item -ItemType Directory -Path $javaToolcachePath | Out-Null
    }

    Write-Host "Creating Java '${fullJavaVersion}' folder in '${javaVersionPath}'"
    New-Item -ItemType Directory -Path $javaVersionPath -Force | Out-Null

    # Complete the installation by moving Java binaries from temporary directory to toolcache and creating the complete file
    Move-Item -Path $javaTempBinariesPath -Destination $javaArchPath 
    New-Item -ItemType File -Path $javaVersionPath -Name "$Architecture.complete" | Out-Null
}

$jdkVersions = (Get-ToolsetContent).java.versions
$defaultVersion = (Get-ToolsetContent).java.default

foreach ($jdkVersion in $jdkVersions) {
    Install-JavaFromAdoptOpenJDK -JDKVersion $jdkVersion

    if ($jdkVersion -eq $defaultVersion) {
        Set-JavaPath -Version $jdkVersion -Default
    } else {
        Set-JavaPath -Version $jdkVersion
    }
}

# Install Java tools
# Force chocolatey to ignore dependencies on Ant and Maven or else they will download the Oracle JDK
Choco-Install -PackageName ant -ArgumentList "-i"
Choco-Install -PackageName maven -ArgumentList "-i", "--version=3.8.1"
Choco-Install -PackageName gradle

# Move maven variables to Machine. They may not be in the environment for this script so we need to read them from the registry.
$userEnvironmentKey = 'Registry::HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'

$m2_home = (Get-ItemProperty -Path $userEnvironmentKey -Name M2_HOME).M2_HOME
$m2 = $m2_home + '\bin'
$maven_opts = '-Xms256m'

$m2_repo = 'C:\ProgramData\m2'
New-Item -Path $m2_repo -ItemType Directory -Force

setx M2 $m2 /M
setx M2_REPO $m2_repo /M
setx MAVEN_OPTS $maven_opts /M

# Download cobertura jars
$uri = 'https://downloads.sourceforge.net/project/cobertura/cobertura/2.1.1/cobertura-2.1.1-bin.zip'
$coberturaPath = "C:\cobertura-2.1.1"

$archivePath = Start-DownloadWithRetry -Url $uri -Name "cobertura.zip"
Extract-7Zip -Path $archivePath -DestinationPath "C:\"

setx COBERTURA_HOME $coberturaPath /M

Invoke-PesterTests -TestFile "Java"
