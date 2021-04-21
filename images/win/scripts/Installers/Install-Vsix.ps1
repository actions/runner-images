###################################################################################
##  File:  Install-Vsix.ps1
##  Desc:  Install the Visual Studio Extensions from toolset.json
###################################################################################

$toolset = Get-ToolsetContent
$vsixPackagesList = $toolset.visualStudio.vsix
if (-not $vsixPackagesList) {
    Write-Host "No extensions to install"
    exit 0
}

$vsVersion = $toolset.visualStudio.Version
$vsixPackagesList | ForEach-Object {
    # Retrieve cdn endpoint to avoid HTTP error 429 https://github.com/actions/virtual-environments/issues/3074 
    $request = Invoke-WebRequest -Uri $_.url -UseBasicParsing
    $request -match "`"AssetUri`":`"(?<uri>https:\/\/\S*\.vsassets\.io\S*\/\d*)`""
    $assetUri = $Matches.uri
    $request -match "`"Microsoft\.VisualStudio\.Services\.Payload\.FileName`":`"(?<filename>\S*\.(?:vsix|exe))`""
    $fileName = $Matches.filename
    $cdnUri = $assetUri + "/" + $fileName
    Write-Host "Installing $fileName extension from $cdnUri"
    Install-VsixExtension -Url $cdnUri -Name $fileName -VSversion $vsVersion
}

Invoke-PesterTests -TestFile "Vsix"