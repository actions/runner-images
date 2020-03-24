################################################################################
##  File:  Validate-Git.ps1
##  Desc:  Validate Git for Windows
################################################################################
function Test-CommandName {
    param(
        [parameter(Mandatory)][string] $CommandName
    )
    Write-Host "Checking the [$CommandName]"
    if(-not (Get-Command $CommandName -ErrorAction "Continue")) {
        Write-Host "[!] $CommandName is not found"
        exit 1
    }
}
function Test-Command  {
    param(
        [parameter(Mandatory)][string] $CommandName,
        [parameter(Mandatory)][string] $CommandDescription,
        [parameter(Mandatory)][string] $VersionCmd,
        [parameter(Mandatory)][string] $regexVersion,
        [parameter(Mandatory)][string] $DescriptionMarkdown
    )
    Test-CommandName -CommandName $CommandName

    $strVersion = Invoke-Expression $VersionCmd
    Write-Host "$strVersion on path"
    if($strVersion -match $regexVersion) {
        $Version = $Matches.version
    }
    else {
        Write-Host "[!] $CommandName version detection failed"
        exit 1
    }
    # Adding description of the software to Markdown
    $DescriptionMarkdown = $DescriptionMarkdown -f $Version
    Add-SoftwareDetailsToMarkdown -SoftwareName $CommandDescription -DescriptionMarkdown $DescriptionMarkdown
}

Test-CommandName -CommandName 'bash'
Test-CommandName -CommandName 'awk'

$GitDescription = @"
_Version:_ {0}<br/>
_Environment:_
* PATH: contains location of git.exe
"@
Test-Command -CommandName 'git' -CommandDescription 'Git' -VersionCmd "git version" -regexVersion 'git version (?<version>.*).win.*' -DescriptionMarkdown $GitDescription

$GitLfsDescription = @"
_Version:_ {0}<br/>
_Environment:_
* PATH: contains location of git-lfs.exe
* GIT_LFS_PATH: location of git-lfs.exe
"@
Test-Command -CommandName 'git-lfs' -CommandDescription 'Git Large File Storage (LFS)' -VersionCmd "git-lfs version" -regexVersion 'git-lfs\/(?<version>.*) \(Git.*' -DescriptionMarkdown $GitLfsDescription

$HubCliDescription = @"
_Version:_ {0}<br/>
_Environment:_
* PATH: contains location of hub.exe
"@
Test-Command -CommandName 'hub' -CommandDescription 'Hub CLI' -VersionCmd "hub version | Select-String 'hub version'" -regexVersion 'hub version (?<version>.*)' -DescriptionMarkdown $HubCliDescription