################################################################################
##  File:  Download-ToolCache.ps1
##  Team:  CI-Build
##  Desc:  Download tool cache
################################################################################

Function Install-NpmPackage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String] $Name
    )

    Write-Host "Installing npm $Name"

    Push-Location -Path $env:TEMP

    npm install $Name

    $exit_code = $LASTEXITCODE
    if($exit_code -ne 0) {
        Write-Host "$Name installation failure;  Error:${exit_code}"

        exit 1
    }

    Pop-Location
}

Function NPMFeed-Auth {
    [String] $AccessToken

    $feedPrefix = "npm.pkg.github.com"
    $npmrcContent = "//${feedPrefix}/:_authToken=${AccessToken}"
    $npmrcContent | Out-File -FilePath "$($env:TEMP)/.npmrc" -Encoding utf8
}

# HostedToolCache Path
$Dest = "C:/"
$Path = "hostedtoolcache/windows"
$ToolsDirectory = $Dest + $Path

# Define AGENT_TOOLSDIRECTORY environment variable
$env:AGENT_TOOLSDIRECTORY = $ToolsDirectory
setx AGENT_TOOLSDIRECTORY $ToolsDirectory /M

# Install HostedToolCache tools via NPM
$ToolVersionsFileContent = Get-Content -Path "$env:ROOT_FOLDER/toolcache.json" -Raw
$ToolVersions = ConvertFrom-Json -InputObject $ToolVersionsFileContent

NPMFeed-Auth -AccessToken $env:GITHUB_FEED_TOKEN

$ToolVersions.PSObject.Properties | ForEach-Object {
    $PackageName = $_.Name
    $PackageVersions = $_.Value
    $NpmPackages = $PackageVersions | ForEach-Object { "$PackageName@$_" }
    foreach($NpmPackage in $NpmPackages) {
        Install-NpmPackage -Name $NpmPackage
    }
}

#junction point from the previous Python2 directory to the toolcache Python2
Write-Host "Create symlink to Python2"
$python2Dir = (Get-Item -Path ($ToolsDirectory + '/Python/2.7*/x64')).FullName
cmd.exe /c mklink /d "C:\Python27amd64" "$python2Dir"
