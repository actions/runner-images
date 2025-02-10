################################################################################
##  File:  Configure-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Configure toolset
################################################################################

Import-Module "$env:HELPER_SCRIPTS/../tests/Helpers.psm1"

function Get-TCToolVersionPath {
    param(
        [Parameter(Mandatory)]
        [string] $ToolName,
        [Parameter(Mandatory)]
        [string] $ToolVersion,
        [Parameter(Mandatory)]
        [string] $ToolArchitecture
    )

    $toolPath = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $ToolName
    $toolPathVersion = Join-Path -Path $toolPath -ChildPath $ToolVersion
    $foundVersion = Get-Item $toolPathVersion | Sort-Object -Property { [version] $_.name } -Descending | Select-Object -First 1
    $installationDir = Join-Path -Path $foundVersion -ChildPath $ToolArchitecture

    return $installationDir
}

function Add-GlobalEnvironmentVariable {
    param(
        [Parameter(Mandatory)]
        [string] $Name,
        [Parameter(Mandatory)]
        [string] $Value,
        [string] $FilePath = "/etc/environment"
    )

    $envVar = "{0}={1}" -f $Name, $Value
    Tee-Object -InputObject $envVar -FilePath $FilePath -Append
}

$ErrorActionPreference = "Stop"

Write-Host "Configure toolcache tools environment..."
$toolEnvConfigs = @{
    go = @{
        command          = "ln -s {0}/bin/* /usr/bin/"
        variableTemplate = "GOROOT_{0}_{1}_X64"
    }
}

# Get toolcache content from toolset
$tools = (Get-ToolsetContent).toolcache | Where-Object { $toolEnvConfigs.Keys -contains $_.name }

foreach ($tool in $tools) {
    $toolEnvConfig = $toolEnvConfigs[$tool.name]

    if (-not ([string]::IsNullOrEmpty($toolEnvConfig.variableTemplate))) {
        foreach ($toolVersion in $tool.versions) {
            Write-Host "Set $($tool.name) $toolVersion environment variable..."
            $toolPath = Get-TCToolVersionPath -ToolName $tool.name -ToolVersion $toolVersion -ToolArchitecture $tool.arch
            $envVariableName = $toolEnvConfig.variableTemplate -f $toolVersion.split(".")

            Add-GlobalEnvironmentVariable -Name $envVariableName -Value $toolPath
        }
    }

    # Invoke command and add env variable for the default tool version
    if (-not ([string]::IsNullOrEmpty($tool.default))) {
        $toolDefaultPath = Get-TCToolVersionPath -ToolName $tool.name -ToolVersion $tool.default -ToolArchitecture $tool.arch

        if (-not ([string]::IsNullOrEmpty($toolEnvConfig.defaultVariable))) {
            Write-Host "Set default $($toolEnvConfig.defaultVariable) for $($tool.name) $($tool.default) environment variable..."
            Add-GlobalEnvironmentVariable -Name $toolEnvConfig.defaultVariable -Value $toolDefaultPath
        }

        if (-not ([string]::IsNullOrEmpty($toolEnvConfig.command))) {
            $command = $toolEnvConfig.command -f $toolDefaultPath
            Write-Host "Invoke $command command for default $($tool.name) $($tool.default) ..."
            Invoke-Expression -Command $command
        }
    }
}

Invoke-PesterTests -TestFile "Toolset" -TestName "Toolset"
