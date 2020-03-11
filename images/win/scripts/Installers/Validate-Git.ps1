################################################################################
##  File:  Validate-Git.ps1
##  Desc:  Validate Git for Windows
################################################################################

if((Get-Command -Name 'git') -and (Get-Command -Name 'bash') -and (Get-Command -Name 'awk') -and (Get-Command -Name 'git-lfs') -and (Get-Command -Name 'hub'))
{
    Write-Host "$(git version) on path"
    Write-Host "$(git-lfs version) on path"

    $strHubVersion = $(hub version)[1]
    Write-Host "${strHubVersion} on path"
    $hubVersion = ($strHubVersion -split " ")[2]
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

# Adding description of the software to Markdown
$GitSoftware = @(
    [pscustomobject]@{
        SoftwareName = "Git";
        Description = @"
_Version:_ $gitVersion<br/>
_Environment:_
* PATH: contains location of git.exe
"@
    },
    [pscustomobject]@{
        SoftwareName = "Git Large File Storage (LFS)";
        Description = @"
_Version:_ $gitLfsVersion<br/>
_Environment:_
* PATH: contains location of git-lfs.exe
* GIT_LFS_PATH: location of git-lfs.exe
"@
    },
    [pscustomobject]@{
        SoftwareName = "Hub CLI";
        Description = @"
_Version:_ $hubVersion<br/>
_Environment:_
* PATH: contains location of hub.exe
* GIT_LFS_PATH: location of hub.exe
"@
    }
)

$GitSoftware | ForEach-Object {
    Add-SoftwareDetailsToMarkdown -SoftwareName $_.SoftwareName -DescriptionMarkdown $_.Description
}
