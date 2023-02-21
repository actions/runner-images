Import-Module "$env:HOME/image-generation/helpers/Xcode.Helpers.psm1"

function Ensure-SimulatorInstalled {
    param(
        [Parameter(Mandatory)]
        [string]$RuntimeId,
        [Parameter(Mandatory)]
        [string]$DeviceId,
        [Parameter(Mandatory)]
        [string]$SimulatorName,
        [Parameter(Mandatory)]
        [string]$XcodeVersion
    )

    $simctlPath = Get-XcodeToolPath -Version $XcodeVersion -ToolName "simctl"
    if (-not (Test-Path $simctlPath)) {
        Write-Host "Skip validating simulator '$SimulatorName [$RuntimeId]' because Xcode $XcodeVersion is not installed"
        return
    }

    $simulatorFullNameDebug = "$SimulatorName [$RuntimeId]"
    Write-Host "Checking Xcode simulator '$simulatorFullNameDebug'..."

    Invoke-Expression "$simctlPath list --json" | Out-Null
    Invoke-Expression "$simctlPath list --json" | Out-Null
    & $simctlPath list --json

    # Get all available devices
    [string]$rawDevicesInfo = Invoke-Expression "$simctlPath list devices --json"
    $jsonDevicesInfo = ($rawDevicesInfo | ConvertFrom-Json).devices

    Write-Host "[DEBUG] Looking for existing simulator '$simulatorFullNameDebug'..."

    # Checking if simulator already exists
    $existingSimulator = $jsonDevicesInfo.$RuntimeId | Where-Object { $_.deviceTypeIdentifier -eq  $DeviceId } | Select-Object -First 1

    

    if ($null -eq $existingSimulator) {
        Write-Host "Simulator '$simulatorFullNameDebug' is missed. Creating it..."
        Invoke-Expression "$simctlPath create '$SimulatorName' '$DeviceId' '$RuntimeId'"
    } elseif ($existingSimulator.name -ne $SimulatorName) {
        Write-Host "Simulator '$simulatorFullNameDebug' is named incorrectly. Renaming it from '$($existingSimulator.name)' to '$SimulatorName'..."
        Invoke-Expression "$simctlPath rename '$($existingSimulator.udid)' '$SimulatorName'"
    } else {
        Write-Host "Simulator '$simulatorFullNameDebug' is installed correctly."
    }
}

Write-Host "Validating and fixing Xcode simulators..."
Get-BrokenXcodeSimulatorsList | ForEach-Object {
    Ensure-SimulatorInstalled -RuntimeId $_.RuntimeId -DeviceId $_.DeviceId -SimulatorName $_.SimulatorName -XcodeVersion $_.XcodeVersion
}