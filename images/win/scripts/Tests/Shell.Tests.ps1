Describe "Shell" {
    $shellTestCases = @(
        @{Name = "C:\shells\gitbash.exe"; Target = "$env:ProgramFiles\Git\bin\bash.exe"},
        @{Name = "C:\shells\msys2bash.cmd"; Target = $null}
    )
    if (Test-IsWin19) {
        $shellTestCases += @{Name = "C:\shells\wslbash.exe"; Target = "$env:SystemRoot\System32\bash.exe"}
    }

    It "<Name> target to <Target>" -TestCases $shellTestCases {
        (Get-Item $Name).Target | Should -BeExactly $Target
    }
}
