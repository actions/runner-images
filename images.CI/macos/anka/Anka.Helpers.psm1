function Push-AnkaTemplateToRegistry {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $RegistryUrl,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $TagName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $TemplateName
    )

    # if registry uuid doesn't match than delete an image in registry
    $AnkaCaCrtPath="$HOME/.config/anka/certs/anka-ca-crt.pem"
    $images = anka --machine-readable registry --cacert $AnkaCaCrtPath --registry-path $RegistryUrl list | ConvertFrom-Json | ForEach-Object body
    $images | Where-Object name -eq $TemplateName | ForEach-Object {
        $id = $_.uuid
        Show-StringWithFormat "Deleting '$TemplateName[$id]' VM and '$TagName' tag"
        $curlCommand='curl -s -X DELETE -k "{0}/registry/vm?id={1}"' -f $RegistryUrl, $id
        Invoke-AnkaCommand -Command $curlCommand
    }

    $command = "anka registry --cacert $AnkaCaCrtPath --registry-path $RegistryUrl push --force --tag $TagName $TemplateName"
    Invoke-AnkaCommand -Command $command
}

function Get-AnkaVM {
    param(
        [string] $VMName
    )

    $command = "anka --machine-readable list"
    if (-not [string]::IsNullOrEmpty($VMName)) {
        $command = "anka --machine-readable show $VMName"
    }
    Invoke-AnkaCommand -Command $command | ConvertFrom-Json | Foreach-Object body
}

function Get-AnkaVMStatus {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName
    )

    $command = "anka --machine-readable list $VMName"
    Invoke-AnkaCommand -Command $command | ConvertFrom-Json | Foreach-Object { $_.body.status }
}

function Get-AnkaVMIPAddress {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName
    )

    Get-AnkaVM -VMName $VMName | Foreach-Object ip
}

function Invoke-AnkaCommand {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Command
    )

    $result = bash -c "$Command 2>&1" | Out-String
    if ($LASTEXITCODE -ne 0) {
        Write-Error "There is an error during command execution:`n$result"
        exit 1
    }
    $result
}

function New-AnkaVMTemplate {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $InstallerPath,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $TemplateName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $TemplateUsername,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $TemplatePassword,

        [Parameter(Mandatory)]
        [int] $CPUCount,

        [Parameter(Mandatory)]
        [int] $RamSizeGb,

        [Parameter(Mandatory)]
        [int] $DiskSizeGb
    )

    $env:ANKA_DEFAULT_USER = $TemplateUsername
    $env:ANKA_DEFAULT_PASSWD = $TemplatePassword
    $env:ANKA_CREATE_SUSPEND = 0
    $command = "anka create --cpu-count '$CPUCount' --ram-size '${RamSizeGb}G' --disk-size '${DiskSizeGb}G' --app '$InstallerPath' $TemplateName"
    Invoke-AnkaCommand -Command $command
}

function Remove-AnkaVM {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName
    )

    $command = "anka delete $VMName --yes"
    $isTemplateExists = Get-AnkaVM | Where-Object name -eq $VMName
    if ($isTemplateExists) {
        $null = Invoke-AnkaCommand -Command $command
    }
}

function Set-AnkaVMVideoController {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $ShortMacOSVersion,

        [ValidateSet("fbuf", "pg")]
        [string] $Controller = "pg"
    )

    $command = "anka modify $VMName set display -c $Controller"
    # Apple Metal is available starting from Big Sur
    if (-not $ShortMacOSVersion.StartsWith("10.")) {
        $null = Invoke-AnkaCommand -Command $command
    }
}

function Set-AnkaVMDisplayResolution {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $DisplayResolution
    )

    $command = "anka modify $VMName set display -r $DisplayResolution"
    $null = Invoke-AnkaCommand -Command $command
}

function Start-AnkaVM {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName
    )

    $command = "anka start $VMName"
    $vmStatus = Get-AnkaVMStatus -VMName $VMName
    if ($vmStatus -eq "stopped") {
        $null = Invoke-AnkaCommand -Command $command
    }
}

function Stop-AnkaVM {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName
    )

    $command = "anka stop $VMName"
    $vmStatus = Get-AnkaVMStatus -VMName $VMName
    if ($vmStatus -eq "running") {
       $null = Invoke-AnkaCommand -Command $command
    }
}

function Wait-AnkaVMIPAddress {
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName,

        [int] $RetryCount = 20,
        [int] $Seconds = 60
    )

    $condition = {
        $vmStatus = Get-AnkaVMStatus -VMName $VMName
        if ($vmStatus -eq "failed") {
            Write-Host "`t    [-] $VMName is in failed status"
            exit 1
        }
        Get-AnkaVMIPAddress -VMName $VMName
    }
    $null = Invoke-WithRetry -BreakCondition $condition -RetryCount $RetryCount -Seconds $Seconds
}

function Wait-AnkaVMSSHService {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $VMName,

        [int] $RetryCount = 20,
        [int] $Seconds = 60
    )

    Start-Sleep -Seconds $Seconds
    Write-Host "`t[*] Waiting for '$VMName' VM to get an IP address"
    Wait-AnkaVMIPAddress -VMName $VMName -RetryCount $RetryCount -Seconds $Seconds

    $ipAddress = Get-AnkaVMIPAddress -VMName $VMName
    Write-Host "`t[*] The '$ipAddress' IP address for '$VMName' VM"

    Write-Host "`t[*] Checking if SSH on a port is open"
    $isSSHPortOpen = Test-SSHPort -IPAddress $ipAddress
    if (-not $isSSHPortOpen) {
        Write-Host "`t[x] SSH port is closed"
        exit 1
    }
}
