################################################################################
##  File:  Install-Python.ps1
##  Desc:  Configure python on path with 3.7.* version from the tools cache
##         Must run after tools cache is setup
################################################################################

Import-Module -Name ImageHelpers -Force

$python37path = $Env:AGENT_TOOLSDIRECTORY + '/Python/3.7*/x64'
$pythonDir = Get-Item -Path $python37path

if($pythonDir -is [array])
{
    Write-Host "More than one python 3.7.* installations found"
    Write-Host $pythonDir
    exit 1
}

$currentPath = Get-MachinePath

if ($currentPath | Select-String -SimpleMatch $pythonDir.FullName)
{
    Write-Host $pythonDir.FullName ' is already in PATH'
    exit 0
}

Add-MachinePathItem -PathItem $pythonDir.FullName
Add-MachinePathItem -PathItem "$($pythonDir.FullName)\Scripts"
