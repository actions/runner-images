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
        [string[]]$ExecTests,
        [Parameter(Mandatory = $True)]
        [string]$Note
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

            $description += $Note
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
$PythonNote += @"
<br/>
> Note: These versions of Python are available through the [Use Python Version](https://go.microsoft.com/fwlink/?linkid=871498) task.
"@
$PythonTests = @("python.exe", "Scripts\pip.exe")
ToolcacheTest -SoftwareName "Python" -ExecTests $PythonTests -Note $PythonNote

# PyPy test
$PyPyNote += @"
<br/>
> Note: These versions of PyPy are available through the [Use Python Version](https://go.microsoft.com/fwlink/?linkid=871498) task.
"@
$PyPyTests = @("python.exe", "bin\pip.exe")
ToolcacheTest -SoftwareName "PyPy" -ExecTests $PyPyTests -Note $PyPyNote

# Ruby test
$RubyNote += @"
<br/>
> Note: These versions of Ruby are available through the [Use Ruby Version](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/tool/use-ruby-version) task.
"@
$RubyTests = @("bin\ruby.exe")
ToolcacheTest -SoftwareName "Ruby" -ExecTests $RubyTests -Note $RubyNote
