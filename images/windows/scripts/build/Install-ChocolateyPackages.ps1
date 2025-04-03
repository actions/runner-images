################################################################################
##  File:  Install-ChocolateyPackages.ps1
##  Desc:  Install common Chocolatey packages
################################################################################

$commonPackages = (Get-ToolsetContent).choco.common_packages

foreach ($package in $commonPackages) {
    Install-ChocoPackage $package.name -ArgumentList "--version $package.version $package.args"
}

Invoke-PesterTests -TestFile "ChocoPackages"
