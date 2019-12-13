################################################################################
##  File:  Validate-Git.ps1
##  Desc:  Validate Git for Windows
################################################################################

if((Get-Command -Name 'git') -and (Get-Command -Name 'bash') -and (Get-Command -Name 'awk') -and (Get-Command -Name 'git-lfs'))
{
    Write-Host "$(git version) on path"
    Write-Host "$(git-lfs version) on path"
}
else
{
    Write-Host "git or git-lfs are not on path."
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

# Adding description of the software to Markdown
$SoftwareName = "Git"

$Description = @"
_Version:_ $gitVersion<br/>
_Environment:_
* PATH: contains location of git.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

# Adding description of the software to Markdown
$SoftwareName = "Git Large File Storage (LFS)"

$Description = @"
_Version:_ $gitLfsVersion<br/>
_Environment:_
* PATH: contains location of git-lfs.exe
* GIT_LFS_PATH: location of git-lfs.exe
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description
