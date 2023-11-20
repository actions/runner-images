################################################################################
##  File:  Install-R.ps1
##  Desc:  Install R for Windows
################################################################################

Install-ChocoPackage R.Project
Install-ChocoPackage rtools

$rscriptPath = Resolve-Path "C:\Program Files\R\*\bin\x64"
Add-MachinePathItem $rscriptPath
Invoke-PesterTests -TestFile "Tools" -TestName "R"
