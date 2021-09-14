################################################################################
##  File:  Install-GDK.ps1
##  Desc:  Install Microsoft Game Developement Kit
################################################################################

#Fetching Microsoft GDK release
$tempFolder = "$env:windir\\Temp\\GDK"

$releaseVersion = 'June_2021_Update_2'
$GDKReleases = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/GDK/releases"
$GDKRelease = $GDKReleases | Where-Object {$_.tag_name -ceq $releaseVersion}
$GDKDownloadlink = $GDKRelease.zipball_url
$GDKZipFilePath = "$($tempFolder)\GDK.Zip"
New-Item -Path $tempFolder -ItemType Directory -Force | Out-Null
Invoke-RestMethod -Uri $GDKDownloadlink -Method Get -ContentType "application/zip" -OutFile $GDKZipFilePath
#Start-DownloadWithRetry -Url $GDKDownloadlink -Name "GDK.zip" -DownloadPath $tempFolder
Expand-Archive -Path $GDKZipFilePath -DestinationPath $tempFolder
$GDKSubFolder = (Get-ChildItem -Path $tempFolder -Directory).Name | Where-Object {$_ -like "microsoft-GDK*"}
$GDKSubFolderPath = "$($tempFolder)\$($GDKSubFolder)"
#Install GDK
$GDKInstaller = "$($GDKSubFolderPath)\pgdk.exe"
& $GDKInstaller /quiet /norestart

Invoke-PesterTests -Testfile "Tools" -TestName "Microsoft GDK"