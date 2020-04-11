################################################################################
##  File:  Validate-Toolset.ps1
##  Team:  CI-Build
##  Desc:  Validate Toolset
################################################################################

function Run-ExecutableTests {
    param (
        [Parameter(Mandatory)] [string[]] $Executables,
        [Parameter(Mandatory)] [string] $ToolPath
    )

    foreach ($executable in $Executables) {
        $executablePath = Join-Path $ToolPath $executable

        Write-Host "Check $executable..."
        if (Test-Path $executablePath) {
            Write-Host "$executable is successfully installed: $(& $executablePath --version)"
        } else {
            Write-Host "$executablePath is not installed!"
            exit 1
        }
    }
}

$ErrorActionPreference = "Stop"

# Define executables for cached tools
$toolsExecutables = @{ Python = @("python", "bin/pip") }

# Get toolset content
$toolsetJson = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw
$tools = ConvertFrom-Json -InputObject $toolsetJson | Select-Object -ExpandProperty toolcache

foreach($tool in $tools) {
    Invoke-Expression "bash -c `"source $env:HELPER_SCRIPTS/document.sh; DocumentInstalledItem '$($tool.name):'`""

    $toolPath = Join-Path $env:AGENT_TOOLSDIRECTORY $tool.name
    # Get executables for current tool
    $toolExecs = $toolsExecutables[$tool.name]

    foreach ($version in $tool.versions) {
        # Check if version folder exists
        $expectedVersionPath = Join-Path $toolPath $version
        if (-not (Test-Path $expectedVersionPath)) {
            Write-Host "Expected $($tool.name) $version folder is not found!"
            exit 1
        }

        # Take latest installed version in case if toolset version contains wildcards
        $foundVersion = Get-Item $expectedVersionPath `
                        | Sort-Object -Property {[version]$_.name} -Descending `
                        | Select-Object -First 1
        $foundVersionPath = Join-Path $foundVersion $tool.arch

        Write-Host "Run validation test for $($tool.name)($($tool.arch)) $($foundVersion.name) executables..."
        Run-ExecutableTests -Executables $toolExecs -ToolPath $foundVersionPath

        # Add tool version to documentation
        Invoke-Expression "bash -c `"source $env:HELPER_SCRIPTS/document.sh; DocumentInstalledItemIndent '$($tool.name) $($foundVersion.name)'`""
    }
}