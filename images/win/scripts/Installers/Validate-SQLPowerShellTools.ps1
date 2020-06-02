# Validate the installation
$env:PSModulePath = Get-SystemVariable "PSModulePath"
$modules = Get-Module -Name SQLPS -ListAvailable
Write-Host "The SQLPS Modules present are:"
$modules | Select-Object Name,Version,Path | Format-Table

# Validate the SQLserver PS module installation
$modules = Get-Module -Name SQLServer -ListAvailable
Write-Host "The SQLServer Modules present are:"
$modules | Select-Object Name,Version,Path | Format-Table
