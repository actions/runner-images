################################################################################
##  File:  Install-R.ps1
##  Desc:  Install R for Windows
################################################################################

Install-ChocoPackage R.Project
Install-ChocoPackage rtools

if (Test-IsArm64) {
    $rscriptPathPattern = "C:\Program Files (x86)\R\*\bin\x64"
} else {
    $rscriptPathPattern = "C:\Program Files\R\*\bin\x64"
}

$rscriptPath = Resolve-Path $rscriptPathPattern
Add-MachinePathItem $rscriptPath

Invoke-PesterTests -TestFile "Tools" -TestName "R"
