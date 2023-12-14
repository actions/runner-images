################################################################################
##  File:  Install-Miniconda.ps1
##  Desc:  Install the latest version of Miniconda and set $env:CONDA
##  Supply chain security: checksum validation
################################################################################

$condaDestination = "C:\Miniconda"
$installerName = "Miniconda3-latest-Windows-x86_64.exe"

#region Supply chain security
$distributorFileHash = $null
$checksums = (ConvertFrom-HTML -Uri 'https://repo.anaconda.com/miniconda/').SelectNodes('//html/body/table/tr')

foreach ($node in $checksums) {
    if ($node.ChildNodes[1].InnerText -eq $installerName) {
        $distributorFileHash = $node.ChildNodes[7].InnerText
    }
}

if ($null -eq $distributorFileHash) {
    throw "Unable to find checksum for $installerName in https://repo.anaconda.com/miniconda/"
}
#endregion

Install-Binary `
    -Url "https://repo.anaconda.com/miniconda/${installerName}" `
    -InstallArgs @("/S", "/AddToPath=0", "/RegisterPython=0", "/D=$condaDestination") `
    -ExpectedSHA256Sum $distributorFileHash

[Environment]::SetEnvironmentVariable("CONDA", $condaDestination, "Machine")

Invoke-PesterTests -TestFile "Miniconda"
