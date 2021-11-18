Describe "Clang/LLVM" {
    It "Clang/LLVM installed and version is correct" {
        $toolsetVersion = (Get-ToolsetContent).llvm.version
        $clangVersion = clang --version
        $clangVersion[0] | Should -BeLike "*${toolsetVersion}*"
    }
}