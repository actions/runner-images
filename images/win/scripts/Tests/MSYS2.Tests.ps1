$toolsetContent = (Get-ToolsetContent).MsysPackages
$archs = $toolsetContent.mingw.arch

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
        @{ ToolName = "tar.exe" }
        @{ ToolName = "make.exe" }
    )

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

foreach ($arch in $archs) {
    Describe "$arch arch packages" {
        $archPackages = $toolsetContent.mingw | Where-Object { $_.arch -eq $arch }
        $tools = $archPackages.runtime_packages.name

        if ($arch -eq "mingw-w64-i686")
        {
            $ExecDir = "C:\msys64\mingw32\bin"
        }
        else
        {
            $ExecDir = "C:\msys64\mingw64\bin"
        }
        
        foreach ($tool in $tools) {
            Context "$tool package"{
                $executables = ($archPackages.runtime_packages | Where-Object { $_.name -eq $tool }).executables | ForEach-Object {
                    @{
                        ExecName = $_
                        ExecDir = $ExecDir
                    }
                }

                BeforeEach {
                    $env:PATH = "$ExecDir;$env:PATH"
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