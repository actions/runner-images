$ErrorActionPreference = "Stop"
# Comment here
function Validate-Scripts {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$Path,
        [Parameter(Mandatory=$true)]
        [string]$ExpectedShebang
    )
    $ScriptWithoutShebangLine = @()
    Get-ChildItem $path -Recurse -File -Filter "*.sh" | ForEach-Object {
        $RelativePath = Join-Path $Path $($_.Name)
        $shebangLine = Get-Content -Path $RelativePath | Select-Object -First 1
        if ($shebangLine -eq $ExpectedShebang) {
            Write-Host "Pattern '$ExpectedShebang' found in '$RelativePath'"
        }
        else {
            Write-Host "Pattern '$ExpectedShebang' not found in '$RelativePath'"
            $ScriptWithoutShebangLine += $RelativePath
        }
    }
    return $ScriptWithoutShebangLine
}

$PathUbuntu = "./images/linux/scripts"
$PathMacOS = "./images/macos/provision"
$ScriptsWithBrokenShebang = @()
$ScriptsWithBrokenShebang += Validate-Scripts -Path $PathUbuntu -ExpectedShebang "#!/bin/bash -e"
$ScriptsWithBrokenShebang += Validate-Scripts -Path $PathMacOS -ExpectedShebang "#!/bin/bash -e -o pipefail"
if ($ScriptsWithBrokenShebang.Length -gt 0) {
    $ScriptsWithBrokenShebang | ForEach-Object {
        Write-Warning "The following script does not contain shebang: '$_'"
    }
    exit 1
}