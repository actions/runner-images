################################################################################
##  File:  Install-LLVM.ps1
##  Desc:  Install the latest stable version of llvm and clang compilers
################################################################################

$llvmVersion = (Get-ToolsetContent).llvm.version
$latestChocoVersion = Get-LatestChocoPackageVersion -TargetVersion $llvmVersion -PackageName "llvm"
Choco-Install -PackageName llvm -ArgumentList "--version $latestChocoVersion"

Invoke-PesterTests -TestFile "LLVM"
