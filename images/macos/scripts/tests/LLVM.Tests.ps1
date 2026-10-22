Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1"

Describe "Clang/LLVM" {
    BeforeAll {
        $toolsetVersion = (Get-ToolsetContent).llvm.version
    }

    It "Clang/LLVM <toolsetVersion> is installed and version is correct" {
        $clangVersion = & "$(brew --prefix llvm@$toolsetVersion)/bin/clang" --version
        $clangVersion[0] | Should -BeLike "*${toolsetVersion}*"
    }

    It "Default clang points to Apple clang" {
        (Get-CommandResult "which clang").Output.Trim() | Should -Be "/usr/bin/clang"
        (Get-CommandResult "clang --version").Output | Should -BeLike "*Apple clang*"
    }
}
