function Install-ChocoPackage {
    <#
    .SYNOPSIS
        A function to install a Chocolatey package with retries.

    .DESCRIPTION
        This function attempts to install a specified Chocolatey package. If the 
        installation fails, it retries a specified number of times.

    .PARAMETER PackageName
        The name of the Chocolatey package to install.

    .PARAMETER ArgumentList
        An array of arguments to pass to the choco install command.

    .PARAMETER RetryCount
        The number of times to retry the installation if it fails. Default is 5.

    .EXAMPLE
        Install-ChocoPackage -PackageName "git" -RetryCount 3
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $PackageName,
        [string[]] $ArgumentList,
        [int] $RetryCount = 5
    )

    process {
        $count = 1
        while ($true) {
            Write-Host "Running [#$count]: choco install $packageName -y $argumentList"
            choco install $packageName -y @argumentList --no-progress --require-checksums

            $pkg = choco list --localonly $packageName --exact --all --limitoutput
            if ($pkg) {
                Write-Host "Package installed: $pkg"
                break
            } else {
                $count++
                if ($count -ge $retryCount) {
                    Write-Host "Could not install $packageName after $count attempts"
                    exit 1
                }
                Start-Sleep -Seconds 30
            }
        }
    }
}

function Resolve-ChocoPackageVersion {
    <#
    .SYNOPSIS
        Resolves the latest version of a Chocolatey package.

    .DESCRIPTION
        This function takes a package name and a target version as input and returns the latest
        version of the package that is greater than or equal to the target version.

    .PARAMETER PackageName
        The name of the Chocolatey package.

    .PARAMETER TargetVersion
        The target version of the package.

    .EXAMPLE
        Resolve-ChocoPackageVersion -PackageName "example-package" -TargetVersion "1.0.0"
        Returns the latest version of the "example-package" that is greater than or equal to "1.0.0".
    #>

    param(
        [Parameter(Mandatory)]
        [string] $PackageName,
        [Parameter(Mandatory)]
        [string] $TargetVersion
    )

    $searchResult = choco search $PackageName --exact --all-versions --approved-only --limit-output | 
        ConvertFrom-CSV -Delimiter '|' -Header 'Name', 'Version'

    $latestVersion = $searchResult.Version | 
        Where-Object { $_ -Like "$TargetVersion.*" -or $_ -eq $TargetVersion } | 
        Sort-Object { [version] $_ } | 
        Select-Object -Last 1

    return $latestVersion
}
