################################################################################
##  File:  Install-Cmake.ps1
##  Desc:  Install Cmake
################################################################################

Choco-Install -PackageName cmake.install -ArgumentList "--installargs",'ADD_CMAKE_TO_PATH=""System""'

# Restart current session
Write-Host "debug 1"
Invoke-Command { Run-PesterTests -TestFile "Cmake" } -NoNewScope
Write-Host "debug 2"
Invoke-Command { Run-PesterTests -TestFile "Cmake" }
Write-Host "debug 3"

# Run Pester Test
Run-PesterTests -TestFile "Cmake"