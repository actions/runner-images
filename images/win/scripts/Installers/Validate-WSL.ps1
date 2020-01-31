################################################################################
##  File:  Validate-WSL.ps1
##  Desc:  Validate Windows Subsystem for Linux installation
################################################################################

$FeatureInfo = (Get-WindowsOptionalFeature -Online | Where FeatureName -eq Microsoft-Windows-Subsystem-Linux)

if ($FeatureInfo.State -eq "Disabled") {
    Write-Host "Microsoft-Windows-Subsystem-Linux is Disabled"
    exit 1
}