BeforeAll {
    $msys2BinDir = "C:\msys64\usr\bin"
    $msys2mingwDir = "C:\msys64\mingw64\bin"
    }
Describe "MSYS2" {
    It "<ToolsInstalled>" -TestCases @(
        @{ ToolsInstalled = "bash.exe" }
        @{ ToolsInstalled = "tar.exe" }
        @{ ToolsInstalled = "make.exe" }
    ) {
        Join-Path ${msys2BinDir} $ToolsInstalled | Should -Exist
    }

    It "<ToolsInstalled>" -TestCases @(
        @{ ToolsInstalled = "gcc.exe" }
        @{ ToolsInstalled = "cmake.exe" }
        @{ ToolsInstalled = "g++.exe" }
    ) {
        Join-Path ${msys2mingwDir} $ToolsInstalled | Should -Exist
    }
}