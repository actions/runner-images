<#
.SYNOPSIS

This script selects local datastore based on the following rules:

- Name starts with ds-local-Datastore
- Datastore FreespaceGB > 400 Gb
- VM count on the datastore < 2

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
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIPassword,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$Cluster,

    [string]$TagCategory = "Busy"
)

# Import helpers module
Import-Module $PSScriptRoot\helpers.psm1 -DisableNameChecking

function Select-DataStore {
    param (
        [string]$VMName,
        [string]$TagCategory,
        [string]$TemplateDatastore = "ds-local-Datastore-*",
        [string]$Cluster,
        [int]$ThresholdInGb = 400,
        [int]$VMCount = 2,
        [int]$Retries = 5
    )

    # 1. Name starts with ds-local-Datastore
    # 2. FreespaceGB > 400 Gb
    # 3. Choose a datastore with the minimal VM count < 2

    Write-Host "Start Datastore selection process..."
    $clusterHosts = Get-Cluster -Name $Cluster | Get-VMHost
    $availableClusterDatastores = $clusterHosts | Get-Datastore -Name $TemplateDatastore | Where-Object -Property State -eq "Available"
    $availableDatastores = $availableClusterDatastores `
    | Where-Object { $_.FreeSpaceGB -ge $thresholdInGb } `
    | Where-Object {
        $vmOnDatastore = @((Get-ChildItem -Path $_.DatastoreBrowserPath).Name -notmatch '(^\.|vmkdump)').Count
        $vmOnDatastore -lt $vmCount } `
    | Group-Object -Property { $vmOnDatastore }

    $datastore = $availableDatastores | Select-Object @{n="VmCount";e={$_.Name}},@{n="DatastoreName";e={$_.Group | Get-Random}} -First 1
    $buildDatastore = $datastore.DatastoreName

    $tag = Get-Tag -Category $TagCategory -Name $VMName -ErrorAction Ignore
    if (-not $tag)
    {
        $tag = New-Tag -Name $VMName -Category $TagCategory
    }

    New-TagAssignment -Tag $tag -Entity $buildDatastore | Out-Null

    # Wait for 60 seconds to check if any other tags are assigned to the same datastore
    Start-Sleep -Seconds 60
    # If there are no datastores with 0 VMs, take a datastore with 1 VM (index 1 if datastore has 0 VMs and 2 if 1 VM)
    $index = 1 + [int]$datastore.VmCount
    $tagAssignments = (Get-TagAssignment -Entity $buildDatastore).Tag.Name | Select-Object -First $index
    $isAllow = $tagAssignments -contains $VMName

    if ($isAllow)
    {
        Write-Host "Datastore selected successfully"
        Write-Host "##vso[task.setvariable variable=buildDatastore;issecret=true]$buildDatastore"
        return
    }

    # Remove the tag if datastore wasn't selected
    Remove-Tag $tag -Confirm:$false

    $retries--
    if ($retries -le 0)
    {
        Write-Host "##vso[task.LogIssue type=error;]No datastores found for the condition"
        exit 1
    }

    Write-Host "Datastore select failed, $retries left"
    Select-DataStore -VMName $VMName -Cluster $Cluster -TagCategory $TagCategory -Retries $retries
}

# Connection to a vCenter Server system
Connect-VCServer -VIServer $VIServer -VIUserName $VIUserName -VIPassword $VIPassword

# Get a target datastore for current deployment
Select-DataStore -VMName $VMName -Cluster $Cluster -TagCategory $TagCategory
