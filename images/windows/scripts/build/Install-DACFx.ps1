####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DacFx) for Windows
####################################################################################

Install-Binary -Type MSI `
    -Url 'https://aka.ms/dacfx-msi' `
    -ExpectedSignature '8F985BE8FD256085C90A95D3C74580511A1DB975'

Invoke-PesterTests -TestFile "Tools" -TestName "DACFx"
