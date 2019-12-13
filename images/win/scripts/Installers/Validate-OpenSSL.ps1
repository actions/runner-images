################################################################################
##  File:  Validate-OpenSSL.ps1
##  Desc:  Validate openssl
################################################################################

if (Get-Command -Name 'openssl')
{
    Write-Host "openssl on path"
}
else
{
    Write-Host 'openssl is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "OpenSSL"

$versions = Get-Command openssl -All
foreach ($version in $versions)
{
    $command = "& `"$($version.Source)`" version"
    if ( $(Invoke-Expression -Command $command) -match '\d+\.\d+\.\d+\w?' )
    {
        $Description += "_Version:_ $($Matches[0]) at $($version.Source)<br/>"
    }
}

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
