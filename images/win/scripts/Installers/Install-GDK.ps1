################################################################################
##  File:  Install-GDK.ps1
##  Desc:  Install Microsoft Game Developement Kit
################################################################################

#Preparation
$tempFolder = Join-Path $([System.Environment]::GetEnvironmentVariable("TEMP", "Machine")) "GDK"
New-Item -Path $tempFolder -ItemType Directory -Force | Out-Null

#Fetching Microsoft GDK release and binaries download link
$GDKRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/GDK/releases/latest"
$GDKDownloadlink = $GDKRelease.zipball_url

#Downloading and extracting binaries
$GDKZipFilePath = Start-DownloadWithRetry -Url $GDKDownloadlink -Name "GDK.zip" -DownloadPath $tempFolder -RestDownload
Expand-Archive -Path $GDKZipFilePath -DestinationPath $tempFolder
$GDKSubFolder = (Get-ChildItem -Path $tempFolder -Directory).Name | Where-Object {$_ -like "microsoft-GDK*"}
$GDKSubFolderPath = Join-Path $tempFolder $GDKSubFolder

#Installing GDK
$GDKInstaller = Join-Path $GDKSubFolderPath "pgdk.exe"
Install-Binary -FilePath $GDKInstaller -ArgumentList ("/quiet", "/norestart")

Invoke-PesterTests -Testfile "Tools" -TestName "Microsoft GDK"