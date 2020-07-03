################################################################################
##  File:  Validate-AWS-CLI-SM.ps1
##  Desc:  Validate aws cli session manager
################################################################################

$sessionMessage = session-manager-plugin

if ($sessionMessage -Match "*plugin was installed successfully*") {
    Write-Host "$sessionMessage"
    exit 0
} else {
    Write-Host "$sessionMessage"
    exit 1
}