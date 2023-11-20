################################################################################
##  File:  Install-Miniconda.ps1
##  Desc:  Install the latest version of Miniconda and set $env:CONDA
##  Supply chain security: checksum validation
################################################################################

$CondaDestination = "C:\Miniconda"
$InstallerName = "Miniconda3-latest-Windows-x86_64.exe"

#region Supply chain security
$distributorFileHash = $null
$checksums = (Invoke-RestMethod -Uri 'https://repo.anaconda.com/miniconda/' | ConvertFrom-HTML).SelectNodes('//html/body/table/tr')

foreach ($node in $checksums) {
    if ($node.ChildNodes[1].InnerText -eq $InstallerName) {
        $distributorFileHash = $node.ChildNodes[7].InnerText
    }
}

if ($null -eq $distributorFileHash) {
    throw "Unable to find checksum for $InstallerName in https://repo.anaconda.com/miniconda/"
}
#endregion

Install-Binary `
    -Url "https://repo.anaconda.com/miniconda/${InstallerName}" `
    -Args @("/S", "/AddToPath=0", "/RegisterPython=0", "/D=$CondaDestination") `
    -ExpectedSHA256Sum $distributorFileHash

[System.Environment]::SetEnvironmentVariable("CONDA", $CondaDestination, "Machine")

Invoke-PesterTests -TestFile "Miniconda"
