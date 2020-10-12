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
     $WrongScript = New-Object System.Collections.Generic.List[System.Object]
     Get-ChildItem $path | ForEach-Object {
       if (Select-String -Path $($_.FullName) -Pattern $Pattern -Quiet) {
          Write-Host "Pattern '$pattern' found in '$($_.FullName)'"
       }
       else {
          Write-Host "Pattern '$pattern' not found in '$($_.FullName)'"
          $WrongScript += $($_.FullName)
       }
    }
    return $WrongScript
}

$FailedScripts = Validate-Scripts -Path $path -Pattern "#/bin/bash -e"
if ($FailedScripts.Length -gt 0) {
  $FailedScripts | ForEach-Object {
    Write-Warning "The following script does not contain shebang: '$_'"
  }
  exit 1
}