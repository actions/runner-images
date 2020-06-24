################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure Toolset
################################################################################

Function Set-DefaultToolVersion
{
    param
    (
        [string] $ToolName,
        [string] $ToolVersion,
        [string] $ToolArchitecture
    )

    $ToolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $ToolName
    $ToolPathVersion = Join-Path -Path $ToolPath -ChildPath $ToolVersion -AdditionalChildPath $ToolArchitecture -Resolve

    Write-Host "Use ${ToolName} ${ToolVersion} as a system ${ToolName}..."
    if ($ToolPath -eq "Python")
    {
        Add-MachinePathItem -PathItem $ToolPathVersion | Out-Null
        Add-MachinePathItem -PathItem "$ToolPathVersion\Scripts" | Out-Null
    }

    if ($ToolName -eq "go")
    {
        Add-MachinePathItem -PathItem "$ToolPathVersion\bin" | Out-Null
        # Set the GOROOT environment variable.
        setx GOROOT "$ToolPathVersion" /M | Out-Null
    }
}

Function Set-ToolEnvironment
{
    param
    (
        [string] $ToolName,
        [string] $ToolVersion,
        [string] $ToolArchitecture
    )

    $ToolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $ToolName
    $ToolPathVersion = Join-Path -Path $ToolPath -ChildPath $ToolVersion

    if ($ToolName -eq "Boost")
    {
        $installationDir = Join-Path -Path $ToolPathVersion -ChildPath $ToolArchitecture
        $envName = "BOOST_ROOT_{0}" -f ($ToolVersion.Replace('.', '_'))
    }
    elseif ($ToolName -eq "go")
    {
        $foundVersion = Get-Item $ToolPathVersion `
                        | Sort-Object -Property {[version]$_.name} -Descending `
                        | Select-Object -First 1

        $installationDir = Join-Path -Path $foundVersion -ChildPath $ToolArchitecture
        $envName = "GOROOT_{0}_{1}_X64" -f $ToolVersion.split(".")
    }
    else
    {
        Write-Host "No configuration for $ToolName $ToolVersion ($ToolArchitecture) is required. Skipping..."
        return
    }

    setx $envName $installationDir /M | Out-Null
}

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force -DisableNameChecking

$toolsToConfigure = @("Python", "Boost", "Go")
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache `
                            | Where-Object { $toolsToConfigure -contains $_.name }

foreach ($tool in $tools)
{
    Write-Host "Configure $($tool.name)..."
    foreach ($toolVersion in $tool.versions)
    {
        ### Skip Python because it has no environment variables, except for default version
        if ($tool.name -eq "Python")
        {
            break
        }

        Write-Host "Set $($tool.Name) $toolVersion environment..."
        Set-ToolEnvironment -ToolVersion $toolVersion -ToolArchitecture $tool.arch -ToolName $tool.name
    }

    if ($null -ne $tool.default)
    {
        Write-Host "Set $($tool.Name) default version environment..."
        Set-DefaultToolVersion -ToolVersion $tool.default -ToolArchitecture $tool.arch -ToolName $tool.name
    }
}
