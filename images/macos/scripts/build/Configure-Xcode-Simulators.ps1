################################################################################
##  File:  Configure-Xcode-Simulators.ps1
##  Team:  CI-Build
##  Desc:  CHeck and remove duplicate simulators
################################################################################

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

        # Fixed iteration logic - don't increment when removing duplicates
        $i = 0
        while ($i -lt ($sameRuntimeDevices.Count - 1)) {
            $current = $sameRuntimeDevices[$i]
            $next = $sameRuntimeDevices[$i + 1]

            Write-Host "$($current.DeviceName) - DeviceId $($current.DeviceId) comparing with"
            Write-Host "$($next.DeviceName) - DeviceId $($next.DeviceId)"
            Write-Host "-------------------------------------------------------------------"

            if ($current.DeviceName -eq $next.DeviceName) {
                Write-Host "*******************************************************************"
                Write-Host "** Duplicate found"
                if ($current.DeviceCreationTime -lt $next.DeviceCreationTime) {
                    Write-Host "** will be removed $($next.DeviceName) with id $($next.DeviceId)"
                    xcrun simctl delete $next.DeviceId
                    $sameRuntimeDevices.RemoveAt($i + 1)
                } else {
                    Write-Host "** will be removed $($current.DeviceName) with id $($current.DeviceId)"
                    xcrun simctl delete $current.DeviceId
                    $sameRuntimeDevices.RemoveAt($i)
                }
                Write-Host "*******************************************************************"
                # don't increment; compare again at same index
            } else {
                $i++
            }
        }

        Write-Host "No more devices to compare in $simRuntume"
        Write-Host "-------------------------------------------------------------------"
    }
}

# Restore default Xcode
Write-Host "Restoring default Xcode to $defaultXcode"
Switch-Xcode -Version $defaultXcode
