################################################################################
##  File:  Validate-PowershellCore.ps1
##  Desc:  Validate Powershell Core
################################################################################

if (Get-Command -Name 'pwsh')
{
    Write-Host "pwsh is on PATH"
}
else
{
    Write-Host "pwsh is not on PATH"
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "Powershell Core"

if(($(pwsh --version) | Out-String) -match 'PowerShell (?<version>.*)')
{
    $PowershellVersion = $Matches.version
}

$Description = @"
_Version:_ $PowershellVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
