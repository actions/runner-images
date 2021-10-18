BeforeAll {
    $msys2Dir = "C:\msys64\usr\bin"
    $originalPath = $env:PATH
}

Describe "MSYS2 packages" {
    BeforeEach {
        $env:PATH = "$msys2Dir;$env:PATH"
    }

    It "msys2Dir exists" {
        $msys2Dir | Should -Exist
    }

    $TestCases = @(
        @{ ToolName = "bash.exe" }
    )

    if ((Test-IsWin16) -or (Test-IsWin19)) {
        $TestCases += @(
            @{ ToolName = "tar.exe" }
            @{ ToolName = "make.exe" }
        )
    }

    It "<ToolName> is installed in <msys2Dir>" -TestCases $TestCases {
        (Get-Command "$ToolName").Source | Should -BeLike "$msys2Dir*"
    }

    It "<ToolName> is avaialable" -TestCases $TestCases {
        "$ToolName" | Should -ReturnZeroExitCodeWithParam
    }

    AfterEach {
        $env:PATH = $originalPath
    }
}

$mingwTypes = (Get-ToolsetContent).MsysPackages.mingw
foreach ($mingwType in $mingwTypes) {
    Describe "$($mingwType.arch) packages" {
        $tools = $mingwType.runtime_packages
        $execDir = Join-Path "C:\msys64" $mingwType.exec_dir | Join-Path -ChildPath "bin"
        
        foreach ($tool in $tools) {
            Context "$($tool.name) package"{
                $executables = $tool.executables | ForEach-Object {
                    @{
                        ExecName = $_
                        ExecDir = $execDir
                    }
                }

                BeforeEach {
                    $env:PATH = "$execDir;$env:PATH"
                }

                It "<ExecName> is installed in <ExecDir>" -TestCases $executables {
                    (Get-Command "$ExecName").Source | Should -BeLike "$ExecDir*"
                }

                It "<ExecName> is available" -TestCases $executables {
                    "$ExecName" | Should -ReturnZeroExitCodeWithParam
                }

                AfterEach {
                    $env:PATH = $originalPath
                }
            }
        }
    }
}