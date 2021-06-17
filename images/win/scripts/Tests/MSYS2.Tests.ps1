$toolsetContent = (Get-ToolsetContent).MsysPackages
$archs = $toolsetContent.mingw.arch

Describe "MSYS2 packages" {
    BeforeAll {
        $msys2Dir = "C:\msys64\usr\bin"
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
        $env:PATH = "$msys2Dir;$env:PATH"
        (Get-Command "$ToolName").Source | Should -BeLike "$msys2Dir*"
    }

    It "<ToolName> is avaialable" -TestCases $TestCases {
        "$ToolName" | Should -ReturnZeroExitCodeWithParam
    }
}

foreach ($arch in $archs) {
    Describe "$arch arch packages" {
        $archPackages = $toolsetContent.mingw | Where-Object { $_.arch -eq $arch }
        $tools = $archPackages.runtime_packages.name

        foreach ($tool in $tools) {
            Context "$tool package"{
                if ($arch -eq "mingw-w64-i686")
                {
                    $ExecDir = "C:\msys64\mingw32\bin"
                }
                else
                {
                    $ExecDir = "C:\msys64\mingw64\bin"
                }

                $executables = ($archPackages.runtime_packages | Where-Object { $_.name -eq $tool }).executables | ForEach-Object {
                    @{
                        ExecName = $_
                        ExecDir = $ExecDir
                    }
                }

                It "<ExecName> is installed in <ExecDir>" -TestCases $executables {
                    $env:PATH = "$ExecDir;$env:PATH"
                    (Get-Command "$ExecName").Source | Should -BeLike "$ExecDir*"
                }

                It "<ExecName> is available" -TestCases $executables {
                    $env:PATH = "$ExecDir;$env:PATH"
                    "$ExecName" | Should -ReturnZeroExitCodeWithParam
                }
            }
        }
    }
}