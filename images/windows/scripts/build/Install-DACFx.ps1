####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DacFx) for Windows
####################################################################################

Install-Binary -Type MSI `
    -Url 'https://aka.ms/dacfx-msi' `
    -ExpectedSignature '72105B6D5F370B62FD5C82F1512F7AD7DEE5F2C0'

Invoke-PesterTests -TestFile "Tools" -TestName "DACFx"
