################################################################################
##  File:  Validate-DiskSpace.ps1
##  Desc:  Validate free disk space
################################################################################

$availableSpaceMB =  [math]::Round((Get-PSDrive -Name C).Free / 1MB)
$minimumFreeSpaceMB = 15 * 1024

Write-Host "Available disk space: $availableSpaceMB MB"
if ($availableSpaceMB -le $minimumFreeSpaceMB)
{
    Write-Host "Not enough disk space on the image (minimum available space: $minimumFreeSpaceMB MB)"
    exit 1
}
