################################################################################
##  File:  Install-Terraform.ps1
##  Desc:  Install Terraform
################################################################################

Choco-Install -PackageName terraform

Invoke-PesterTests -TestFile "Tools" -TestName "Terraform"