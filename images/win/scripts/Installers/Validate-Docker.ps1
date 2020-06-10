################################################################################
##  File:  Validate-Docker.ps1
##  Desc:  Validate Docker.
################################################################################

if ((Get-Command -Name 'docker') -and (Get-Command -Name 'docker-compose'))
{
    Write-Host "docker $(docker version) on path"
    Write-Host "docker-compose $(docker-compose version) on path"
}
else
{
    Write-Host "docker or docker-compose are not on path"
    exit 1
}

# Validate helm
if (Get-Command -Name 'helm')
{
    Write-Host "helm on path"
}
else
{
    Write-Host 'helm is not on path'
    exit 1
}
