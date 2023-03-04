################################################################################
##  File:  Install-JavaTools.ps1
##  Desc:  Install various JDKs and java tools
################################################################################

function Set-JavaPath {
    param (
        [string] $Version,
        [string] $Architecture = "x64",
        [switch] $Default,
        [string] $VendorName
    )

    $javaPathPattern = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Java_${VendorName}_jdk/${Version}*/${Architecture}"
    $javaPath = (Get-Item -Path $javaPathPattern).FullName

    if ([string]::IsNullOrEmpty($javaPath)) {
        Write-Host "Not found path to Java '${Version}'"
        exit 1
    }

    Write-Host "Set 'JAVA_HOME_${Version}_X64' environmental variable as $javaPath"
    setx JAVA_HOME_${Version}_X64 $javaPath /M

    if ($Default)
    {
        # Clean up any other Java folders from PATH to make sure that they won't conflict with each other
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

function Install-JavaJDK {
    param(
        [string] $JDKVersion,
        [string] $Architecture = "x64",
        [string] $VendorName
    )

    # Get Java version from api
    if ($VendorName -eq "Temurin-Hotspot") {
        $assetUrl = Invoke-RestMethod -Uri "https://api.adoptium.net/v3/assets/latest/${JDKVersion}/hotspot"
    } elseif ($VendorName -eq "Adopt") {
        $assetUrl = Invoke-RestMethod -Uri "https://api.adoptopenjdk.net/v3/assets/latest/${JDKVersion}/hotspot"
    } else {
        throw "$VendorName is invalid vendor name. 'Adopt' and 'Temurin-Hotspot' are allowed values"
    }
    $asset = $assetUrl | Where-Object {
        $_.binary.os -eq "windows" `
        -and $_.binary.architecture -eq $Architecture `
        -and $_.binary.image_type -eq "jdk"
    }

    # Download and extract java binaries to temporary folder
    $downloadUrl = $asset.binary.package.link
    $archivePath = Start-DownloadWithRetry -Url $downloadUrl -Name $([IO.Path]::GetFileName($downloadUrl))

    # We have to replace '+' sign in the version to '-' due to the issue with incorrect path in Android builds https://github.com/actions/runner-images/issues/3014
    $fullJavaVersion = $asset.version.semver -replace '\+', '-'
    # Create directories in toolcache path
    $javaToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Java_${VendorName}_jdk"
    $javaVersionPath = Join-Path -Path $javaToolcachePath -ChildPath $fullJavaVersion
    $javaArchPath = Join-Path -Path $javaVersionPath -ChildPath $Architecture

    if (-not (Test-Path $javaToolcachePath))
    {
        Write-Host "Creating ${VendorName} toolcache folder"
        New-Item -ItemType Directory -Path $javaToolcachePath | Out-Null
    }

    Write-Host "Creating Java '${fullJavaVersion}' folder in '${javaVersionPath}'"
    New-Item -ItemType Directory -Path $javaVersionPath -Force | Out-Null

    # Complete the installation by extracting Java binaries to toolcache and creating the complete file
    Extract-7Zip -Path $archivePath -DestinationPath $javaVersionPath
    Invoke-SBWithRetry -Command {
        Get-ChildItem -Path $javaVersionPath | Rename-Item -NewName $javaArchPath -ErrorAction Stop
    }
    New-Item -ItemType File -Path $javaVersionPath -Name "$Architecture.complete" | Out-Null
}

$toolsetJava = (Get-ToolsetContent).java
$jdkVendors = $toolsetJava.vendors
$defaultVendor = $toolsetJava.default_vendor
$defaultVersion = $toolsetJava.default

foreach ($jdkVendor in $jdkVendors) {
    $jdkVendorName = $jdkVendor.name
    $jdkVersionsToInstall = $jdkVendor.versions

    $isDefaultVendor = $jdkVendorName -eq $defaultVendor

    foreach ($jdkVersionToInstall in $jdkVersionsToInstall) {
        $isDefaultVersion = $jdkVersionToInstall -eq $defaultVersion

        Install-JavaJDK -VendorName $jdkVendorName -JDKVersion $jdkVersionToInstall

        if ($isDefaultVendor) {
            if ($isDefaultVersion) {
                Set-JavaPath -Version $jdkVersionToInstall -VendorName $jdkVendorName -Default
            } else {
                Set-JavaPath -Version $jdkVersionToInstall -VendorName $jdkVendorName
            }
        }
    }
}

# Setup JAVA_HOME_13_X64 as this is the only Adopt version needed
# There is no jdk 13 on Windows 2022
if (-not (Test-IsWin22)) {
    Set-JavaPath -Version "13" -VendorName "Adopt"
}

# Install Java tools
# Force chocolatey to ignore dependencies on Ant and Maven or else they will download the Oracle JDK
Choco-Install -PackageName ant -ArgumentList "-i"
# Maven 3.9.x has multiple compatibilities problems
$toolsetMavenVersion = (Get-ToolsetContent).maven.version
$versionToInstall = Get-LatestChocoPackageVersion -TargetVersion $toolsetMavenVersion -PackageName "maven"

Choco-Install -PackageName maven -ArgumentList "--version=$versionToInstall"
Choco-Install -PackageName gradle

# Add maven env variables to Machine
[string]$m2 = (Get-MachinePath).Split(";") -match "maven"
$maven_opts = '-Xms256m'

$m2_repo = 'C:\ProgramData\m2'
New-Item -Path $m2_repo -ItemType Directory -Force | Out-Null

setx M2 $m2 /M
setx M2_REPO $m2_repo /M
setx MAVEN_OPTS $maven_opts /M

# Download cobertura jars
$uri = 'https://repo1.maven.org/maven2/net/sourceforge/cobertura/cobertura/2.1.1/cobertura-2.1.1-bin.zip'
$coberturaPath = "C:\cobertura-2.1.1"

$archivePath = Start-DownloadWithRetry -Url $uri -Name "cobertura.zip"
Extract-7Zip -Path $archivePath -DestinationPath "C:\"

setx COBERTURA_HOME $coberturaPath /M

Invoke-PesterTests -TestFile "Java"
