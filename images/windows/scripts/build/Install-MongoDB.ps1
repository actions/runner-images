####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetVersion = (Get-ToolsetContent).mongodb.version

$getMongoReleases =  Invoke-WebRequest -Uri "mongodb.com/docs/manual/release-notes/$toolsetVersion/" -UseBasicParsing
$TargetReleases = $getMongoReleases.Links.href | Where-Object {$_ -like "#$toolsetVersion*---*"}

$MinorVersions = @()
foreach ($release in $TargetReleases) {
    if ($release -notlike "*upcoming*") {
      $pattern = '\d+\.\d+\.\d+'
      $version = $release | Select-String -Pattern $pattern -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
      $MinorVersions += $version
    }
  }

$LatestVersion = $MinorVersions[0]

Install-Binary `
  -Url "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-$LatestVersion-signed.msi" `
  -ExtraInstallArgs @('TARGETDIR=C:\PROGRA~1\MongoDB ADDLOCAL=ALL') `
  -ExpectedSignature (Get-ToolsetContent).mongodb.signature

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

Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"
