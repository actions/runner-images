################################################################################
##  File:  Install-ContainersFeature.ps1
##  Desc:  Install Windows container features.
##         Must be an independent step becuase it requires a machine restart
##         before we can continue.
################################################################################

Write-Host "Install Containers feature"
Install-WindowsFeature -Name Containers

Invoke-PesterTests -TestFile "WindowsFeatures" -TestName "ContainersFeature"