################################################################################
##  File:  Download-ToolCache.ps1
##  Team:  CI-Build
##  Desc:  Download tool cache
################################################################################

Function Install-NpmPackage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.String] $PackageName,
        [Parameter(Mandatory=$true)]
        [System.Uri] $FeedPrefix
    )

    Push-Location -Path $env:TEMP

    $FeedUri = $FeedPrefix.AbsoluteUri

    Write-Host "Installing npm $PackageName from ${FeedUri}"
    npm install $PackageName --registry "${FeedUri}"

    if($LASTEXITCODE) {
        Write-Host "$PackageName installation failure;  Error: ${LASTEXITCODE}"

        exit 1
    }

    Pop-Location
}

Function NPMFeed-AuthSetup {
    param(
        [Parameter(Mandatory=$true)]
        [System.String] $AccessToken,
        [Parameter(Mandatory=$true)]
        [System.Uri] $FeedPrefix
    )

    $FeedHost = $FeedPrefix.Host

    Write-Host "Configure auth for github package registry"
    $npmrcContent = "//${FeedHost}/:_authToken=${AccessToken}"
    $npmrcContent | Out-File -FilePath "$($env:TEMP)/.npmrc" -Encoding utf8
}

$FeedPrefix = "https://npm.pkg.github.com"
$AccessToken = $env:GITHUB_FEED_TOKEN

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

NPMFeed-AuthSetup -AccessToken $AccessToken -FeedPrefix $FeedPrefix

$ToolVersions.PSObject.Properties | ForEach-Object {
    $PackageName = $_.Name
    $PackageVersions = $_.Value
    $NpmPackages = $PackageVersions | ForEach-Object { "$PackageName@$_" }
    foreach($NpmPackage in $NpmPackages) {
        Install-NpmPackage -PackageName $NpmPackage -FeedPrefix $FeedPrefix
    }
}

#junction point from the previous Python2 directory to the toolcache Python2
Write-Host "Create symlink to Python2"
$python2Dir = (Get-Item -Path ($ToolsDirectory + '/Python/2.7*/x64')).FullName
cmd.exe /c mklink /d "C:\Python27amd64" "$python2Dir"