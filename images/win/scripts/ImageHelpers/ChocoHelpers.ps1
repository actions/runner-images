function Choco-Install {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $PackageName,
        [string[]] $ArgumentList,
        [int] $RetryCount = 5
    )

    process {
        $count = 1
        while($true)
        {
            Write-Host "Running [#$count]: choco install $packageName -y $argumentList"
            choco install $packageName -y @argumentList --no-progress

            $pkg = choco list --localonly $packageName --exact --all --limitoutput
            if ($pkg) {
                Write-Host "Package installed: $pkg"
                break
            }
            else {
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

function Get-ChocoPackageLatestVersion {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $PackageName,
        [Parameter(Mandatory)]
        [string] $TargetVersion
    )

    $filterQuery = "`$filter=(Id eq `'$PackageName`') and (IsPrerelease eq false) and (Version ge `'$TargetVersion`') and (Version lt `'$($TargetVersion + 1)`')"
    $latestVersion = (Invoke-RestMethod "https://community.chocolatey.org/api/v2/Packages()?$filterQuery").properties.Version |
        Sort-Object{[version]$_} -Descending |
        Select-Object -First 1
    
    return $latestVersion
}