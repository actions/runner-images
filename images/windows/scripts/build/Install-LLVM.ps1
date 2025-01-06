################################################################################
##  File:  Install-LLVM.ps1
##  Desc:  Install the latest stable version of llvm and clang compilers
################################################################################

$llvmVersion = (Get-ToolsetContent).llvm.version
$latestChocoVersion = Resolve-ChocoPackageVersion -PackageName "llvm" -TargetVersion $llvmVersion
Install-ChocoPackage llvm -ArgumentList '--version', $latestChocoVersion

Invoke-PesterTests -TestFile "LLVM"
