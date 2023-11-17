Describe "Clang/LLVM" {
    BeforeAll {
        $toolsetVersion = (Get-ToolsetContent).llvm.version
    }

    It "Clang/LLVM <toolsetVersion> installed and version is correct" {
        $clangVersion = clang --version
        $clangVersion[0] | Should -BeLike "*${toolsetVersion}*"
    }
}
