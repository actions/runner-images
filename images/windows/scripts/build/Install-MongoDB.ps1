####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetContent = Get-ToolsetContent
$toolsetVersion = $toolsetContent.mongodb.version

$getMongoReleases = Invoke-WebRequest -Uri "mongodb.com/docs/manual/release-notes/$toolsetVersion/" -UseBasicParsing
$targetReleases = $getMongoReleases.Links.href | Where-Object { $_ -like "#$toolsetVersion*---*" }

$minorVersions = @()
foreach ($release in $targetReleases) {
    if ($release -notlike "*upcoming*") {
        $pattern = '\d+\.\d+\.\d+'
        $version = $release | Select-String -Pattern $pattern -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
        $minorVersions += $version
    }
}

$latestVersion = $minorVersions[0]

Install-Binary `
    -Url "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-$latestVersion-signed.msi" `
    -ExtraInstallArgs @('TARGETDIR=C:\PROGRA~1\MongoDB ADDLOCAL=ALL') `
    -ExpectedSignature $toolsetContent.mongodb.signature

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

# Install mongodb shell for mongodb > 5 version
if (Test-IsWin25) {
    $mongoshVersion = (Get-GithubReleasesByVersion -Repo "mongodb-js/mongosh" -Version "latest").version

    $mongoshDownloadUrl = Resolve-GithubReleaseAssetUrl `
        -Repo "mongodb-js/mongosh" `
        -Version $mongoshVersion `
        -UrlMatchPattern "mongosh-*-x64.msi"

    Install-Binary -Type MSI `
        -Url $mongoshDownloadUrl `
        -ExtraInstallArgs @('ALLUSERS=1') `
        -ExpectedSignature 'A5BBE2A6DA1D2A6E057EF870267E6A91E4D56BAA'
}

Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"
