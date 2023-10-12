################################################################################
##  File:  Install-Miniconda.ps1
##  Desc:  Install the latest version of Miniconda and set $env:CONDA
##  Supply chain security: checksum validation
################################################################################

$CondaDestination = "C:\Miniconda"

# Install the latest Miniconda
$InstallerName = "Miniconda3-latest-Windows-x86_64.exe"
$InstallerUrl = "https://repo.anaconda.com/miniconda/${InstallerName}"
$ArgumentList = ("/S", "/AddToPath=0", "/RegisterPython=0", "/D=$CondaDestination")

Install-Binary -Url $InstallerUrl -Name $InstallerName -ArgumentList $ArgumentList
Set-SystemVariable -SystemVariable "CONDA" -Value $CondaDestination

#region Supply chain security
$localFileHash = (Get-FileHash -Path (Join-Path ${env:TEMP} $installerName) -Algorithm SHA256).Hash
$distributorFileHash = $null

$checksums = (Invoke-RestMethod -Uri 'https://repo.anaconda.com/miniconda/' | ConvertFrom-HTML).SelectNodes('//html/body/table/tr')

ForEach($node in $checksums) {
    if ($node.ChildNodes[1].InnerText -eq $InstallerName) {
        $distributorFileHash = $node.ChildNodes[7].InnerText
    }
}

Use-ChecksumComparison -LocalFileHash $localFileHash -DistributorFileHash $distributorFileHash
#endregion

Invoke-PesterTests -TestFile "Miniconda"
