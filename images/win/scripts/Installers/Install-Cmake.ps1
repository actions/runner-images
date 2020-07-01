################################################################################
##  File:  Install-Cmake.ps1
##  Desc:  Install Cmake
################################################################################

Choco-Install -PackageName cmake.install -ArgumentList "--installargs",'ADD_CMAKE_TO_PATH=""System""'

# Restart current session
Invoke-Command { & "powershell.exe" } -NoNewScope

# Run Pester Test
Run-PesterTests -TestFile "Cmake"