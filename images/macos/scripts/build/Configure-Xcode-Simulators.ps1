################################################################################
##  File:  Configure-Xcode-Simulators.ps1
##  Team:  CI-Build
##  Desc:  CHeck and remove duplicate simulators
################################################################################

Import-Module "~/image-generation/helpers/Common.Helpers.psm1"
Import-Module "~/image-generation/helpers/Xcode.Helpers.psm1"
$arch = Get-Architecture
$xcodeVersions = (Get-ToolsetContent).xcode.${arch}.versions

# Switch to each Xcode version
foreach ($xcodeVersion in $xcodeVersions.link) {
    write-host "Switching to Xcode $xcodeVersion"
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
                write-host "*******************************************************************"
                write-host "** Duplicate found"
                if ($sameRuntimeDevices[$i].DeviceCreationTime -lt $sameRuntimeDevices[$i+1].DeviceCreationTime) {
                    Write-Host "** will be removed $($sameRuntimeDevices[$i+1].DeviceName) with id $($sameRuntimeDevices[$i+1].DeviceId)"
                    xcrun simctl delete $sameRuntimeDevices[$i+1].DeviceId
                    $sameRuntimeDevices.RemoveAt($i+1)
                } else {
                    Write-Host "** will be removed $($sameRuntimeDevices[$i].DeviceName) with id $($sameRuntimeDevices[$i].DeviceId)"
                    xcrun simctl delete $sameRuntimeDevices[$i].DeviceId
                    $sameRuntimeDevices.RemoveAt($i)
                }
                write-host "*******************************************************************"
            }
        }
    }
}
