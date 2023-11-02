[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [version] $MacOSVersion,

    [ValidateNotNullOrEmpty()]
    [string] $TemplateUsername,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $TemplatePassword,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string] $RegistryUrl,

    [ValidateNotNullOrEmpty()]
    [string] $TemplateName,

    [bool] $DownloadLatestVersion = $true,
    [bool] $PushToRegistry = $true,
    [bool] $BetaSearch = $false,
    [bool] $InstallSoftwareUpdate = $true,
    [bool] $EnableAutoLogon = $true,
    [int] $CPUCount = 6,
    [int] $RamSizeGb = 7,
    [int] $DiskSizeGb = 300,
    [string] $DisplayResolution = "1920x1080",
    [string] $TagName = [DateTimeOffset]::Now.ToUnixTimeSeconds(),
    [string] $Uuid = "4203018E-580F-C1B5-9525-B745CECA79EB"
)

$ErrorActionPreference = "Stop"
$WarningPreference = "SilentlyContinue"

# Import helper modules
Import-Module "$PSScriptRoot/Anka.Helpers.psm1"
Import-Module "$PSScriptRoot/Service.Helpers.psm1"

# Helper functions
function Invoke-EnableAutoLogon {
    if (-not $EnableAutoLogon) {
        Write-Host "`t[*] Skip configuring AutoLogon"
        return
    }

    $ipAddress = Get-AnkaVMIPAddress -VMName $TemplateName

    Wait-AnkaVMSSHService -VMName $TemplateName -Seconds 30

    Write-Host "`t[*] Enable AutoLogon"
    Enable-AutoLogon -HostName $ipAddress -UserName $TemplateUsername -Password $TemplatePassword

    Write-Host "`t[*] Reboot '$TemplateName' VM to enable AutoLogon"
    Restart-VMSSH -HostName $ipAddress | Show-StringWithFormat

    Wait-AnkaVMSSHService -VMName $TemplateName -Seconds 30

    Write-Host "`t[*] Checking if AutoLogon is enabled"
    Test-AutoLogon -VMName $TemplateName -UserName $TemplateUsername
}

function Invoke-SoftwareUpdate {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Password
    )

    if (-not $InstallSoftwareUpdate) {
        Write-Host "`t[*] Skip installing software updates"
        return
    }

    $ipAddress = Get-AnkaVMIPAddress -VMName $TemplateName

    # Unenroll Seed
    Write-Host "`t[*] Reseting the seed before requesting stable versions"
    Remove-CurrentBetaSeed -HostName $ipAddress | Show-StringWithFormat

    # Install Software Updates
    # Security updates may not be able to install(hang, freeze) when AutoLogon is turned off
    Write-Host "`t[*] Finding available software"
    $newUpdates = Get-SoftwareUpdate -HostName $ipAddress

    if (-not $newUpdates) {
        Write-Host "`t[*] No Updates Available"
        return
    }

    Write-Host "`t[*] Fetching Software Updates ready to install on '$TemplateName' VM:"
    Show-StringWithFormat $newUpdates
    $listOfNewUpdates = $($($newUpdates.Split("*")).Split("Title") | Where-Object {$_ -match "Label:"}).Replace("Label: ", '')
    Write-Host "`t[*] Installing Software Updates on '$TemplateName' VM:"
    Install-SoftwareUpdate -HostName $ipAddress -listOfUpdates $listOfNewUpdates -Password $Password | Show-StringWithFormat

    # Check if Action: restart
    # Make an array of updates
    $listOfNewUpdates = $newUpdates.split('*').Trim('')
    foreach ($newupdate in $listOfNewUpdates) {
        # Will be True if the value is not Venture, not empty, and contains "Action: restart" words
        if ($newupdate.Contains("Action: restart") -and !$newupdate.Contains("macOS Ventura") -and !$newupdate.Contains("macOS Sonoma") -and (-not [String]::IsNullOrEmpty($newupdate))) {
            Write-Host "`t[*] Sleep 60 seconds before the software updates have been installed"
            Start-Sleep -Seconds 60

            Write-Host "`t[*] Waiting for loginwindow process"
            Wait-LoginWindow -HostName $ipAddress | Show-StringWithFormat

            # Re-enable AutoLogon after installing a new security software update
            Invoke-EnableAutoLogon

            # Check software updates have been installed
            $updates = Get-SoftwareUpdate -HostName $ipAddress
            if ($updates.Contains("Action: restart")) {
                Write-Host "`t[x] Software updates failed to install: "
                Show-StringWithFormat $updates
                exit 1
            }
        }
    }

    Write-Host "`t[*] Show the install history:"
    $hUpdates = Get-SoftwareUpdateHistory -HostName $ipAddress
    Show-StringWithFormat $hUpdates
}

function Invoke-UpdateSettings {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string] $Password
    )
    $isConfRequired = $InstallSoftwareUpdate -or $EnableAutoLogon
    if (-not $isConfRequired) {
        Write-Host "`t[*] Skip additional configuration"
        return
    }

    Write-Host "`t[*] Starting '$TemplateName' VM"
    Start-AnkaVM -VMName $TemplateName

    Write-Host "`t[*] Waiting for SSH service on '$TemplateName' VM"
    Wait-AnkaVMSSHService -VMName $TemplateName -Seconds 30

    # Configure AutoLogon
    Invoke-EnableAutoLogon

    # Install software updates
    Invoke-SoftwareUpdate -Password $Password

    Write-Host "`t[*] Stopping '$TemplateName' VM"
    Stop-AnkaVM -VMName $TemplateName
}

function Test-VMStopped {
    $vmStatus = Get-AnkaVMStatus -VMName $TemplateName
    if ($vmStatus -ne "stopped") {
        Write-Host "`t[x] VM '$TemplateName' state is not stopped. The current state is '$vmStatus'"
        exit 1
    }
}

# Password is passed as env-var "SSHPASS"
$env:SSHUSER = $TemplateUsername
$env:SSHPASS = $TemplatePassword

Write-Host "`n[#1] Download macOS application installer:"
$shortMacOSVersion = Get-ShortMacOSVersion -MacOSVersion $MacOSVersion
if ([string]::IsNullOrEmpty($TemplateName)) {
    $osArch = $(arch)
    if ($osArch -eq "arm64") {
        $macOSInstaller = Get-MacOSIPSWInstaller -MacOSVersion $MacOSVersion -DownloadLatestVersion $DownloadLatestVersion -BetaSearch $BetaSearch
        $TemplateName = "clean_macos_${shortMacOSVersion}_${osArch}_${DiskSizeGb}gb"
    } else {
        $macOSInstaller = Get-MacOSInstaller -MacOSVersion $MacOSVersion -DownloadLatestVersion $DownloadLatestVersion -BetaSearch $BetaSearch
        $TemplateName = "clean_macos_${shortMacOSVersion}_${DiskSizeGb}gb"
    }
}

Write-Host "`n[#2] Create a VM template:"
Write-Host "`t[*] Deleting existed template with name '$TemplateName' before creating a new one"
Remove-AnkaVM -VMName $TemplateName

# Temporary disable VNC for macOS 14
# It's probably Anka's bug fixed in 3.3.2
if ($shortMacOSVersion -eq "14") {
    $env:ANKA_CREATE_VNC = 0
}

Write-Host "`t[*] Creating Anka VM template with name '$TemplateName' and '$TemplateUsername' user"
Write-Host "`t[*] CPU Count: $CPUCount, RamSize: ${RamSizeGb}G, DiskSizeGb: ${DiskSizeGb}G, InstallerPath: $macOSInstaller, TemplateName: $TemplateName"
New-AnkaVMTemplate -InstallerPath "$macOSInstaller" `
                   -TemplateName $TemplateName `
                   -TemplateUsername $TemplateUsername `
                   -TemplatePassword $TemplatePassword `
                   -CPUCount $CPUCount `
                   -RamSizeGb $RamSizeGb `
                   -DiskSizeGb $DiskSizeGb | Show-StringWithFormat

Write-Host "`n[#3] Configure AutoLogon and/or install software updates:"
Invoke-UpdateSettings -Password $TemplatePassword

Write-Host "`n[#4] Finalization '$TemplateName' configuration and push to the registry:"
Write-Host "`t[*] The '$TemplateName' VM status is stopped"
Test-VMStopped

# Configure graphics settings
Write-Host "`t[*] Enabling Graphics Acceleration with Apple Metal for '$TemplateName' VM"
Set-AnkaVMVideoController -VMName $TemplateName -ShortMacOSVersion $ShortMacOSVersion

Write-Host "`t[*] Setting screen resolution to $DisplayResolution for $TemplateName"
Set-AnkaVMDisplayResolution -VMName $TemplateName -DisplayResolution $DisplayResolution

# Set static UUID
Set-AnkaVMUuid -VMName $TemplateName -Uuid $Uuid

if ($PushToRegistry) {
    # Push a VM template (and tag) to the Cloud
    Write-Host "`t[*] Pushing '$TemplateName' image with '$TagName' tag to the '$RegistryUrl' registry..."
    Push-AnkaTemplateToRegistry -RegistryUrl $registryUrl -TagName $TagName -TemplateName $TemplateName
}
