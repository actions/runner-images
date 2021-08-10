################################################################################
##  File:  Install-NodeLts.ps1
##  Desc:  Install nodejs-lts and other common node tools.
##         Must run after python is configured
################################################################################

$PrefixPath = 'C:\npm\prefix'
$CachePath = 'C:\npm\cache'

New-Item -Path $PrefixPath -Force -ItemType Directory
New-Item -Path $CachePath -Force -ItemType Directory

Choco-Install -PackageName nodejs-lts -ArgumentList "--force"

Add-MachinePathItem $PrefixPath
$env:Path = Get-MachinePath

setx npm_config_prefix $PrefixPath /M
$env:npm_config_prefix = $PrefixPath

npm config set cache $CachePath --global
npm config set registry https://registry.npmjs.org/

$globalNpmPackages = (Get-ToolsetContent).npm.global_packages
$globalNpmPackages | ForEach-Object {
    npm install -g $_.name
}

Invoke-PesterTests -TestFile "Node"
