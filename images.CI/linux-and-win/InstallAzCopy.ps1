Write-Host 'Acquiring AzCopy executable...'

$zipFilePath = Join-Path -Path $env:Temp -ChildPath azcopy.zip
$tempPath = Join-Path -Path $env:Temp -ChildPath azcopy
$releaseZipUrl = 'https://azcopyvnext.azureedge.net/release20230420/azcopy_windows_amd64_10.18.1.zip'
$azcopyChecksum = 'FB31BD7D2B8892DDC2634FDE7290C8B0E507E9981A20DDC6A8415BDDB48C5E07'

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $releaseZipUrl -OutFile $zipFilePath

if (Test-Path -Path $tempPath)
{
    Remove-Item -Path $tempPath -Recurse -Force
}

$computedHash = (Get-FileHash -Algorithm SHA256 $zipFilePath).Hash
if($computedHash -ne $azcopyChecksum)
{
    Write-Error 'Checksums did not match for downloaded AzCopy file.'
    exit 1
}

Write-Host 'Unzipping AzCopy file...'
Expand-Archive -Path $zipFilePath -DestinationPath $tempPath
$azcopyPath = Resolve-Path -Path $tempPath\*\azcopy.exe
& $azcopyPath --version

Write-Host "##vso[task.setvariable variable=azcopyPath]$azcopyPath"