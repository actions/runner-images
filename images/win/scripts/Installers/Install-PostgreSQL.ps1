# Define user and password for PostgreSQL database
$pgUser = "postgres"
$pgPwd = "root"

# Prepare environment variable for validation
Set-SystemVariable -SystemVariable PGUSER -Value $pgUser
Set-SystemVariable -SystemVariable PGPASSWORD -Value $pgPwd

# Define latest available version to install based on version specified in the toolset
$toolsetVersion = (Get-ToolsetContent).postgresql.version
#$latestChocoPackage = Get-LatestChocoPackageVersion -TargetVersion $toolsetVersion -PackageName "postgresql"
$getPostgreReleases =  Invoke-WebRequest -Uri "https://git.postgresql.org/gitweb/?p=postgresql.git;a=tags" -UseBasicParsing 
$TargetReleases = $getPostgreReleases.Links.href | Where-Object {$_ -match "a=log;h=refs/tags/REL_$toolsetVersion"}
[Int32]$OutNumber = $null
$MinorVersions = @()
foreach ($release in $TargetReleases) {
  $version = $release.split('/')[-1]
  if ([Int32]::TryParse($($version.Split('_')[-1]),[ref]$OutNumber)){
    $MinorVersions += $OutNumber
  }
}
$TargetMinorVersions = ($MinorVersions | Sort-Object)[-1]

# Install latest PostgreSQL
#Choco-Install -PackageName postgresql -ArgumentList "-i", "--params", "'/Password:$pgPwd /NoPath'", "--params-global", "--version=$latestChocoPackage"
$ErrorActionOldValue = $ErrorActionPreference
$ErrorActionPreference = 'SilentlyContinue'
foreach ($increment in 9..0) {
    $url = "https://get.enterprisedb.com/postgresql/postgresql-$toolsetVersion.$TargetMinorVersions-$increment-windows-x64.exe"
    $checkaccess = [System.Net.WebRequest]::Create($url)
    $response =$null
    $response = $checkaccess.GetResponse()
    if ($response) {
        $InstallerUrl =  $response.ResponseUri.OriginalString
        break
    }
}
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