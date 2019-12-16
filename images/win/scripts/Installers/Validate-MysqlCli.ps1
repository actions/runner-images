################################################################################
##  File:  Validate-MysqlCli.ps1
##  Desc:  Validate Mysql Cli
################################################################################

$command = Get-Command -Name 'mysql' 
if($command)
{
    Write-Host "Mysql is on path"
}
else
{
    Write-Host 'Mysql not on path'
    exit 1
}

# Adding description of the software to Markdown
$SoftwareName = "Mysql"
$version = $command.Version.ToString();

$Description = @"
_Version:_ $version<br/>
_Environment:_
* PATH: contains location of mysql.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
