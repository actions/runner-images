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

Test-CommandName -CommandName 'bash'
Test-CommandName -CommandName 'awk'
Test-CommandName -CommandName 'git'
Test-CommandName -CommandName 'git-lfs'
Test-CommandName -CommandName 'hub'
