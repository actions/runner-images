[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$VIPassword
)

# Import helpers module
Import-Module $PSScriptRoot\helpers.psm1 -DisableNameChecking

# Connection to a vCenter Server system
Connect-VCServer

# Get a target datastore for current deployment
# 1. Name starts with ds-local-Datastore
# 2. FreespaceGB > 400 Gb
# 3. VM count on a datastore < 2
$templateDatastore = "ds-local-Datastore-*"
$thresholdInGb = 400
$vmCount = 2
$allDatastores = Get-Datastore -Name $templateDatastore | Where-Object { $_.State -eq "Available" }
$buildDatastore = $allDatastores | Where-Object { $_.FreeSpaceGB -ge $thresholdInGb } | Where-Object {
            $vmOnDatastore = @((Get-ChildItem -Path $_.DatastoreBrowserPath).Name -notmatch "^\.").Count
            $vmOnDatastore -lt $vmCount
        } | Select-Object -ExpandProperty Name -First 1

if ($buildDatastore)
{
    Write-Host "Datastore selected successfully"
    Write-Host "##vso[task.setvariable variable=buildDatastore;issecret=true]$buildDatastore"
}
else
{
    Write-Host "##vso[task.LogIssue type=error;]No datastores found for the condition"
    exit 1
}