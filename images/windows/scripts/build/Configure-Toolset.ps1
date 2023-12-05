################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure Toolset
################################################################################

$tools2Configure = @(
    @{
        name          = "Python"
        pathTemplates = @(
            "{0}"
            "{0}\Scripts"
        )
    }
    @{
        name           = "Go"
        pathTemplates  = @(
            "{0}\bin"
        )
        envVarTemplate = "GOROOT_{0}_{1}_X64"
    }
)


Write-Host "Configure toolset tools environment..."
foreach ($tool in $tools2Configure) {
    $toolsetData = Get-ToolsetContent `
    | Select-Object -ExpandProperty toolcache `
    | Where-Object { $_.name -eq $toolName }

    foreach ($key in $toolsetData.Keys) {
        $tool.$key = $toolsetData[$key]
    }

    if (-not ([string]::IsNullOrEmpty($tool.envVarTemplate))) {
        foreach ($version in $tool.versions) {
            Write-Host "Set $($tool.name) $version environment variable..."

            $foundVersionArchPath = Get-TCToolVersionPath -Name $tool.name -Version $version -Arch $tool.arch
            $envName = $tool.envVarTemplate -f $version.Split(".")

            Write-Host "Set $envName to $foundVersionArchPath"
            [Environment]::SetEnvironmentVariable($envName, $foundVersionArchPath, "Machine")
        }
    }

    if (-not ([string]::IsNullOrEmpty($tool.default))) {
        Write-Host "Use $($tool.name) $($tool.default) as a system $($tool.name)..."

        $toolVersionPath = Get-TCToolVersionPath -Name $tool.name -Version $tool.default -Arch $tool.arch

        foreach ($template in $tool.pathTemplates) {
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
