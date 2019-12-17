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
        [array]$versions = GetChildFolders -Path "$env:AGENT_TOOLSDIRECTORY\$SoftwareName"
        if ($versions.count -gt 0){
            foreach ($version in $versions)
            {
                $architectures = GetChildFolders -Path "$env:AGENT_TOOLSDIRECTORY\$SoftwareName\$version"

                Write-Host "$SoftwareName version - $version : $([system.String]::Join(",", $architectures))"

                foreach ($arch in $architectures)
                {
                    $path = "$env:AGENT_TOOLSDIRECTORY\$SoftwareName\$version\$arch"
                    foreach ($test in $ExecTests)
                    {
                        if (Test-Path "$path\$test")
                        {
                            Write-Host "$SoftwareName($test) $version($arch) is successfully installed:"
                            Write-Host (& "$path\$test" --version)
                        }
                        else
                        {
                            Write-Host "$SoftwareName($test) $version ($arch) is not installed"
                            exit 1
                        }
                    }

                    $description += "_Version:_ $version ($arch)<br/>"
                }
            }

            Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $description
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
