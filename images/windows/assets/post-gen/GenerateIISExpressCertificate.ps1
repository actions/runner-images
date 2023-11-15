$friendlyName = "IIS Express Development Certificate"
$certStore = "Cert:\LocalMachine\My"
$oldCert = Get-ChildItem $certStore | Where-Object FriendlyName -match $friendlyName

if(-not $oldCert) {
    Write-Host "$friendlyName certificate not found"
    return
}

Write-Host "Removing $($oldCert.Thumbprint) certificate"
Remove-Item -Path $oldCert.PSPath -Confirm:$false

Write-Host "Creating $friendlyName certificate"
$selfSignedCertParam = @{
    Subject = "localhost"
    DnsName = "localhost"
    KeyAlgorithm = "RSA"
    KeyLength = 2048
    NotBefore = (Get-Date)
    NotAfter = (Get-Date).AddYears(5)
    CertStoreLocation = $certStore
    FriendlyName = $friendlyName
    HashAlgorithm = "SHA256"
    KeyUsage = "DigitalSignature", "KeyEncipherment", "DataEncipherment"
    TextExtension = @("2.5.29.37={text}1.3.6.1.5.5.7.3.1")
}
$cert = New-SelfSignedCertificate @selfSignedCertParam

# The app ID is the IIS Express app ID
$certThumbprint = $cert.Thumbprint
$appId = "{214124cd-d05b-4309-9af9-9caa44b2b74a}"
$startPort = 44300
$endPort = 44399

Write-Host "Binding ${certThumbprint} certificate using netsh port=${startPort}:${endPort} and appID=${appId}"
$startPort..$endPort | ForEach-Object {
    $port = $_
    cmd /c "netsh http delete sslcert ipport=0.0.0.0:$port > nul 2>&1"
    cmd /c "netsh http add sslcert ipport=0.0.0.0:$port certhash=$certThumbprint appid=$appId certstorename=MY > nul 2>&1"
}
