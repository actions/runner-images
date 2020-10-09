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

$ProgressPreference = "SilentlyContinue"
$WarningPreference = "SilentlyContinue"

# connection to a vCenter Server system
try
{
    $null = Set-PowerCLIConfiguration -Scope Session -InvalidCertificateAction Ignore -ParticipateInCEIP $false -Confirm:$false -WebOperationTimeoutSeconds 600
    $securePassword = ConvertTo-SecureString -String $VIPassword -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential($VIUserName, $securePassword)
    $null = Connect-VIServer -Server $VIServer -Credential $cred -ErrorAction Stop
    Write-Host "Connection to the vSphere server has been established"
}
catch
{
    Write-Host "##vso[task.LogIssue type=error;]Failed to connect to the vSphere server"
    exit 1
}

# get a target datastore for current deployment
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
    Write-Host "##vso[task.setvariable variable=buildDatastore;issecret=true]$buildDatastore"
}
else
{
    Write-Host "##vso[task.LogIssue type=error;]No datastores found for the condition"
    exit 1
}