################################################################################
##  File:  Validate-DiskSpace.ps1
##  Desc:  Validate free disk space
################################################################################

$availableFreeSpace = (Get-PSDrive -Name C).Free
$minimumFreeSpaceGB = 15GB

if ($availableFreeSpace -le $minimumFreeSpaceGB)
{
    Write-Host 'Not enough disk space on the image'
    exit 1
}
