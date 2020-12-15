Import-Module "$PSScriptRoot/../helpers/Tests.Helpers.psm1"

(Get-ChildItem -Path $PSScriptRoot -Filter *.Tests.ps1).Name | ForEach-Object {
    Invoke-PesterTests $_.toString().split('.')[0]
}