################################################################################
##  File:  Validate-Python.ps1
##  Desc:  Configure python on path based on what is installed in the tools cache
##         Must run after tools cache is downloaded and validated
################################################################################

if (Get-Command -Name 'python')
{
    Write-Host "Python $(& python -V 2>&1) on path"
}
else
{
    Write-Host "Python is not on path"
    exit 1
}

$pythonBinVersion = $(& python -V 2>&1)
if ($pythonBinVersion -notlike "Python 3.*")
{
    Write-Error "Python 3 is not in the PATH"
}

$pythonExeOnPath = (Get-Command -Name 'python').Path
$pythonBinOnPath = Split-Path -Path $pythonExeOnPath

# Adding description of the software to Markdown
$SoftwareName = "Python (64 bit) (System default)"
$Description = @"
#### $pythonBinVersion
_Environment:_
* Location: $pythonBinOnPath
* PATH: contains the location of python.exe version $pythonBinVersion
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
