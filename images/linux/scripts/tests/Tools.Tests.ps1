Describe "7-Zip" {
    It "7z" {
        "7z" | Should -ReturnZeroExitCode
    }
}

Describe "azcopy" {
    It "azcopy" {
        #(azcopy --version) command returns exit code 1 (see details: https://github.com/Azure/azure-storage-azcopy/releases)
        $azcopyVersion = (Get-CommandResult "azcopy --version").Output
        $azcopyVersion | Should -BeLike "*azcopy*"
    }

    It "azcopy10" {
        "azcopy10 --version" | Should -ReturnZeroExitCode
    }
}

Describe "Ansible" {
    It "Ansible" {
        "ansible --version" | Should -ReturnZeroExitCode
    }
}

Describe "Bazel" {
    It "<ToolName>" -TestCases @(
        @{ ToolName = "bazel" }
        @{ ToolName = "bazelisk" }
    ) {
        "$ToolName --version"| Should -ReturnZeroExitCode
    }
}

Describe "clang" {
    [array]$testCases = (Get-ToolsetContent).clang.Versions | ForEach-Object { @{ClangVersion = $_} }

    It "clang <ClangVersion>" -TestCases $testCases {
        param (
            [string] $ClangVersion
        )

        "clang-$ClangVersion --version" | Should -ReturnZeroExitCode
        "clang++-$ClangVersion --version" | Should -ReturnZeroExitCode
    }   
}

Describe "Cmake" {
    It "cmake" {
        "cmake --version" | Should -ReturnZeroExitCode
    }
}

Describe "erlang" {
    $testCases = @("erl", "erlc", "rebar3") | ForEach-Object { @{ErlangCommand = $_} }

    It "erlang <ErlangCommand>" -TestCases $testCases {
        param (
            [string] $ErlangCommand
        )

        "$ErlangCommand -v" | Should -ReturnZeroExitCode
    }   
}

Describe "gcc" {
    [array]$testCases = (Get-ToolsetContent).gcc.Versions | ForEach-Object { @{GccVersion = $_} }

    It "gcc <GccVersion>" -TestCases $testCases {
        param (
            [string] $GccVersion
        )

        "$GccVersion --version" | Should -ReturnZeroExitCode
    }
}

Describe "gfortran" {
    [array]$testCases = (Get-ToolsetContent).gfortran.Versions | ForEach-Object { @{GfortranVersion = $_} }

    It "gfortran <GfortranVersion>" -TestCases $testCases {
        param (
            [string] $GfortranVersion
        )

        "$GfortranVersion --version" | Should -ReturnZeroExitCode
    }
}