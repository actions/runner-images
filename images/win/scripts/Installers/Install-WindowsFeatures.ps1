$windowsFeatures = (Get-ToolsetContent).windowsFeatures

foreach ($feature in $windowsFeatures) {
    if ($feature.optionalFeature) {
        Write-Host "Activating Windows Optional Feature '$($feature.name)'..."
        Enable-WindowsOptionalFeature -Online -FeatureName $feature.name -NoRestart

        $resultSuccess = $?
    } else {
        Write-Host "Activating Windows Feature '$($feature.name)'..."
        $Arguments = @{
            Name = $feature.name
            IncludeAllSubFeature = [System.Convert]::ToBoolean($feature.includeAllSubFeatures)
            IncludeManagementTools = [System.Convert]::ToBoolean($feature.includeManagementTools)
        }
        $result = Install-WindowsFeature @Arguments

        $resultSuccess = $result.Success
    }
}

Write-Host "Enabling Windows Feature 'Containers'"
Install-WindowsFeature -Name Containers

Write-Host "Enabling Windows Feature 'Client-ProjFS'"
Enable-WindowsOptionalFeature -Online -FeatureName Client-ProjFS -NoRestart

    if ($resultSuccess) {
        Write-Host "Windows Feature '$($feature.name)' was activated successfully"
    } else {
        throw "Failed to activate Windows Feature '$($feature.name)'"
    }
}
