################################################################################
##  File:  Install-NodeLts.ps1
##  Desc:  Install nodejs-lts and other common node tools.
##         Must run after python is configured
################################################################################

$PrefixPath = 'C:\npm\prefix'
$CachePath = 'C:\npm\cache'

New-Item -Path $PrefixPath -Force -ItemType Directory
New-Item -Path $CachePath -Force -ItemType Directory

$defaultVersion = (Get-ToolsetContent).node.default
$queryFilter = "`$filter=(Id eq 'nodejs') and (IsPrerelease eq false) and (Version ge '$defaultVersion')"
$url = "https://community.chocolatey.org/api/v2/Packages()?$queryFilter"
$chocoVersionsOutput = (Invoke-RestMethod -Uri $url).properties.Version
# Take the latest version available for given default version from the toolset which is used as wildcard
# Toolset file can contain a version in any form: Major, Major.Minor or even the exact version
$versionToInstall = $chocoVersionsOutput |
    # Take the exact default version and its subversions
    Where-Object { $_ -Like "$defaultVersion.*" -or $_ -eq $defaultVersion } |
    Sort-Object { [Version]$_ } |
    Select-Object -Last 1

Choco-Install -PackageName nodejs -ArgumentList "--version=$versionToInstall"

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
