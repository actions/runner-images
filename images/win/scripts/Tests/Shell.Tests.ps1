Describe "Shell" {
    $IsWin16 = Test-IsWin16

    $shellTestCases = @(
        @{Name = "C:\shells\msysbash.exe"; Target = "C:\msys64\usr\bin\bash.exe"},
        @{Name = "C:\shells\msyssh.exe"; Target = "C:\msys64\usr\bin\sh.exe"},
        @{Name = "C:\shells\gitbash.exe"; Target = "$env:ProgramFiles\Git\bin\bash.exe"}
    )

    It "<Name> target to <Target>" -TestCases $shellTestCases {
        (Get-Item $Name).Target | Should -BeExactly $Target
    }

    It "C:\shells\wslbash.exe target to $env:SystemRoot\System32\bash.exe" -Skip:$IsWin16 {
        $Name = "C:\shells\wslbash.exe"
        $Target = "$env:SystemRoot\System32\bash.exe"
        (Get-Item $Name).Target | Should -BeExactly $Target
    }
}