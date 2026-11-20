################################################################################
##  File:  Configure-Xcode-Simulators.ps1
##  Team:  CI-Build
##  Desc:  Check and remove duplicate simulators and pre-warm standard simulator
################################################################################

function Invoke-SimulatorPrewarm {
    param (
        [int] $timeoutMinutes = 5
    )

    Write-Host "Pre-warming standard iOS simulator..."
    try {
        $rawDevices = $(xcrun simctl list -j devices | ConvertFrom-Json)
        $targetDevice = $null

        foreach ($runtime in $rawDevices.devices.psobject.Properties.name) {
            if ($runtime -like "*iOS*") {
                foreach ($device in $rawDevices.devices.$runtime) {
                    $available = (($device.isAvailable -eq $true) -or ($device.isAvailable -eq "YES") -or ($device.availability -eq "(available)"))
                    if ($available -and $device.name -like "iPhone*") {
                        $targetDevice = $device
                        if ($device.name -like "*16*" -or $device.name -like "*15*") {
                            break
                        }
                    }
                }
            }
            if ($null -ne $targetDevice -and ($targetDevice.name -like "*16*" -or $targetDevice.name -like "*15*")) {
                break
            }
        }

        if ($null -eq $targetDevice) {
            Write-Host "No available iPhone simulator found for pre-warming. Skipping."
            return
        }

        $udid = $targetDevice.udid
        $name = $targetDevice.name
        Write-Host "Selected simulator for pre-warming: $name ($udid)"

        Write-Host "Booting simulator $udid ..."
        xcrun simctl boot $udid

        try {
            Write-Host "Waiting for simulator to finish boot and data migration (timeout: ${timeoutMinutes}m)..."
            $bootJob = Start-Job -ScriptBlock {
                param($id)
                $ErrorActionPreference = "Stop"
                xcrun simctl bootstatus $id -b
                if ($LASTEXITCODE -ne 0) {
                    throw "Simulator bootstatus failed with exit code $LASTEXITCODE."
                }
            } -ArgumentList $udid

            $completed = Wait-Job -Job $bootJob -Timeout ($timeoutMinutes * 60)
            if ($null -eq $completed) {
                Write-Warning "Simulator bootstatus wait timed out after ${timeoutMinutes} minutes."
            } elseif ($completed.State -ne "Completed") {
                throw "Simulator bootstatus job ended in state $($completed.State)."
            } else {
                Receive-Job -Job $bootJob -ErrorAction Stop | Out-Null
                Write-Host "Simulator $name successfully booted and finished initial data migration."

                # Pre-warm text input / keyboard XPC service
                Write-Host "Triggering TextInput service pre-warm..."
                 xcrun simctl spawn $udid launchctl kickstart -k "system/com.apple.TextInput.kbd"
                 if ($LASTEXITCODE -ne 0) {
                     throw "Failed to pre-warm the simulator keyboard service (exit code $LASTEXITCODE)."
                 }
                 Start-Sleep -Seconds 5
            }
        }
        finally {
            Write-Host "Shutting down pre-warmed simulator $udid ..."
            xcrun simctl shutdown $udid 2>$null
            Write-Host "Simulator pre-warming completed."
        }
    }
    catch {
        Write-Warning "Simulator pre-warming encountered an error: $_"
    }
}

Import-Module "~/image-generation/helpers/Common.Helpers.psm1"
Import-Module "~/image-generation/helpers/Xcode.Helpers.psm1"
$arch = Get-Architecture
$xcodeVersions = (Get-ToolsetContent).xcode.${arch}.versions
$defaultXcode = (Get-ToolsetContent).xcode.default

# Switch to each Xcode version
foreach ($xcodeVersion in $xcodeVersions.link) {
    Write-Host "Switching to Xcode $xcodeVersion"
    Switch-Xcode -Version $XcodeVersion

    # Make object of all simulators
    $devicesList = $(xcrun simctl list -j devices | ConvertFrom-Json)
    $devicesObject = [System.Collections.ArrayList]@()
    foreach ($runtime in $devicesList.devices.psobject.Properties.name) {
        foreach ($device in $devicesList.devices.$runtime) {
            $devicesObject += [PSCustomObject]@{
                runtime = $runtime
                DeviceName = $($device.name)
                DeviceId = $($device.udid)
                DeviceCreationTime = (Get-Item $HOME/Library/Developer/CoreSimulator/Devices/$($device.udid)).CreationTime
            }
        }
    }

    # Remove duplicates
    foreach ($simRuntume in $devicesObject.runtime | Sort-Object -Unique) {
        [System.Collections.ArrayList]$sameRuntimeDevices = [array]$($devicesObject | Where-Object {$_.runtime -eq $simRuntume} | Sort-Object -Property DeviceName)
        Write-Host "///////////////////////////////////////////////////////////////////"
        Write-Host "// Checking for duplicates in $simRuntume "
        $devicesAsHashTable =  $sameRuntimeDevices | Group-Object -Property DeviceName -AsHashTable -AsString
        foreach ($key in $devicesAsHashTable.Keys) {
            if ( $devicesAsHashTable[$key].count -gt 1) {
                Write-Host "// Duplicates for $key - $($devicesAsHashTable[$key].count)"
            }
        }
        Write-Host "///////////////////////////////////////////////////////////////////"
        for ($i = 0; $i -lt $sameRuntimeDevices.Count; $i++) {
            if ( [string]::IsNullOrEmpty($($sameRuntimeDevices[$i+1].DeviceName)) ){
                Write-Host "No more devices to compare in $simRuntume"
                Write-Host "-------------------------------------------------------------------"
                continue
            }
            Write-Host "$($sameRuntimeDevices[$i].DeviceName) - DeviceId $($sameRuntimeDevices[$i].DeviceId) comparing with"
            Write-Host "$($sameRuntimeDevices[$i+1].DeviceName) - DeviceId $($sameRuntimeDevices[$i+1].DeviceId)"
            Write-Host "-------------------------------------------------------------------"
            if ($sameRuntimeDevices[$i].DeviceName -eq $sameRuntimeDevices[$i+1].DeviceName) {
                Write-Host "*******************************************************************"
                Write-Host "** Duplicate found"
                if ($sameRuntimeDevices[$i].DeviceCreationTime -lt $sameRuntimeDevices[$i+1].DeviceCreationTime) {
                    Write-Host "** will be removed $($sameRuntimeDevices[$i+1].DeviceName) with id $($sameRuntimeDevices[$i+1].DeviceId)"
                    xcrun simctl delete $sameRuntimeDevices[$i+1].DeviceId
                    $sameRuntimeDevices.RemoveAt($i+1)
                } else {
                    Write-Host "** will be removed $($sameRuntimeDevices[$i].DeviceName) with id $($sameRuntimeDevices[$i].DeviceId)"
                    xcrun simctl delete $sameRuntimeDevices[$i].DeviceId
                    $sameRuntimeDevices.RemoveAt($i)
                }
                Write-Host "*******************************************************************"
            }
        }
    }
}

# Restore default Xcode
Write-Host "Restoring default Xcode to $defaultXcode"
Switch-Xcode -Version $defaultXcode

# Pre-warm standard iOS simulator
Invoke-SimulatorPrewarm
