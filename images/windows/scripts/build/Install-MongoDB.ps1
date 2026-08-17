####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetContent = Get-ToolsetContent
$toolsetVersion = $toolsetContent.mongodb.version

# Resolve the latest patch release from the downloads feed rather than the release notes
# page. The feed lists the newest release of each supported branch and is not subject to the
# markup and URL changes that repeatedly broke scraping the docs.
$mongoReleasesUrl = "https://downloads.mongodb.org/current.json"
$mongoReleases = Invoke-RestMethod -Uri $mongoReleasesUrl

$latestVersion = $mongoReleases.versions.version |
    Where-Object { $_ -like "$toolsetVersion.*" } |
    Sort-Object { [version]$_ } -Descending |
    Select-Object -First 1

if (-not $latestVersion) {
    throw "Unable to resolve latest MongoDB $toolsetVersion release from $mongoReleasesUrl"
}

Install-Binary `
    -Url "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-$latestVersion-signed.msi" `
    -ExtraInstallArgs @('TARGETDIR=C:\PROGRA~1\MongoDB ADDLOCAL=ALL') `
    -ExpectedSubject 'CN="MONGODB, INC.", O="MONGODB, INC.", L=New York, S=New York, C=US'

# Add mongodb to the PATH
$mongoPath = (Get-CimInstance Win32_Service -Filter "Name LIKE 'mongodb'").PathName
$mongoBin = Split-Path -Path $mongoPath.split('"')[1]
Add-MachinePathItem "$mongoBin"

# Wait for mongodb service running
$mongodbService = Get-Service "mongodb"
$mongodbService.WaitForStatus('Running', '00:01:00')

# Stop and disable mongodb service
Stop-Service $mongodbService
$mongodbService | Set-Service -StartupType Disabled

# Install mongodb shell for mongodb
$mongoshVersion = (Get-GithubReleasesByVersion -Repo "mongodb-js/mongosh" -Version "latest").version

$mongoshDownloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "mongodb-js/mongosh" `
    -Version $mongoshVersion `
    -UrlMatchPattern "mongosh-*-x64.msi"

Install-Binary -Type MSI `
    -Url $mongoshDownloadUrl `
    -ExtraInstallArgs @('ALLUSERS=1') `
    -ExpectedSubject 'CN="MongoDB, Inc.", O="MongoDB, Inc.", L=New York, S=New York, C=US'


Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"
