################################################################################
##  File:  Validate-AzureDevOpsCli.ps1
##  Desc:  Validate Azure DevOps CLI
################################################################################

az devops -h

if($LastExitCode -ne 0)
{
    Write-Error "Azure DevOps Cli extension not present"
    exit 1
}
else
{
    Write-Host "Azure DevOps Cli extension is present"
}

$azDevopsVer = az -v | findstr azure-devops

$Description = @"
_Version:_ $azDevopsVer
"@

Add-SoftwareDetailsToMarkdown -SoftwareName 'Azure DevOps Cli extension' -DescriptionMarkdown $Description
