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

function Add-EnvironmentVariable
{
    param
    (
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [string] $Value,
        [string] $FilePath = "${env:HOME}/.bashrc"
    )

    $envVar = "{0}={1}" -f $name, $value
    Tee-Object -InputObject $envVar -FilePath $filePath -Append
}

$toolset = Get-Content -Path "$env:HOME/image-generation/toolset.json" -Raw | ConvertFrom-Json

foreach ($tool in $toolset.toolcache)
{
    $toolName = $tool.name
    $toolArch = $tool.arch
    $toolEnvironment = $tool.variableTemplate

    if (-not $toolEnvironment)
    {
        continue
    }

    foreach ($toolVersion in $tool.versions)
    {
        Write-Host "Set $toolName $toolVersion environment variable..."
        $toolPath = Get-ToolsetToolFullPath -ToolName $toolName -ToolVersion $toolVersion -ToolArchitecture $toolArch
        $envName = $toolEnvironment.variableTemplate -f $toolVersion.split(".")

        # Add environment variable name=value
        Add-EnvironmentVariable -Name $envName -Value $toolPath
    }
}