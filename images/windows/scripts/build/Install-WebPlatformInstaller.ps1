################################################################################
##  File:  Install-WebPI.ps1
##  Desc:  Install WebPlatformInstaller
################################################################################

Install-Binary -Type MSI `
    -Url 'http://go.microsoft.com/fwlink/?LinkId=287166' `
    -ExpectedSignature 'C3A3D43788E7ABCD287CB4F5B6583043774F99D2'

Invoke-PesterTests -TestFile "Tools" -TestName "WebPlatformInstaller"
