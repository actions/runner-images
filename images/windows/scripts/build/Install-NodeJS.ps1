################################################################################
##  File:  Install-NodeJS.ps1
##  Desc:  Install nodejs-lts and other common node tools.
##         Must run after python is configured
################################################################################

$PrefixPath = 'C:\npm\prefix'
$CachePath = 'C:\npm\cache'

New-Item -Path $PrefixPath -Force -ItemType Directory
New-Item -Path $CachePath -Force -ItemType Directory

$defaultVersion = (Get-ToolsetContent).node.default
$versionToInstall = Resolve-ChocoPackageVersion -PackageName "nodejs" -TargetVersion $defaultVersion

Install-ChocoPackage nodejs -ArgumentList "--version=$versionToInstall"

Add-MachinePathItem $PrefixPath
$env:Path = Get-MachinePath

[Environment]::SetEnvironmentVariable("npm_config_prefix", $PrefixPath, "Machine")
$env:npm_config_prefix = $PrefixPath

npm config set cache $CachePath --global
npm config set registry https://registry.npmjs.org/

$globalNpmPackages = (Get-ToolsetContent).npm.global_packages
$globalNpmPackages | ForEach-Object {
    npm install -g $_.name
}

Invoke-PesterTests -TestFile "Node"
