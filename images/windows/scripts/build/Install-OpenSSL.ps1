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

$distributor_file_hash = $null
$installerUrl = $null
$installerName = $null

$installersAvailable | Get-Member -MemberType NoteProperty | ForEach-Object {
  $key = $_.Name
  if(($installersAvailable.$key.light -eq $light) -and ($installersAvailable.$key.arch -eq $arch) -and ($installersAvailable.$key.bits -eq $bits) -and ($installersAvailable.$key.installer -eq $installer) -and ($installersAvailable.$key.basever -eq $version)) {
    $installerUrl = $installersAvailable.$key.url
    $installerName = $key
    $distributor_file_hash = $installersAvailable.$key.sha512
  }
}

# Invoke installation

$installerArgs = '/silent', '/sp-', '/suppressmsgboxes', "/DIR=`"$installDir`""
Install-Binary -Url "$installerUrl" -Name "$installerName" -ArgumentList $installerArgs

#region Supply chain security
Write-Verbose "Performing checksum verification"
$local_file_hash = (Get-FileHash -Path (Join-Path ${env:TEMP} $installerName) -Algorithm SHA512).Hash

if ($local_file_hash -ne $distributor_file_hash) {
        Write-Host "hash must be equal to: ${distributor_file_hash}"
        Write-Host "actual hash is: ${local_file_hash}"
        throw 'Checksum verification failed, please rerun install'
}
#endregion

# Update PATH
Add-MachinePathItem "$installDir\bin"
$env:Path = Get-MachinePath

Invoke-PesterTests -TestFile "Tools" -TestName "OpenSSL"
