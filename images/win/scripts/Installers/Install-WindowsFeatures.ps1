# Install .NET Framework 3.5 (required by Chocolatey)
# Explicitly install all 4.7 sub features to include ASP.Net.
# As of  1/16/2019, WinServer 19 lists .Net 4.7 as NET-Framework-45-Features
Install-WindowsFeature -Name NET-Framework-Features -IncludeAllSubFeature
Install-WindowsFeature -Name NET-Framework-45-Features -IncludeAllSubFeature

if (Test-IsWin16) {
    Install-WindowsFeature -Name BITS -IncludeAllSubFeature
    Install-WindowsFeature -Name DSC-Service
}

# Install FS-iSCSITarget-Server
$fsResult = Install-WindowsFeature -Name FS-iSCSITarget-Server -IncludeAllSubFeature -IncludeManagementTools
if ( $fsResult.Success ) {
    Write-Host "FS-iSCSITarget-Server has been successfully installed"
} else {
    Write-Host "Failed to install FS-iSCSITarget-Server"
    exit 1
}

Write-Host "Install Containers feature"
Install-WindowsFeature -Name Containers

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "ContainersFeature"