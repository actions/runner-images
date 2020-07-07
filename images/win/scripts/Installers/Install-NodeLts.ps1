################################################################################
##  File:  Install-NodeLts.ps1
##  Desc:  Install nodejs-lts and other common node tools.
##         Must run after python is configured
################################################################################

Import-Module -Name ImageHelpers -Force

$PrefixPath = 'C:\npm\prefix'
$CachePath = 'C:\npm\cache'

New-Item -Path $PrefixPath -Force -ItemType Directory
New-Item -Path $CachePath -Force -ItemType Directory

Choco-Install -PackageName nodejs-lts -ArgumentList "--force"

Add-MachinePathItem $PrefixPath
$env:Path = Get-MachinePath

setx NPM_CONFIG_PREFIX $PrefixPath /M
$env:NPM_CONFIG_PREFIX = $PrefixPath

setx NPM_CONFIG_CACHE $CachePath /M
$env:NPM_CONFIG_CACHE = $CachePath

npm config set registry http://registry.npmjs.org/

npm install -g cordova
npm install -g grunt-cli
npm install -g gulp-cli
npm install -g parcel-bundler
npm install -g --save-dev webpack webpack-cli
npm install -g yarn
npm install -g lerna
npm install -g node-sass
npm install -g newman
