################################################################################
##  File:  Install-OpenSSL.ps1
##  Desc:  Install win64-openssl.
##  Supply chain security: checksum validation
################################################################################

$arch = 'INTEL'
$bits = '64'
$light = $false
$installer = "exe"
$version = (Get-ToolsetContent).openssl.version
$installDir = "$Env:ProgramFiles\OpenSSL"

# Fetch available installers list
$jsonUrl = 'https://raw.githubusercontent.com/slproweb/opensslhashes/master/win32_openssl_hashes.json'

$installersAvailable = (Invoke-RestMethod $jsonUrl).files
$installerNames = $installersAvailable | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name

$installerUrl = $null
$installerHash = $null

foreach ($key in $installerNames) {
    $installer = $installersAvailable.$key
    if (($installer.light -eq $light) -and ($installer.arch -eq $arch) -and ($installer.bits -eq $bits) -and ($installer.installer -eq $installer) -and ($installer.basever -eq $version)) {
        $installerUrl = $installer.url
        $installerHash = $installer.sha512
    }
}

if ($null -eq $installerUrl) {
    throw "Installer not found for version $version"
}

Install-Binary `
    -Url $installerUrl `
    -Args @('/silent', '/sp-', '/suppressmsgboxes', "/DIR=`"$installDir`"") `
    -ExpectedSHA512Sum $installerHash

# Update PATH
Add-MachinePathItem "$installDir\bin"
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "OpenSSL"
