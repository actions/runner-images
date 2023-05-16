<#
.SYNOPSIS

This script sets resources for VM

.PARAMETER VMName
VM name to resize (Example "macOS-10.15_20201012.4")

.PARAMETER VIServer
vCenter address (Example "10.0.1.16")

.PARAMETER VIUserName
vCenter username (Example "Administrator")

.PARAMETER VIPassword
vCenter password (Example "12345678")

.PARAMETER CpuCount
Target number of CPUs (Example "3")

.PARAMETER CoresPerSocketCount
Target number of cores per socket (Example "3")

.PARAMETER Memory
Target amount of memory in MB (Example "14336")

#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VMName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIPassword,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [int32]$CpuCount,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [int32]$CoresPerSocketCount,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [int64]$Memory
)

# Import helpers module
Import-Module $PSScriptRoot\helpers.psm1 -DisableNameChecking

# Connection to a vCenter Server system
Connect-VCServer -VIServer $VIServer -VIUserName $VIUserName -VIPassword $VIPassword

$vm = Get-VM $VMName
try {
    Write-Host "Change CPU count to $CpuCount, cores count to $CoresPerSocketCount, amount of RAM to $Memory"
    $vm | Set-VM -NumCPU $CpuCount -CoresPerSocket $CoresPerSocketCount -MemoryMB $Memory -Confirm:$false -ErrorAction Stop | Out-Null
} catch {
    Write-Host "##vso[task.LogIssue type=error;]Failed to change specs for VM '$VMName'"
    exit 1
}
