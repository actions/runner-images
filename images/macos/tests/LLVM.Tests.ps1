$os = Get-OSVersion

Describe "Clang/LLVM" {
    It "Clang/LLVM is installed and version is correct" {
        $toolsetVersion = Get-ToolsetValue 'llvm.version'
        $clangVersion = & "$(brew --prefix llvm)/bin/clang" --version
        $clangVersion[0] | Should -BeLike "*${toolsetVersion}*"
    }
}