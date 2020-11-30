param(
    [Parameter(Mandatory=$true)]
    [string]$PackerLogPath,
    [string]$PrefixToPathTrim,
    [int]$PrintTopNLongest = 25
)

$DateTimeRegex = "(\d+\/\d+\/\d+ \d+:\d+:\d+)"
$TelemetryLineRegex = "\[INFO\] \(telemetry\)"
$StartProvisionerRegex = "^${DateTimeRegex} ${TelemetryLineRegex} Starting provisioner (.+)$"
$EndProvisionerRegex = "^${DateTimeRegex} ${TelemetryLineRegex} ending (.+)$"
$ShellScriptSubItemRegex = "${DateTimeRegex} ui: ==> .+: Provisioning with \w+ script: (.+)"
$DownloadUploadSubItemRegex = "${DateTimeRegex} ui: ==> .+: (Downloading .+|Uploading .+)"

function Start-ProvisionerItem {
    param([string]$ProvisionerType, [string]$StartTime)

    return @{
        ProvisionerType = $ProvisionerType
        StartTime = [DateTime]::Parse($StartTime)
        SubItems = @()
    }
}

function End-ProvisionerItem {
    param([object]$Provisioner, [string]$EndTime)

    $Provisioner.EndTime = [DateTime]::Parse($EndTime)
    $Provisioner.Duration = New-TimeSpan -Start $Provisioner.StartTime -End $Provisioner.EndTime
}

function Add-ProvisionerSubItem {
    param([object]$Provisioner, [string]$Command, [string]$DateTime)

    $lastItem = $Provisioner.SubItems | Select-Object -Last 1
    if ($lastItem) {
        $lastItem.EndTime = [DateTime]::Parse($DateTime)
        $lastItem.Duration = New-TimeSpan -Start $lastItem.StartTime -End $lastItem.EndTime
    }

    if ($Command) {
        if ($PrefixToPathTrim) { $Command = $Command.Replace($PrefixToPathTrim, ".") }
        $Provisioner.SubItems += @{
            Command = $Command
            StartTime = [DateTime]::Parse($DateTime)
        }
    }
}

function Invoke-TryFindProvisionerSubItem {
    param([object]$Provisioner, [string] $Line)

    if ($Provisioner.ProvisionerType -in "powershell", "shell", "windows-shell") {
        if ($Line -match $ShellScriptSubItemRegex) {
            Add-ProvisionerSubItem -Provisioner $Provisioner -Command $Matches[2] -DateTime $Matches[1]
        }
    } elseif ($Provisioner.ProvisionerType -eq "file") {
        if ($Line -match $DownloadUploadSubItemRegex) {
            Add-ProvisionerSubItem -Provisioner $Provisioner -Command $Matches[2] -DateTime $Matches[1]
        }
    }
}

function Assert-StartProvisioner {
    param([object]$Provisioner, [string]$ProvisionerType)
    if ($null -ne $Provisioner) {
        throw "New provisioner '$ProvisionerType' has been started but previous '$($Provisioner.ProvisionerType)' was not finished yet"
    }
}

function Assert-EndProvisioner {
    param([object]$Provisioner, [string]$ProvisionerType)
    if (($null -ne $Provisioner) -and ($Provisioner.ProvisionerType -ne $ProvisionerType)) {
        throw "Expected end of '$($Provisioner.ProvisionerType)' provisioner but found end of '$ProvisionerType'"
    }
}

$provisionersList = @()
$currentProvisioner = $null

if ((Get-Content $PackerLogPath -Raw) -notmatch $TelemetryLineRegex) {
    throw "Packer log doesn't contain diagnostic information. Env PACKER_LOG must be set to 1"
}
 
Get-Content $PackerLogPath | ForEach-Object {
    if ($_ -match $StartProvisionerRegex) {
        Assert-StartProvisioner -Provisioner $currentProvisioner -ProvisionerType $Matches[2]

        $currentProvisioner = Start-ProvisionerItem -ProvisionerType $Matches[2] -StartTime $Matches[1]
    } elseif (($_ -match $EndProvisionerRegex) -and $currentProvisioner) {
        Assert-EndProvisioner -Provisioner $currentProvisioner -ProvisionerType $Matches[2]

        End-ProvisionerItem -Provisioner $currentProvisioner -EndTime $Matches[1]
        Add-ProvisionerSubItem -Provisioner $currentProvisioner -Command $null -DateTime $Matches[1]
        $provisionersList += $currentProvisioner
        $currentProvisioner = $null
    } elseif ($currentProvisioner) {
        Invoke-TryFindProvisionerSubItem -Provisioner $currentProvisioner -Line $_
    }
}
$totalProvisionersTime = New-TimeSpan
$provisionersList | ForEach-Object { $totalProvisionersTime = $totalProvisionersTime.Add($_.Duration) }

# Print information about provisioners in order of execution
Write-Host "Build timeline:"
$provisionersList | ForEach-Object {
    Write-Host "- $($_.Duration) | $($_.ProvisionerType)"
    $_.SubItems | ForEach-Object {
        Write-Host "      $($_.Duration) | $($_.Command)"
    }
    Write-Host ""
}
Write-Host "Total provisioners time: $totalProvisionersTime"

if ($PrintTopNLongest -gt 0) {
    Write-Host "`n`nTop longest provisioners:"
    $provisionersList | ForEach-Object {
        if ($_.SubItems.Length -gt 0) { $_.SubItems } else { @{ Command = $_.ProvisionerType; Duration = $_.Duration } }
    } | Sort-Object { $_.Duration } | Select-Object -Last $PrintTopNLongest | ForEach-Object {
        Write-Host "- $($_.Duration) | $($_.Command)"
    }
}
