####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetContent = Get-ToolsetContent
$toolsetVersion = $toolsetContent.mongodb.version

# The canonical release notes URL has no trailing slash. The trailing slash variant answers
# 308 Permanent Redirect, which Invoke-WebRequest on Windows PowerShell 5.1 does not follow.
$releaseNotesUrl = "https://www.mongodb.com/docs/v$toolsetVersion/release-notes/$toolsetVersion"
$getMongoReleases = Invoke-WebRequest -Uri $releaseNotesUrl -UseBasicParsing

# Released patch versions are linked as changelog anchors, e.g.
# /docs/v7.0/release-notes/7.0-changelog/#std-label-7.0.40-changelog
# The section anchors on the same page have their dots stripped (#7040---aug-11-2026), so
# they are not usable to recover the version number.
$versionPattern = "#std-label-($([regex]::Escape($toolsetVersion))\.\d+)-changelog"
$minorVersions = $getMongoReleases.Links.href | Where-Object { $_ -notlike "*upcoming*" } | ForEach-Object {
    if ($_ -match $versionPattern) { $Matches[1] }
}

if (-not $minorVersions) {
    throw "Failed to parse any $toolsetVersion.x release version from $releaseNotesUrl"
}

$latestVersion = $minorVersions | Sort-Object { [version]$_ } -Descending | Select-Object -First 1

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
