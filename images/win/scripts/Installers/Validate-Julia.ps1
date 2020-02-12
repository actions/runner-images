################################################################################
##  File:  Validate-Julia.ps1
##  Desc:  Validate Julia
################################################################################

# Verify that julia.exe is on the path
if(Get-Command -Name 'julia')
{
    Write-Host "$(julia --version) is on the path."
}
else
{
    Write-Host "Julia is not on the path."
    exit 1
}

# Add description of the software to Markdown
$SoftwareName = "Julia (x64)"
$juliaVersion = $(julia --version).split() -match "\d+\.\d+\.\d+"

$Description = @"
_Version:_ $juliaVersion<br/>
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
