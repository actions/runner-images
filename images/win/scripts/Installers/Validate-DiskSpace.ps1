################################################################################
##  File:  Validate-DiskSpace.ps1
##  Desc:  Validate free disk space
################################################################################

$availableFreeSpace = ([IO.DriveInfo]::GetDrives() | Where-Object {$_.Name -eq 'C:\'}).AvailableFreeSpace / 1024 / 1024 / 1024
$minimumFreeSpaceGB = 15

if ($availableFreeSpace -le $minimumFreeSpaceGB)
{
    Write-Host 'Not enough disk space on the image'
    exit 1
}
