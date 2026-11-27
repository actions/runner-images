Describe "Clang/LLVM" {
    BeforeAll {
        $toolsetVersion = (Get-ToolsetContent).llvm.version
    }

    It "Clang/LLVM <toolsetVersion> installed and version is correct" {
        $clangVersion = clang --version
        $clangVersion[0] | Should -BeLike "*${toolsetVersion}*"
    }

    It "Standalone clang-cl compiles and runs a program using MSVC STL" {
        $clangCl = Join-Path $env:ProgramFiles "LLVM\bin\clang-cl.exe"
        $vsDevCmd = Join-Path (Get-VisualStudioInstance).InstallationPath "Common7\Tools\VsDevCmd.bat"
        $architecture = if (Test-IsArm64) { "arm64" } else { "x64" }
        $sourcePath = Join-Path $TestDrive "atomic.cpp"
        $objectPath = Join-Path $TestDrive "atomic.obj"
        $executablePath = Join-Path $TestDrive "atomic.exe"

        $clangCl, $vsDevCmd | Should -Exist

        @'
#include <atomic>

#ifndef _MSVC_STL_VERSION
#error Expected MSVC STL
#endif

int main() {
    std::atomic<int> value{41};
    return value.fetch_add(1) == 41 && value.load() == 42 ? 0 : 1;
}
'@ | Set-Content -Path $sourcePath -Encoding ascii

        @(
            "call `"$vsDevCmd`" -no_logo -arch=$architecture -host_arch=$architecture"
            "`"$clangCl`" /nologo /EHsc /std:c++17 `"$sourcePath`" /Fo`"$objectPath`" /Fe`"$executablePath`""
            "`"$executablePath`""
        ) -join " && " | Should -ReturnZeroExitCode
    }
}
