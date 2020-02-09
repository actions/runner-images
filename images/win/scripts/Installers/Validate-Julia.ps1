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

# Add details of available versions in Markdown
$tmplMark = @"
#### {0}

_Environment:_
* {1}: root directory of the Julia {0} installation

"@

$tmplMarkRoot = @"
#### {0}

_Environment:_
* PATH: contains the location of julia.exe version {0}
* {1}: root directory of the Julia {0} installation
"@

$SoftwareName = "Julia (x64)"
$Description = New-Object System.Text.StringBuilder
$juliaVersionsToInstall = $env:JULIA_VERSIONS.split(",")

foreach($julia in $juliaVersionsToInstall) {
    $juliaVersion = Get-JuliaVersion
    if ($juliaVersion -eq $julia) {
        if($julia -eq $env:JULIA_DEFAULT) {
            $null = $Description.AppendLine(($tmplMarkRoot -f $juliaVersion))
        } else {
            $null = $Description.AppendLine(($tmplMark -f $juliaVersion))
        }
    }
}

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description.ToString()
