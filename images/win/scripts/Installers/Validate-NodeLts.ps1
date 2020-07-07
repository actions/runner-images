################################################################################
##  File:  Validate-NodeLts.ps1
##  Desc:  Validate nodejs-lts and other common node tools.
################################################################################

if ((Get-Command -Name 'node') -and (Get-Command -Name 'npm'))
{
    Write-Host "Node $(node --version) on path"
    Write-Host "Npm $(npm -version) on path"
}
else
{
    Write-Host "Node or npm is not on path"
    exit 1
}

if ((Get-Command -Name 'gulp') -and (Get-Command -Name 'grunt') -and (Get-Command -Name 'cordova') -and (Get-Command -Name 'yarn'))
{
    Write-Host "Gulp $(gulp -version) on path"
    Write-Host "Grunt $(grunt -version) on path"
    Write-Host "Yarn $(yarn -version) on path"
}
else
{
    Write-Host "One of Gulp, Grunt, Cordova, or Yarn is not on the path."
    exit 1
}

if (Get-Command -Name 'lerna')
{
    Write-Host "lerna $(lerna --version) on path"
}
else
{
    Write-Host "lerna is not on path"
    exit 1
}

if (Get-Command -Name 'newman')
{
    Write-Host "Newman $(newman --version) is on the path."
}
else
{
    Write-Host "Newman is not on the path."
    exit 1
}
