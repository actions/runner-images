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
     $ScriptsWithBrokenShebang = @()
     Get-ChildItem $path | ForEach-Object {
       if (Get-Content -Path $($_.FullName) | Select-Object -First 1 | Select-String -Pattern $Pattern -Quiet) {
          Write-Host "Pattern '$Pattern' found in '$($_.FullName)'"
       }
       else {
          Write-Host "Pattern '$Pattern' not found in '$($_.FullName)'"
          $ScriptsWithBrokenShebang += $($_.FullName)
       }
    }
    return $ScriptsWithBrokenShebang
}

$ScriptsWithBrokenShebang = Validate-Scripts -Path $path -Pattern "#!/bin/bash -e"
if ($ScriptsWithBrokenShebang.Length -gt 0) {
    $ScriptsWithBrokenShebang | ForEach-Object {
    Write-Warning "The following script does not contain shebang: '$_'"
  }
  exit 1
}