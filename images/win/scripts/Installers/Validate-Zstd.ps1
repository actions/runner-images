################################################################################
##  File:  Validate-zstd.ps1
##  Desc:  Validate zstd
################################################################################

if (Get-Command -Name 'zstd')
{
    Write-Host "zstd on path"
}
else
{
    Write-Host 'zstd is not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "zstd"
$zstdVersion = $(zstd --version).Split(' ')[6].Split(',')[0]

$Description = @"
_Version:_ $zstdVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
