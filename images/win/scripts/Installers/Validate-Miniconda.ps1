################################################################################
##  File:  Validate-Miniconda.ps1
##  Desc:  Validate Miniconda
################################################################################

if ($env:CONDA)
{
    Write-Host "The CONDA environment variable is set"
    Write-Host $env:CONDA
}
else
{
    Write-Host "The CONDA environment variable is not set"
    exit 1
}

if ((Test-Path "$env:CONDA\python.exe") -and (Test-Path "$env:CONDA\Scripts\conda.exe"))
{
    Write-Host "Miniconda is successfully installed:"
    & "$env:CONDA\Scripts\conda.exe" --version | Write-Host
}
else
{
    Write-Host "Miniconda is not installed"
    exit 1
}

$softwareName = "Miniconda"
$description = @"
_Version:_ $(& "$env:CONDA\Scripts\conda.exe" --version)<br/>
_Environment:_
* CONDA: contains location of the root of the Miniconda installation
"@

# Adding description of the software to Markdown
Add-SoftwareDetailsToMarkdown -SoftwareName $softwareName -DescriptionMarkdown $description
