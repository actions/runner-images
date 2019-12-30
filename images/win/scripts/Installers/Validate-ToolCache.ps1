################################################################################
##  File:  Validate-ToolCache.ps1
##  Desc:  Validate Tool Cache
################################################################################

# Helpers
function GetChildFolders {
    param (
        [Parameter(Mandatory = $True)]
        [string]$Path
    )
    return Get-ChildItem -Path $Path -Directory -Name
}

function Get-ToolcachePackages {
    $toolcachePath = Join-Path $env:ROOT_FOLDER "toolcache.json"
    return Get-Content -Raw $toolcachePath | ConvertFrom-Json
}

$packages = (Get-ToolcachePackages).PSObject.Properties | ForEach-Object {
    $packageNameParts = $_.Name.Split("-")
    $toolName = $packageNameParts[1]
    return [PSCustomObject] @{
        ToolName = $packageNameParts[1]
        Versions = $_.Value
        Arch = $packageNameParts[3]
    }
}

function ToolcacheTest {
    param (
        [Parameter(Mandatory = $True)]
        [string]$SoftwareName,
        [Parameter(Mandatory = $True)]
        [string[]]$ExecTests
    )
    if (Test-Path "$env:AGENT_TOOLSDIRECTORY\$SoftwareName")
    {
        $description = ""
        [array]$installedVersions = GetChildFolders -Path "$env:AGENT_TOOLSDIRECTORY\$SoftwareName"
        if ($installedVersions.count -gt 0){
            $softwarePackages = $packages | Where-Object { $_.ToolName -eq $SoftwareName }
            foreach($softwarePackage in $softwarePackages)
            {
                foreach ($version in $softwarePackage.Versions)
                {
                    $foundVersion = $installedVersions | where { $_.StartsWith($version) }

                    if ($foundVersion -ne $null){

                        $architectures = GetChildFolders -Path "$env:AGENT_TOOLSDIRECTORY\$SoftwareName\$foundVersion"

                        $softwareArch = $softwarePackage.Arch

                        if ($architectures -Contains $softwareArch) {
                            $path = "$env:AGENT_TOOLSDIRECTORY\$SoftwareName\$foundVersion\$softwareArch"
                            foreach ($test in $ExecTests)
                            {
                                if (Test-Path "$path\$test")
                                {
                                    Write-Host "$SoftwareName($test) $foundVersion($softwareArch) is successfully installed:"
                                    Write-Host (& "$path\$test" --version)
                                }
                                else
                                {
                                    Write-Host "$SoftwareName($test) $foundVersion ($softwareArch) is not installed"
                                    exit 1
                                }
                            }
                            $description += "_Version:_ $foundVersion ($softwareArch)<br/>"
                        }
                        else
                        {
                            Write-Host "$env:AGENT_TOOLSDIRECTORY\$SoftwareName\$foundVersion does not include required architecture"
                            exit 1
                        }
                    }
                    else
                    {
                        Write-Host "$env:AGENT_TOOLSDIRECTORY\$SoftwareName\$version.* was not found"
                        exit 1
                    }
                }

                Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $description
            }
        }
        else
        {
            Write-Host "$env:AGENT_TOOLSDIRECTORY\$SoftwareName does not include any folders"
            exit 1
        }
    }
    else
    {
        Write-Host "$env:AGENT_TOOLSDIRECTORY\$SoftwareName does not exist"
        exit 1
    }
}

# Python test
$PythonTests = @("python.exe", "Scripts\pip.exe")
ToolcacheTest -SoftwareName "Python" -ExecTests $PythonTests

# PyPy test
$PyPyTests = @("python.exe", "bin\pip.exe")
ToolcacheTest -SoftwareName "PyPy" -ExecTests $PyPyTests

# Ruby test
$RubyTests = @("bin\ruby.exe")
ToolcacheTest -SoftwareName "Ruby" -ExecTests $RubyTests
