################################################################################
##  File:  Install-OpenSSL.ps1
##  Desc:  Install win64-openssl.
################################################################################

$arch = "INTEL"
$bits = "64"
$light = $false
$installer = "exe"
$version = (Get-ToolsetContent).openssl.version
$installDir = "$Env:ProgramFiles\OpenSSL"

# Fetch available installers list
$jsonUrl = 'https://raw.githubusercontent.com/slproweb/opensslhashes/master/win32_openssl_hashes.json'
$installersAvailable = @()
(Invoke-RestMethod $jsonUrl).files.PSObject.Properties |
Where-Object MemberType -Eq NoteProperty |
ForEach-Object { $installersAvailable += $_.Value }

# Select appropriate installers
$installersMatching = $installersAvailable | Where-Object {
  ($_.basever -Eq $version -Or $_.basever -Like "$version.*") -And $_.arch -Eq $arch -And $_.bits -Eq $bits -And $_.light -Eq $light -And $_.installer -Eq $installer
}

# Get installer of the latest version
$latestInstaller = $installersMatching |
Sort-Object { [version]$_.basever }, subver | 
Select-Object -Last 1

# Invoke installation
$installerUrl = $latestInstaller.url
$installerName = "openssl-$($latestInstaller.basever)$($latestInstaller.subver)-setup.$($latestInstaller.installer)"
$installerArgs = '/silent', '/sp-', '/suppressmsgboxes', "/DIR=`"$installDir`""
Install-Binary -Url "$installerUrl" -Name "$installerName" -ArgumentList $installerArgs

# Update PATH
Add-MachinePathItem "$installDir\bin"
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "OpenSSL"
