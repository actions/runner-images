################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure toolset
################################################################################

Import-Module "~/image-generation/helpers/Common.Helpers.psm1"

function Get-ToolsetToolFullPath
{
    param
    (
        [Parameter(Mandatory)] [string] $ToolName,
        [Parameter(Mandatory)] [string] $ToolVersion,
        [Parameter(Mandatory)] [string] $ToolArchitecture
    )

    $toolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $toolName
    $toolPathVersion = Join-Path -Path $toolPath -ChildPath $toolVersion
    $foundVersion = Get-Item $toolPathVersion | Sort-Object -Property {[version]$_.name} -Descending | Select-Object -First 1
    $installationDir = Join-Path -Path $foundVersion -ChildPath $toolArchitecture
    return $installationDir
}

$arch = Get-Architecture
$toolcache = Get-ToolsetValue "toolcache"

foreach ($tool in $toolcache)
{
    $toolName = $tool.name
    $toolEnvironment = $tool.arch.$arch.variable_template

    if (-not $toolEnvironment)
    {
        continue
    }

    foreach ($toolVersion in $tool.arch.$arch.versions)
    {
        Write-Host "Set $toolName $toolVersion environment variable..."
        $toolPath = Get-ToolsetToolFullPath -ToolName $toolName -ToolVersion $toolVersion -ToolArchitecture $arch
        $envName = $toolEnvironment -f $toolVersion.split(".")

        # Add environment variable name=value
        Add-EnvironmentVariable -Name $envName -Value $toolPath
    }
}
