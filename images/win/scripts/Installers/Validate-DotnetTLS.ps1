################################################################################
##  File:  Validate-DotnetTLS.ps1
##  Desc:  Validate DotNetFramework security protocol to TLS 1.2
################################################################################

$protocols = [Net.ServicePointManager]::SecurityProtocol
$protocolArr = $protocols -split ', '
if($protocolArr.Contains('Tls12'))
{
    Write-Host "Tls 1.2 has been enabled."
}
else
{
    Write-Host "Tls 1.2 has not been enabled."
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "TLS12"
$version = "1.2";

$Description = @"
_Version:_ $version<br/>
_Description:_ .NET has been configured to use TLS 1.2 by default
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

