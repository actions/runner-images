################################################################################
##  File:  Install-JavaTools.ps1
##  Desc:  Install various JDKs and java tools
##  Supply chain security: JDK - checksum validation
################################################################################

function Set-JavaPath {
    param (
        [string] $Version,
        [string] $Architecture = "x64",
        [switch] $Default
    )

    $javaPathPattern = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Java_Temurin-Hotspot_jdk/${Version}*/${Architecture}"
    $javaPath = (Get-Item -Path $javaPathPattern).FullName

    if ([string]::IsNullOrEmpty($javaPath)) {
        Write-Host "Not found path to Java '${Version}'"
        exit 1
    }

    Write-Host "Set 'JAVA_HOME_${Version}_X64' environmental variable as $javaPath"
    [Environment]::SetEnvironmentVariable("JAVA_HOME_${Version}_X64", $javaPath, "Machine")

    if ($Default) {
        # Clean up any other Java folders from PATH to make sure that they won't conflict with each other
        $currentPath = [System.Environment]::GetEnvironmentVariable("PATH", "Machine")

        $pathSegments = $currentPath.Split(';')
        $newPathSegments = @()

        foreach ($pathSegment in $pathSegments) {
            if ($pathSegment -notlike '*java*') {
                $newPathSegments += $pathSegment
            }
        }

        $newPath = [string]::Join(';', $newPathSegments)
        $newPath = $javaPath + '\bin;' + $newPath

        Write-Host "Add $javaPath\bin to PATH"
        [Environment]::SetEnvironmentVariable("PATH", $newPath, "Machine")

        Write-Host "Set JAVA_HOME environmental variable as $javaPath"
        [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath, "Machine")
    }
}

function Install-JavaJDK {
    param(
        [string] $JDKVersion,
        [string] $Architecture = "x64"
    )

    # Get Java version from api
    $assetUrl = Invoke-RestMethod -Uri "https://api.adoptium.net/v3/assets/latest/${JDKVersion}/hotspot"

    $asset = $assetUrl | Where-Object {
        $_.binary.os -eq "windows" `
            -and $_.binary.architecture -eq $Architecture `
            -and $_.binary.image_type -eq "jdk"
    }

    # Download and extract java binaries to temporary folder
    $downloadUrl = $asset.binary.package.link
    $archivePath = Invoke-DownloadWithRetry $downloadUrl
    Test-FileChecksum $archivePath -ExpectedSHA256Sum $asset.binary.package.checksum

    # We have to replace '+' sign in the version to '-' due to the issue with incorrect path in Android builds https://github.com/actions/runner-images/issues/3014
    $fullJavaVersion = $asset.version.semver -replace '\+', '-'
    # Remove 'LTS' suffix from the version if present
    $fullJavaVersion = $fullJavaVersion -replace '\.LTS$', ''
    # Create directories in toolcache path
    $javaToolcachePath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Java_Temurin-Hotspot_jdk"
    $javaVersionPath = Join-Path -Path $javaToolcachePath -ChildPath $fullJavaVersion
    $javaArchPath = Join-Path -Path $javaVersionPath -ChildPath $Architecture

    if (-not (Test-Path $javaToolcachePath)) {
        Write-Host "Creating Temurin-Hotspot toolcache folder"
        New-Item -ItemType Directory -Path $javaToolcachePath | Out-Null
    }

    Write-Host "Creating Java '${fullJavaVersion}' folder in '${javaVersionPath}'"
    New-Item -ItemType Directory -Path $javaVersionPath -Force | Out-Null

    # Complete the installation by extracting Java binaries to toolcache and creating the complete file
    Expand-7ZipArchive -Path $archivePath -DestinationPath $javaVersionPath
    Invoke-ScriptBlockWithRetry -Command {
        Get-ChildItem -Path $javaVersionPath | Rename-Item -NewName $javaArchPath -ErrorAction Stop
    }
    New-Item -ItemType File -Path $javaVersionPath -Name "$Architecture.complete" | Out-Null
}

$toolsetJava = (Get-ToolsetContent).java
$defaultVersion = $toolsetJava.default
$jdkVersionsToInstall = $toolsetJava.versions

foreach ($jdkVersionToInstall in $jdkVersionsToInstall) {
    $isDefaultVersion = $jdkVersionToInstall -eq $defaultVersion

    Install-JavaJDK -JDKVersion $jdkVersionToInstall

    if ($isDefaultVersion) {
        Set-JavaPath -Version $jdkVersionToInstall -Default
    } else {
        Set-JavaPath -Version $jdkVersionToInstall
    }
}

# Install Java tools
# Force chocolatey to ignore dependencies on Ant and Maven or else they will download the Oracle JDK
Install-ChocoPackage ant -ArgumentList "--ignore-dependencies"
$toolsetMavenVersion = (Get-ToolsetContent).maven.version
$versionToInstall = Resolve-ChocoPackageVersion -PackageName "maven" -TargetVersion $toolsetMavenVersion

Install-ChocoPackage maven -ArgumentList "--version=$versionToInstall"
Install-ChocoPackage gradle

# Add maven env variables to Machine
[string] $m2Path = ([Environment]::GetEnvironmentVariable("PATH", "Machine")).Split(";") -match "maven"

$m2RepoPath = 'C:\ProgramData\m2'
New-Item -Path $m2RepoPath -ItemType Directory -Force | Out-Null

[Environment]::SetEnvironmentVariable("M2", $m2Path, "Machine")
[Environment]::SetEnvironmentVariable("M2_REPO", $m2RepoPath, "Machine")
[Environment]::SetEnvironmentVariable("MAVEN_OPTS", "-Xms256m", "Machine")

# Download cobertura jars
$uri = 'https://repo1.maven.org/maven2/net/sourceforge/cobertura/cobertura/2.1.1/cobertura-2.1.1-bin.zip'
$sha256sum = '79479DDE416B082F38ECD1F2F7C6DEBD4D0C2249AF80FD046D1CE05D628F2EC6'
$coberturaPath = "C:\cobertura-2.1.1"

$archivePath = Invoke-DownloadWithRetry $uri
Test-FileChecksum $archivePath -ExpectedSHA256Sum $sha256sum
Expand-7ZipArchive -Path $archivePath -DestinationPath "C:\"

[Environment]::SetEnvironmentVariable("COBERTURA_HOME", $coberturaPath, "Machine")

Invoke-PesterTests -TestFile "Java"
