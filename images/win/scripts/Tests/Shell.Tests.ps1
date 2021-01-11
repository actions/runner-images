Describe "Shell" {
    $IsWin16 = Test-IsWin16

    $shellTestCases = @(
        @{Name = "C:\shells\gitbash.exe"; Target = "$env:ProgramFiles\Git\bin\bash.exe"}
    )

    It "<Name> target to <Target>" -TestCases $shellTestCases {
        (Get-Item $Name).Target | Should -BeExactly $Target
    }

    It "C:\shells\msys2bash.cmd exists" {
        "C:\shells\msys2bash.cmd" | Should -Exist
    }

    It "C:\shells\wslbash.exe target to $env:SystemRoot\System32\bash.exe" -Skip:$IsWin16 {
        $Name = "C:\shells\wslbash.exe"
        $Target = "$env:SystemRoot\System32\bash.exe"
        (Get-Item $Name).Target | Should -BeExactly $Target
    }
}