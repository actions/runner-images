# Validate the installation
$env:PSModulePath = Get-SystemVariable "PSModulePath"
$modules = Get-Module -Name SQLPS -ListAvailable
Write-Host "The SQLPS Modules present are:"
$modules | Select-Object Name,Version,Path | Format-Table

if ($modules) {
    $sqlPSVersion = $modules.Version
}

# Validate the SQLserver PS module installation
$modules = Get-Module -Name SQLServer -ListAvailable
Write-Host "The SQLServer Modules present are:"
$modules | Select-Object Name,Version,Path | Format-Table

if ($modules) {
    $sqlServerPSModuleVersion = $modules.Version
}


# Adding description of the software to Markdown
$SoftwareName = "SQLPS"

$Description = @"
_Version:_ $sqlPSVersion
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

# Adding description of the software to Markdown
$SoftwareName = "SQLServer PS"

$Description = @"
_Version:_ $sqlServerPSModuleVersion
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
