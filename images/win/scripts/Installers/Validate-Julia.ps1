################################################################################
##  File:  Validate-Julia.ps1
##  Desc:  Validate Julia
################################################################################

# Verify that julia.exe is on the path
if ((Get-Command -Name 'julia') -and (Test-Path -Path 'C:\Julia'))
{
    Write-Host "$(julia --version) is on the path."
}
else
{
    Write-Host "Julia is not on the path."
    exit 1
}

