$commonPackages = (Get-ToolsetContent).choco.common_packages

foreach ($package in $commonPackages)
{
    Write-Host "Installing ${package.name}"
    if ($package.args) {
        Choco-Install -PackageName $package.name -ArgumentList $package.args
    } else {
        Choco-Install -PackageName $package.name
    }
}

Invoke-PesterTests -TestFile "ChocoPackages"