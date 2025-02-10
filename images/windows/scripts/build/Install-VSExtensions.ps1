###################################################################################
##  File:  Install-VSExtensions.ps1
##  Desc:  Install the Visual Studio Extensions from toolset.json
###################################################################################

$toolset = Get-ToolsetContent
$vsixPackagesList = $toolset.visualStudio.vsix
if (-not $vsixPackagesList) {
    Write-Host "No extensions to install"
    exit 0
}

$vsixPackagesList | ForEach-Object {
    # Retrieve cdn endpoint to avoid HTTP error 429
    # https://github.com/actions/runner-images/issues/3074
    $vsixPackage = Get-VsixInfoFromMarketplace $_
    Write-Host "Installing $vsixPackage"
    if ($vsixPackage.FileName.EndsWith(".vsix")) {
        Install-VSIXFromUrl $vsixPackage.DownloadUri
    } else {
        Install-Binary `
            -Url $vsixPackage.DownloadUri `
            -InstallArgs @('/install', '/quiet', '/norestart')
    }
}

Invoke-PesterTests -TestFile "Vsix"
