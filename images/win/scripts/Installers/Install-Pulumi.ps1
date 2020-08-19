################################################################################
##  File:  Install-Pulumi.ps1
##  Desc:  Install Pulumi
################################################################################

Choco-Install -PackageName pulumi.install

Invoke-PesterTests -TestFile "Tools" -TestName "Pulumi"