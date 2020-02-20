################################################################################
##  File:  Validate-NodeLts.ps1
##  Desc:  Validate nodejs-lts and other common node tools.
################################################################################

if((Get-Command -Name 'node') -and (Get-Command -Name 'npm'))
{
    Write-Host "Node $(node --version) on path"
    Write-Host "Npm $(npm -version) on path"
}
else
{
    Write-Host "Node or npm is not on path"
    exit 1
}

if(Get-Command -Name 'yarn')
{
    Write-Host "yarn $(yarn --version) on path"
}
else
{
    Write-Host "yarn is not on path"
    exit 1
}

if( $(node --version) -match  'v(?<version>.*)' )
{
   $nodeVersion = $Matches.version
   $nodeArch = $(node -e "console.log(process.arch)")
}

$npmVersion = $(npm -version)

# Adding description of the software to Markdown
$SoftwareName = "Node.js"
$YarnInfo = "Yarn $(yarn -version)"

$Description = @"
_Version:_ $nodeVersion<br/>
_Architecture:_ $nodeArch<br/>
_Environment:_
* PATH: contains location of node.exe<br/>
* $YarnInfo<br/>

"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

# Adding description of the software to Markdown
$SoftwareName = "npm"

$Description = @"
_Version:_ $npmVersion<br/>
_Environment:_
* PATH: contains location of npm.cmd
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
