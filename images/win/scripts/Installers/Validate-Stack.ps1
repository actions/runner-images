################################################################################
##  File:  Validate-Stack.ps1
##  Desc:  Validate Stack for Windows
################################################################################

if (Get-Command -Name 'stack')
{
    Write-Host "stack is on the path"
}
else
{
    Write-Host "stack is not on path."
    exit 1
}

$StackVersion = stack --version --quiet

# Adding description of the software to Markdown
$SoftwareName = "Stack"

$Description = @"
_Version:_ $StackVersion<br/>
_Environment:_
* PATH: contains location of stack.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
