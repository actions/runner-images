####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

# Install mongodb package
$toolsetVersion = (Get-ToolsetContent).mongodb.version

$getMongoReleases =  Invoke-WebRequest -Uri "https://www.mongodb.com/docs/upcoming/release-notes/$toolsetVersion" -UseBasicParsing
$TargetReleases = $getMongoReleases.Links.href | Where-Object {$_ -like "*std-label-$toolsetVersion*"}

$MinorVersions = @()
foreach ($release in $TargetReleases) {
    $pattern = '\d+\.\d+\.\d+'
    $version = $release | Select-String -Pattern $pattern -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value }
    $MinorVersions += $version
  }

$LatestVersion = $MinorVersions[0]

$installDir = "c:\PROGRA~1\MongoDB"
$binaryName = "mongodb-windows-x86_64-$LatestVersion-signed.msi"
$downloadURL = "https://fastdl.mongodb.org/windows/$BinaryName"
$installArg = "INSTALLLOCATION=$installDir ADDLOCAL=all"
Install-Binary -Url $downloadURL -Name $binaryName -ArgumentList ("/q","/i","${env:Temp}\$binaryName", $installArg)


# Add mongodb to the PATH
$mongodbService = "mongodb"
$mongoPath = (Get-CimInstance Win32_Service -Filter "Name LIKE '$mongodbService'").PathName
$mongoBin = Split-Path -Path $mongoPath.split('"')[1]
Add-MachinePathItem "$mongoBin"

# Wait for mongodb service running
$svc = Get-Service $mongodbService
$svc.WaitForStatus('Running','00:01:00')

# Stop and disable mongodb service
Stop-Service -Name $mongodbService
Set-Service $mongodbService -StartupType Disabled

Invoke-PesterTests -TestFile "Databases" -TestName "MongoDB"