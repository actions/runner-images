# Define user and password for PostgreSQL database
$pgUser = "postgres"
$pgPwd = "root"

# Prepare environment variable for validation
Set-SystemVariable -SystemVariable PGUSER -Value $pgUser
Set-SystemVariable -SystemVariable PGPASSWORD -Value $pgPwd

# Define latest available version to install based on version specified in the toolset
$toolsetVersion = (Get-ToolsetContent).postgresql.version
$getPostgreReleases =  Invoke-WebRequest -Uri "https://git.postgresql.org/gitweb/?p=postgresql.git;a=tags" -UseBasicParsing
# Getting all links matched to the pattern (e.g.a=log;h=refs/tags/REL_14)
$TargetReleases = $getPostgreReleases.Links.href | Where-Object {$_ -match "a=log;h=refs/tags/REL_$toolsetVersion"}
[Int32]$OutNumber = $null
$MinorVersions = @()
foreach ($release in $TargetReleases) {
  $version = $release.split('/')[-1]
  # Checking if the latest symbol of the release version is actually a number. If yes, add to $MinorVersions array
  if ([Int32]::TryParse($($version.Split('_')[-1]),[ref]$OutNumber)){
    $MinorVersions += $OutNumber
  }
}
# Sorting and getting the last one
$TargetMinorVersions = ($MinorVersions | Sort-Object)[-1]

# Install latest PostgreSQL
# In order to get rid of error messages (we know we will have them), force ErrorAction to SilentlyContinue
$ErrorActionOldValue = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
# Starting from number 9 and going down, check if the installer is available. If yes, break the loop.
# If an installer with $TargetMinorVersions is not to be found, the $TargetMinorVersions will be decreased by 1
$increment = 9
do {
    $url = "https://get.enterprisedb.com/postgresql/postgresql-$toolsetVersion.$TargetMinorVersions-$increment-windows-x64.exe"
    $checkaccess = [System.Net.WebRequest]::Create($url)
    $response = $null
    $response = $checkaccess.GetResponse()
    if ($response) {
        $InstallerUrl = $response.ResponseUri.OriginalString
    } elseif (!$response -and ($increment -eq 0)) {
        $increment = 9
        $TargetMinorVersions--
    } else {
        $increment--
    }
} while (!$response)
# Return the previous value of ErrorAction and invoke Install-Binary function
$ErrorActionPreference = $ErrorActionOldValue
$InstallerName = $InstallerUrl.Split('/')[-1]
$ArgumentList = ("--install_runtimes 0","--superpassword root","--enable_acledit 1","--unattendedmodeui none","--mode unattended")
Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList

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

if ($exitCode -ne 0)
{
    Write-Host -Object "PostgreSQL is not ready. Exitcode: $exitCode"
    exit $exitCode
}

# Added PostgreSQL environment variable
Set-SystemVariable -SystemVariable PGBIN -Value $pgBin
Set-SystemVariable -SystemVariable PGROOT -Value $pgRoot
Set-SystemVariable -SystemVariable PGDATA -Value $pgData

# Stop and disable PostgreSQL service
$pgService = Get-Service -Name postgresql*
Stop-Service -InputObject $pgService
Set-Service -InputObject $pgService -StartupType Disabled

Invoke-PesterTests -TestFile "Databases" -TestName "PostgreSQL"