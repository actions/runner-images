################################################################################
##  File:  Install-Go.ps1
##  Desc:  Install Go
################################################################################

Import-Module -Name ImageHelpers -Force -DisableNameChecking

# Get Go content from toolset
$goTool = Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where-Object Name -eq "go"

$toolPath = Join-Path $env:AGENT_TOOLSDIRECTORY $goTool.name
foreach($goVersion in $goTool.versions)
{
    if ($goVersion.Split(".").Length -lt 3) {
        $goVersion += ".*"
    }
    $expectedVersionPath = Join-Path $toolPath $goVersion
    $foundVersion = Get-Item $expectedVersionPath `
                    | Sort-Object -Property {[version]$_.name} -Descending `
                    | Select-Object -First 1
    # Check for required architecture folder
    $foundVersionArchPath = Join-Path $foundVersion $goTool.arch
    $envName = "GOROOT_{0}_{1}_X64" -f $goVersion.split(".")
    setx $envName "$foundVersionArchPath" /M
}