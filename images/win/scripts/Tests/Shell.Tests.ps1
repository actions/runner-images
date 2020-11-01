Describe "Shell" {
    $shellTestCases = @(
        @{Name = "C:\shells\bash.exe"; Target = "C:\msys64\bin\bash.exe"},
        @{Name = "C:\shells\sh.exe"; Target = "C:\msys64\bin\sh.exe"},
        @{Name = "C:\shells\gitbash.exe"; Target = "$env:ProgramFiles\Git\bin\bash.exe"},
        @{Name = "C:\shells\msysbash.exe"; Target = "C:\msys64\usr\bin\bash.exe"}
    )

    $pathTestCases = @(
        @{Path = "C:\shells"},
        @{Path = "C:\msys64\mingw64\bin"},
        @{Path = "C:\msys64\usr\bin"}
    )

    $IsWin16 = Test-IsWin16

    It "Default bash.exe from MSYS2" {
        (Get-Command bash).Path | Should -BeExactly "C:\shells\bash.exe"
    }

    It "Default sh.exe from MSYS2" {
        (Get-Command sh).Path | Should -BeExactly "C:\shells\sh.exe"
    }

    It "Folder C:\shells exists" {
        "C:\shells" | Should -Exist
    }

    It "C:\Windows\System32 before C:\msys64\mingw64\bin and C:\msys64\usr\bin" {
        $path = $env:Path.Split(";").ToLower()
        $indexOfSystem32 = $path.IndexOf("c:\windows\system32")

        $path.IndexOf("c:\msys64\mingw64\bin") | Should -BeGreaterThan $indexOfSystem32
        $path.IndexOf("c:\msys64\usr\bin") | Should -BeGreaterThan $indexOfSystem32
    }

    It "C:\shells\winbash.exe target to $env:SystemRoot\System32\bash.exe" -Skip:$IsWin16 {
        $Name = "C:\shells\winbash.exe"
        $Target = "$env:SystemRoot\System32\bash.exe"
        (Get-Item $Name).Target | Should -BeExactly $Target
    }

    It "<Name> target to <Target>" -TestCases $shellTestCases {
        (Get-Item $Name).Target | Should -BeExactly $Target
    }

    It "<Path> is in PATH" -TestCases $pathTestCases {
        $env:Path.Split(";") | Should -Contain $Path
    }
}