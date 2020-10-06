[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VIServer,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VIUserName,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VIPassword,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [string]$VMName
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
    Write-Host "##[debug]Connecting to the server....."
}
catch
{
    Write-Host "##vso[task.LogIssue type=error;]VISphere connection error"
    exit 1
}

# remove VM
$vm = Get-VM -Name $VMName -ErrorAction SilentlyContinue
$vmState = $vm.PowerState

if ($vm)
{
    $vmState = $vm.PowerState
    if ($vmState -ne 'PoweredOff')
    {
        try
        {
            Stop-VM -VM $vm -Confirm:$false -ErrorAction Stop
            Write-Host "VM '$VMName' has been powered off"
        }
        catch
        {
            Write-Host "##vso[task.LogIssue type=error;]ERROR: unable to shutdown '$VMName'"
        }
    }

    try
    {
        Remove-VM -VM $vm -DeletePermanently -Confirm:$false -ErrorAction Stop
        Write-Host "VM '$VMName' has been removed"
    }
    catch
    {
        Write-Host "##vso[task.LogIssue type=error;]ERROR: unable to remove '$VMName'"
    }
}
else
{
    Write-Host "VM '$VMName' not found"
}