function Assert-PhpSecurityVersion {
    <#
    .SYNOPSIS
        Rejects PHP versions without the upstream fixes for CVE-2026-109618/109619.
    #>
    param(
        [Parameter(Mandatory)][string] $Version,
        [string] $ExpectedBranch
    )

    if ($Version -notmatch '^\d+\.\d+\.\d+$') {
        throw "Unable to validate the installed stable PHP version: $Version"
    }
    $minimumVersions = @{ '8.2' = '8.2.35'; '8.3' = '8.3.36'; '8.4' = '8.4.27'; '8.5' = '8.5.12' }
    $branch = ([version]$Version).ToString(2)
    if ($ExpectedBranch -and $branch -ne $ExpectedBranch) {
        throw "PHP $Version does not match the configured PHP $ExpectedBranch release branch."
    }
    $minimumVersion = if ($minimumVersions.ContainsKey($branch)) { $minimumVersions[$branch] } else { '8.6.0' }
    if ([version]$Version -lt [version]$minimumVersion) {
        throw "PHP $Version lacks a verified fix for CVE-2026-109618/109619; need $minimumVersion or later."
    }
}

Export-ModuleMember -Function Assert-PhpSecurityVersion
