################################################################################
##  File:  Validate-KubernetesCli.ps1
##  Desc:  Validate KubernetesCli.
################################################################################


if((Get-Command -Name 'kubectl'))
{
    Write-Host "kubectl $(kubectl version --client=true --short=true) in path"
}
else
{
    Write-Host "kubectl is not in path"
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "Kubectl"

$version = $(kubectl version --client=true --short=true)

$Description = @"
_Version:_ $version<br/>
_Environment:_
* PATH: contains location of kubectl.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
