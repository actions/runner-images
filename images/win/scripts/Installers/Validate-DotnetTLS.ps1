################################################################################
##  File:  Validate-DotnetTLS.ps1
##  Desc:  Validate DotNetFramework security protocol to TLS 1.2
################################################################################

$protocols = [Net.ServicePointManager]::SecurityProtocol
$protocolArr = $protocols -split ', '
if ($protocolArr.Contains('Tls12'))
{
    Write-Host 'Tls 1.2 has been enabled.'
}
else
{
    Write-Host 'Tls 1.2 has not been enabled.'
    exit 1
}


