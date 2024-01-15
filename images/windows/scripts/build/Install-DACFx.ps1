####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DacFx) for Windows
####################################################################################

Install-Binary -Type MSI `
    -Url 'https://aka.ms/dacfx-msi' `
    -ExpectedSignature 'C2048FB509F1C37A8C3E9EC6648118458AA01780'

Invoke-PesterTests -TestFile "Tools" -TestName "DACFx"
