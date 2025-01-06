Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Clang/LLVM" {
    BeforeAll {
        $toolsetVersion = (Get-ToolsetContent).llvm.version
    }

    It "Clang/LLVM <toolsetVersion> is installed and version is correct" {
        $clangVersion = & "$(brew --prefix llvm@$toolsetVersion)/bin/clang" --version
        $clangVersion[0] | Should -BeLike "*${toolsetVersion}*"
    }
}
