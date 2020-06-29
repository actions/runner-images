################################################################################
##  File:  Validate-Cmake.ps1
##  Desc:  Validate Cmake
################################################################################

Describe "cmake" {

    It "cmake is on path." {
        if(Get-Command -Name 'cmake')
        {
            Write-Host "CMake $(cmake -version) on path"
        }
        else
        {
            Write-Host "CMake not on path"
            exit 1
        }
    }
}
