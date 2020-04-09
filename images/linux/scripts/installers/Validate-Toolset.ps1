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

# Define executables for cached tools
$toolsExecutables = @{ "Python" = @("python", "bin/pip") }

# Get toolset content
$toolsetJson = Get-Content -Path "$env:INSTALLER_SCRIPT_FOLDER/toolset.json" -Raw
$tools = ConvertFrom-Json -InputObject $toolsetJson | Select-Object -ExpandProperty toolcache

foreach($tool in $tools) {

    Invoke-Expression "bash -c `"source $env:HELPER_SCRIPTS/document.sh; DocumentInstalledItem `"$($tool.name):`"`""

    $toolPath = Join-Path $env:AGENT_TOOLSDIRECTORY $tool.name
    # Get executables for current tool
    $toolExecs = $toolsExecutables | Select-Object -ExpandProperty $tool.name

    foreach ($version in $tool.versions) {
        # Check if version folder exists
        $foundVersionPath = Join-Path $toolPath $version | Join-Path -ChildPath $tool.arch | Get-Item
        if ($foundVersionPath -eq $null) {
            Write-Host "Expected $($tool.name) $version ($($tool.arch)) folder is not installed!"
            exit 1
        }

        $foundVersion = $($foundVersionPath.parent.fullname.Split("/")[-1])

        Write-Host "Run validation test for $($tool.name)($($tool.arch)) $foundVersion executables..."
        Run-ExecutableTests -Executables $toolExecs -ToolPath $foundVersionPath

        Invoke-Expression "bash -c `"source $env:HELPER_SCRIPTS/document.sh; DocumentInstalledItemIndent `"$($tool.name) $version`"`""
    }
}