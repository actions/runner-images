################################################################################
##  File:  Install-WebPI.ps1
##  Desc:  Install WebPlatformInstaller
################################################################################

Install-Binary -Type MSI `
    -Url 'https://go.microsoft.com/fwlink/?LinkId=287166' `
    -ExpectedSubject $script:MicrosoftPublisherSubject

Invoke-PesterTests -TestFile "Tools" -TestName "WebPlatformInstaller"
