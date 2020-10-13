param(
    [Parameter(Mandatory)] [string] $path,
    [Parameter(Mandatory)] [string] $pattern
)

$ErrorActionPreference = "Stop"

function Validate-Scripts {
    Param (
        [Parameter(Mandatory=$true)]
        [string[]]$Path,
        [Parameter(Mandatory=$true)]
        [string]$Pattern
    )
     $ScriptWithoutShebangLine = @()
     Get-ChildItem $path | ForEach-Object {
       if (Get-Content -Path $($_.FullName) | Select-Object -First 1 | Select-String -Pattern $Pattern -Quiet) {
          Write-Host "Pattern '$Pattern' found in '$($_.FullName)'"
       }
       else {
          Write-Host "Pattern '$Pattern' not found in '$($_.FullName)'"
          $ScriptWithoutShebangLine += $($_.FullName)
       }
    }
    return $ScriptWithoutShebangLine
}

$ScriptsWithBrokenShebang = @()
$ScriptsWithBrokenShebang += Validate-Scripts -Path $path1 -Pattern "#!/bin/bash -e"
$ScriptsWithBrokenShebang += Validate-Scripts -Path $path2 -Pattern "#!/bin/bash -e"
if ($ScriptsWithBrokenShebang.Length -gt 0) {
    $ScriptsWithBrokenShebang | ForEach-Object {
    Write-Warning "The following script does not contain shebang: '$_'"
  }
  exit 1
}