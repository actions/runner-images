################################################################################
##  File:  Configure-DotnetSecureChannel.ps1
##  Desc:  Configure .NET to use TLS 1.2
################################################################################

$registryPath = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319"
$name = "SchUseStrongCrypto"
$value = "1"
if (Test-Path $registryPath) {
    Set-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWORD
}

$registryPath = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319"
if (Test-Path $registryPath) {
    Set-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWORD
}
