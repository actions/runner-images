$env:msys2BinDir = "C:\msys64\usr\bin"
$env:msys2mingwDir = "C:\msys64\mingw64\bin"

Describe "MSYS2" {
    It "Check <ToolsInstalled>" -TestCases @(
        @{ ToolsInstalled = "bash.exe" }
        @{ ToolsInstalled = "tar.exe" }
        @{ ToolsInstalled = "make.exe" }
    ) {
        Join-Path ${env:msys2BinDir} $ToolsInstalled | Should -Exist
    }

    It "Check MinGW <ToolsInstalled>" -TestCases @(
        @{ ToolsInstalled = "gcc.exe" }
        @{ ToolsInstalled = "cmake.exe" }
        @{ ToolsInstalled = "g++.exe" }
    ) {
        Join-Path ${env:msys2mingwDir} $ToolsInstalled | Should -Exist
    }
}