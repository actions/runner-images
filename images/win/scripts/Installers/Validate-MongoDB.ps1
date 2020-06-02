################################################################################
##  File:  Validate-MongoDB.ps1
##  Desc:  Validate MongoDB
################################################################################

$command = Get-Command -Name 'mongod'
if($command)
{
    Write-Host "mongod is on path"
}
else
{
    Write-Host 'mongod not on path'
    exit 1
}

$command = Get-Command -Name 'mongo'
if($command)
{
    Write-Host "mongo is on path"
}
else
{
    Write-Host 'mongo not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "MongoDB"
$version = $command.Version.ToString();

$Description = @"
_Version:_ $version<br/>
_Environment:_
* PATH: contains location of mongo.exe and mongod.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
