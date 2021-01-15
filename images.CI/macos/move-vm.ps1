<#
.SYNOPSIS

This script migrates given VM to another datastore

.PARAMETER VMName
VM name to migrate (Example "macOS-10.15_20201012.4")

.PARAMETER TargetDataStore
Target datastore (Example "ds-image")

.PARAMETER VIServer
vCenter address (Example "10.0.1.16")

.PARAMETER VIUserName
vCenter username (Example "Administrator")

.PARAMETER VIPassword
vCenter password (Example "12345678")
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VMName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$TargetDataStore,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIPassword,

    [int32]$CpuCount,

    [int32]$CoresPerSocketCount,

    [int64]$Memory
)

# Import helpers module
Import-Module $PSScriptRoot\helpers.psm1 -DisableNameChecking

# Connection to a vCenter Server system
Connect-VCServer -VIServer $VIServer -VIUserName $VIUserName -VIPassword $VIPassword

# Clear previously assigned tag with VM Name
try {
    Remove-Tag $VMName -Confirm:$false
} catch {
    Write-Host "Tag with $VMName doesn't exist"
}

$vm = Get-VM $VMName
if ($env:AGENT_JOBSTATUS -eq 'Failed') {
    try {
        if($vm.PowerState -ne "PoweredOff") {
            Stop-VM -VM $vm -Confirm:$false -ErrorAction Stop | Out-Null
        }
        Set-VM -VM $vm -Name "${VMName}_failed" -Confirm:$false -ErrorAction Stop | Out-Null
        Write-Host "VM has been successfully powered off and renamed to [${VMName}_failed]"
    } catch {
        Write-Host "##vso[task.LogIssue type=error;]Failed to power off and rename VM '$VMName'"
    }
}

try {
    Move-VM -Vm $vm -Datastore $TargetDataStore -ErrorAction Stop | Out-Null
    Write-Host "VM has been moved successfully to target datastore '$TargetDataStore'"
} catch {
    Write-Host "##vso[task.LogIssue type=error;]Failed to move VM '$VMName' to target datastore '$TargetDataStore'"
}

try {
    if ($VMName -notmatch "10.13") {
        Write-Host "Change CPU count to $CpuCount, cores count to $CoresPerSocketCount, amount of RAM to $Memory"
        $vm | Set-VM -NumCPU $CpuCount -CoresPerSocket $CoresPerSocketCount -MemoryMB $Memory -Confirm:$false -ErrorAction Stop | Out-Null
    }
} catch {
    Write-Host "##vso[task.LogIssue type=error;]Failed to change specs for VM '$VMName'"
}
