################################################################################
##  File:  post-build-validation.sh
##  Desc:  Validate different aspects of the image after build
################################################################################

Write-Host "Test Microsoft Defender not set up using 'sc query sense'"
$response =  sc query sense
foreach ($item in $response) {
    if ($item -match "STATE") {
        $state = $item.Split(":")[1].Trim()
        if ($state -notmatch "RUNNING") {
            Write-Host "MDE is not running"
        } else {
            Write-Host "MDE is running"
            exit 1
        }
    }
}

Write-Host "Test Microsoft Defender not set up by checking for the MDE extension"
if (Test-Path -Path "C:\Packages\Plugins\Microsoft.Azure.AzureDefenderForServers.MDE.Windows") {
    Write-Error "MDE extension detected, MDE is more likely installed on the system"
    exit 1
} else {
    Write-Host "MDE is not setup on the system"
}
