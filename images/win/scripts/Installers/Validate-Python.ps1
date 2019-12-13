################################################################################
##  File:  Validate-Python.ps1
##  Desc:  Configure python on path based on what is installed in the tools cache
##         Must run after tools cache is downloaded and validated
################################################################################

if(Get-Command -Name 'python')
{
    Write-Host "Python $(& python -V 2>&1) on path"
}
else
{
    Write-Host "Python is not on path"
    exit 1
}

$Python3Version = $(& python -V 2>&1)

if ($Python3Version -notlike "Python 3.*")
{
    Write-Error "Python 3 is not in the PATH"
}


$python2path = $Env:AGENT_TOOLSDIRECTORY + '/Python/2.7*/x64'
$python2Dir = Get-Item -Path $python2path

$env:Path = $python2Dir.FullName + ";" + $env:Path

$Python2Version = & $env:comspec "/s /c python --version 2>&1"

# Adding description of the software to Markdown
$SoftwareName = "Python (64 bit)"

$Description = @"
#### $Python3Version
_Environment:_
* PATH: contains location of python.exe

#### $Python2Version

_Location:_ $Python2Path
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
