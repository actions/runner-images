################################################################################
##  File:  Install-NodeJS.ps1
##  Desc:  Install nodejs-lts and other common node tools.
##         Must run after python is configured
################################################################################

$prefixPath = 'C:\npm\prefix'
$cachePath = 'C:\npm\cache'

New-Item -Path $prefixPath -Force -ItemType Directory
New-Item -Path $cachePath -Force -ItemType Directory

$defaultVersion = (Get-ToolsetContent).node.default
$nodeVersion = (Get-GithubReleasesByVersion -Repo "nodejs/node" -Version "${defaultVersion}").version | Select-Object -First 1
$downloadUrl = "https://nodejs.org/dist/v${nodeVersion}/node-v${nodeVersion}-x64.msi"

$packageName = Split-Path $downloadUrl -Leaf
$externalHash = Get-ChecksumFromUrl -Type "SHA256" `
    -Url ($downloadUrl -replace $packageName, "SHASUMS256.txt") `
    -FileName $packageName

Install-Binary -Type MSI `
    -Url $downloadUrl `
    -ExtraInstallArgs @('ADDLOCAL=ALL') `
    -ExpectedSHA256Sum $externalHash

Add-MachinePathItem $prefixPath
Update-Environment

[Environment]::SetEnvironmentVariable("npm_config_prefix", $prefixPath, "Machine")
$env:npm_config_prefix = $prefixPath

npm config set cache $cachePath --global
npm config set registry https://registry.npmjs.org/

$globalNpmPackages = (Get-ToolsetContent).npm.global_packages
$globalNpmPackages | ForEach-Object {
    npm install -g $_.name
}

Invoke-PesterTests -TestFile "Node"
