################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure Toolset
################################################################################

function Set-ToolEnvironment
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

    if ($ToolName -eq "go")
    {
        $foundVersion = Get-Item $ToolPathVersion `
                        | Sort-Object -Property {[version]$_.name} -Descending `
                        | Select-Object -First 1

        $installationDir = Join-Path -Path $foundVersion -ChildPath $ToolArchitecture
        $envName = "GOROOT_{0}_{1}_X64" -f $ToolVersion.split(".")
    }

    setx $envName $installationDir /M | Out-Null
}

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force -DisableNameChecking

$toolsToConfigure = @("Boost", "Go")
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache `
                            | Where-Object { $toolsToConfigure -contains $_.name }

foreach ($tool in $tools)
{
    Write-Host "Configure $($tool.name)..."
    foreach ($toolVersion in $tool.versions)
    {
        Write-Host "Set $($tool.Name) $toolVersion environment..."
        Set-ToolEnvironment -ToolVersion $toolVersion -ToolArchitecture $tool.arch -ToolName $tool.name
    }
}
