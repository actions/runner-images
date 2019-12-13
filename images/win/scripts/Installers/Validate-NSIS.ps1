################################################################################
##  File:  Validate-NSIS.ps1
##  Desc:  Validate NSIS installation.
################################################################################

$SoftwareName = 'Nullsoft Install System (NSIS)'

if (Get-Command -Name makensis)
{
    Write-Host "$SoftwareName is installed"
}
else
{
    Write-Host "$SoftwareName is not installed"
    exit 1
}

# Adding description of the software to Markdown
$ChocoList = $(choco list --local-only nsis) | Select-String -Pattern "nsis" | Select-Object -First 1

if ($ChocoList -Match "\d+\.\d+")
{
    $Version = $Matches[0]
}


$Description = @"
_Version:_ $Version<br/>
"@

#Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
Write-Host $description
