################################################################################
##  File:  Validate-Git.ps1
##  Desc:  Validate Git for Windows
################################################################################

if((Get-Command -Name 'git') -and (Get-Command -Name 'bash') -and (Get-Command -Name 'awk') -and (Get-Command -Name 'git-lfs') -and (Get-Command -Name 'hub'))
{
    Write-Host "$(git version) on path"
    Write-Host "$(git-lfs version) on path"
    Write-Host "$(hub version | Select-String 'hub version') on path"
}
else
{
    Write-Host "git or git-lfs or hub are not on path."
    exit 1
}

if( $(git version) -match  'git version (?<version>.*).win.*' )
{
   $gitVersion = $Matches.version
}

if( $(git-lfs version) -match  'git-lfs\/(?<version>.*) \(Git.*' )
{
   $gitLfsVersion = $Matches.version
}

if($(hub version | Select-String "hub version") -match 'hub version (?<version>.*)')
{
    $hubVersion = $Matches.version
}

#Adding description of the software to Markdown
$GitDescription = @"
_Version:_ $gitVersion<br/>
_Environment:_
* PATH: contains location of git.exe
"@
Add-SoftwareDetailsToMarkdown -SoftwareName "Git" -DescriptionMarkdown $GitDescription

# Adding description of the software to Markdown
$GitLfsDescription = @"
_Version:_ $gitLfsVersion<br/>
_Environment:_
* PATH: contains location of git-lfs.exe
* GIT_LFS_PATH: location of git-lfs.exe
"@
Add-SoftwareDetailsToMarkdown -SoftwareName "Git Large File Storage (LFS)" -DescriptionMarkdown $GitLfsDescription

#Adding description of the software to Markdown
$HubCliDescription = @"
_Version:_ $hubVersion<br/>
_Environment:_
* PATH: contains location of hub.exe
"@
Add-SoftwareDetailsToMarkdown -SoftwareName "Hub CLI" -DescriptionMarkdown $HubCliDescription