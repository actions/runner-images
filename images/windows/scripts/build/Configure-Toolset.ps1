################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure Toolset
################################################################################

$toolEnvConfigs = @{
    Python = @{
        pathTemplates = @(
            "{0}"
            "{0}\Scripts"
        )
    }
    go     = @{
        pathTemplates  = @(
            "{0}\bin"
        )
        envVarTemplate = "GOROOT_{0}_{1}_X64"
    }
}

$tools = Get-ToolsetContent `
| Select-Object -ExpandProperty toolcache `
| Where-Object { $toolEnvConfigs.Keys -contains $_.name }

Write-Host "Configure toolset tools environment..."
foreach ($tool in $tools) {
    $toolEnvConfig = $toolEnvConfigs[$tool.name]
    
    if (-not ([string]::IsNullOrEmpty($toolEnvConfig.envVarTemplate))) {
        foreach ($version in $tool.versions) {
            Write-Host "Set $($tool.name) $version environment variable..."

            $foundVersionArchPath = Get-TCToolVersionPath -Name $tool.name -Version $version -Arch $tool.arch
            $envName = $toolEnvConfig.envVarTemplate -f $version.Split(".")

            Write-Host "Set $envName to $foundVersionArchPath"
            [Environment]::SetEnvironmentVariable($envName, $foundVersionArchPath, "Machine")
        }
    }

    if (-not ([string]::IsNullOrEmpty($tool.default))) {
        Write-Host "Use $($tool.name) $($tool.default) as a system $($tool.name)..."

        $toolVersionPath = Get-TCToolVersionPath -Name $tool.name -Version $tool.default -Arch $tool.arch

        foreach ($template in $toolEnvConfig.pathTemplates) {
            $toolSystemPath = $template -f $toolVersionPath
            Write-Host "Add $toolSystemPath to system PATH..."
            Add-MachinePathItem -PathItem $toolSystemPath | Out-Null
        }
    
        if (-not ([string]::IsNullOrEmpty($tool.defaultVariable))) {
            Write-Host "Set $($tool.name) $($tool.default) $($tool.defaultVariable) environment variable..."
            [Environment]::SetEnvironmentVariable($tool.defaultVariable, $toolVersionPath, "Machine")
        }
    }
}

Invoke-PesterTests -TestFile "Toolset"
