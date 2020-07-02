################################################################################
##  File:  Install-Cmake.ps1
##  Desc:  Install Cmake
################################################################################

Choco-Install -PackageName cmake.install -ArgumentList "--installargs",'ADD_CMAKE_TO_PATH=""System""'

# Restart current session
Write-Host "debug 1"
#Invoke-Command { & powershell -Command 'Run-PesterTests -TestFile "Common" -TestName "Kind"' } -NoNewScope
Write-Host "debug 2"
#Invoke-Command { & powershell -Command 'Run-PesterTests -TestFile "Common" -TestName "Kind"' }
Write-Host "debug 3"

# Run Pester Test
#Run-PesterTests -TestFile "Cmake"