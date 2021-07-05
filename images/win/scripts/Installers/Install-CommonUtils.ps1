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

npm install -g @bazel/bazelisk

Invoke-PesterTests -TestFile "BasicTools"