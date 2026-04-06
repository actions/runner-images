Describe "Shell" {
    $shellTestCases = @(
        @{Name = "C:\shells\gitbash.exe"; Target = "$env:ProgramFiles\Git\bin\bash.exe"},
        $(if (-not (Test-IsWin11-Arm64)) { @{Name = "C:\shells\msys2bash.cmd"; Target = $null} }),
        @{Name = "C:\shells\wslbash.exe"; Target = "$env:SystemRoot\System32\bash.exe"}
    ) | Where-Object { $_ }

    It "<Name> target to <Target>" -TestCases $shellTestCases {
        (Get-Item $Name).Target | Should -BeExactly $Target
    }
}
