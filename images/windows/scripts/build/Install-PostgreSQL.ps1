################################################################################
##  File:  Install-PostgreSQL.ps1
##  Desc:  Install PostgreSQL
################################################################################

# Define user and password for PostgreSQL database
$pgUser = "postgres"
$pgPwd = "root"

# Prepare environment variable for validation
[Environment]::SetEnvironmentVariable("PGUSER", $pgUser, "Machine")
[Environment]::SetEnvironmentVariable("PGPASSWORD", $pgPwd, "Machine")

$toolsetVersion = (Get-ToolsetContent).postgresql.version
if ($null -ne ($toolsetVersion | Select-String -Pattern '\d+\.\d+\.\d+')) {
    $majorVersion = ([version]$toolsetVersion).Major
    $minorVersion = ([version]$toolsetVersion).Minor
    $patchVersion = ([version]$toolsetVersion).Build
    $installerUrl = "https://get.enterprisedb.com/postgresql/postgresql-$majorVersion.$minorVersion-$patchVersion-windows-x64.exe"
} else {
    # Define latest available version to install based on version specified in the toolset
    $getPostgreReleases = Invoke-WebRequest -Uri "https://git.postgresql.org/gitweb/?p=postgresql.git;a=tags" -UseBasicParsing
    # Getting all links matched to the pattern (e.g.a=log;h=refs/tags/REL_14)
    $targetReleases = $getPostgreReleases.Links.href | Where-Object { $_ -match "a=log;h=refs/tags/REL_$toolsetVersion" }
    [Int32] $outNumber = $null
    $minorVersions = @()
    foreach ($release in $targetReleases) {
        $version = $release.split('/')[-1]
        # Checking if the latest symbol of the release version is actually a number. If yes, add to $minorVersions array
        if ([Int32]::TryParse($($version.Split('_')[-1]), [ref] $outNumber)) {
            $minorVersions += $outNumber
        }
    }
    # Sorting and getting the last one
    $targetMinorVersions = ($minorVersions | Sort-Object)[-1]

    # In order to get rid of error messages (we know we will have them), force ErrorAction to SilentlyContinue
    $errorActionOldValue = $ErrorActionPreference
    $ErrorActionPreference = 'SilentlyContinue'

    # Install latest PostgreSQL
    # Starting from number 9 and going down, check if the installer is available. If yes, break the loop.
    # If an installer with $targetMinorVersions is not to be found, the $targetMinorVersions will be decreased by 1
    $increment = 9
    do {
        $url = "https://get.enterprisedb.com/postgresql/postgresql-$toolsetVersion.$targetMinorVersions-$increment-windows-x64.exe"
        $checkAccess = [System.Net.WebRequest]::Create($url)
        $response = $null
        $response = $checkAccess.GetResponse()
        if ($response) {
            $installerUrl = $response.ResponseUri.OriginalString
        } elseif (!$response -and ($increment -eq 0)) {
            $increment = 9
            $targetMinorVersions--
        } else {
            $increment--
        }
    } while (!$response)
}

# Return the previous value of ErrorAction and invoke Install-Binary function
$ErrorActionPreference = $errorActionOldValue
$installerArgs = @("--install_runtimes 0", "--superpassword root", "--enable_acledit 1", "--unattendedmodeui none", "--mode unattended")
Install-Binary `
    -Url $installerUrl `
    -InstallArgs $installerArgs `
    -ExpectedSignature (Get-ToolsetContent).postgresql.signature

# Get Path to pg_ctl.exe
$pgPath = (Get-CimInstance Win32_Service -Filter "Name LIKE 'postgresql-%'").PathName

# Parse output of command above to obtain pure path
$pgBin = Split-Path -Path $pgPath.split('"')[1]
$pgRoot = Split-Path -Path $pgPath.split('"')[5]
$pgData = Join-Path $pgRoot "data"

# Validate PostgreSQL installation
$pgReadyPath = Join-Path $pgBin "pg_isready.exe"
$pgReady = Start-Process -FilePath $pgReadyPath -Wait -PassThru
$exitCode = $pgReady.ExitCode

if ($exitCode -ne 0) {
    Write-Host -Object "PostgreSQL is not ready. Exitcode: $exitCode"
    exit $exitCode
}

# Added PostgreSQL environment variable
[Environment]::SetEnvironmentVariable("PGBIN", $pgBin, "Machine")
[Environment]::SetEnvironmentVariable("PGROOT", $pgRoot, "Machine")
[Environment]::SetEnvironmentVariable("PGDATA", $pgData, "Machine")

# Stop and disable PostgreSQL service
$pgService = Get-Service -Name postgresql*
Stop-Service $pgService
$pgService | Set-Service -StartupType Disabled

Invoke-PesterTests -TestFile "Databases" -TestName "PostgreSQL"
