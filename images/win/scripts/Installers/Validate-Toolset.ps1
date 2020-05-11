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

function Validate-SystemDefaultTool {
    param (
        [Parameter(Mandatory)] [string] $ToolName,
        [Parameter(Mandatory)] [string] $ExpectedVersion
    )

    $binName = $ToolName.ToLower()

    # Check if tool on path
    if (Get-Command -Name $binName) {
        $versionOnPath = $(& $binName --version 2>&1) | Select-String -Pattern ".*(\d+\.\d+\.\d+)"
        $versionBinPath = Split-Path -Path (Get-Command -Name $binName).Path

        # Check if version is correct
        if ($versionOnPath.matches.Groups[1].Value -notlike $ExpectedVersion) {
            Write-Error "$ToolName $ExpectedVersion is not in the PATH"
            exit 1
        }

        Write-Host "$ToolName $versionOnPath on path"
    } else {
        Write-Host "$ToolName is not on path"
        exit 1
    }

    # Add default version description to markdown
    $description = "<br/>__System default version:__ $versionOnPath<br/>"
    $description += "_Environment:_<br/>"
    $description += "* Location: $versionBinPath<br/>"
    $description += "* PATH: contains the location of $versionOnPath<br/>"

    return $description
}

$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers -Force

# Define executables for cached tools
$toolsExecutables = @{
    Python = @("python.exe", "Scripts\pip.exe");
    node = @("node.exe", "npm")
}

# Get toolcache content from toolset
$tools = Get-ToolsetContent | Select-Object -ExpandProperty toolcache

foreach($tool in $tools) {
    $markdownDescription = ""

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

        # Check for required architecture folder
        $foundVersionArchPath = Join-Path $foundVersion $tool.arch
        if (-not (Test-Path $foundVersionArchPath)) {
            Write-Host "Expected $($tool.name)($($tool.arch)) $($foundVersion.name) architecture folder is not found!"
            exit 1
        }

        Write-Host "Run validation test for $($tool.name)($($tool.arch)) $($foundVersion.name) executables..."
        Run-ExecutableTests -Executables $toolExecs -ToolPath $foundVersionArchPath

        # Add to tool version to markdown
        $markdownDescription += "_Version:_ $($foundVersion.name)<br/>"
    }

    # Create markdown description for system default tool
    if (-not ([string]::IsNullOrEmpty($tool.default))) {
        Write-Host "Validate system default $($tool.name)($($tool.arch)) $($tool.default)..."
        $markdownDescription += Validate-SystemDefaultTool -ToolName $tool.name -ExpectedVersion $tool.default
    }

    Add-SoftwareDetailsToMarkdown -SoftwareName "$($tool.name) ($($tool.arch))" -DescriptionMarkdown $markdownDescription
}