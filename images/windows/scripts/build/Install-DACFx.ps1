####################################################################################
##  File:  Install-DACFx.ps1
##  Desc:  Install SQL Server® Data-Tier Application Framework (DacFx) for Windows
####################################################################################

Install-Binary -Type MSI `
    -Url 'https://aka.ms/dacfx-msi' `
    -ExpectedSubject $(Get-MicrosoftPublisher)

Invoke-PesterTests -TestFile "Tools" -TestName "DACFx"
