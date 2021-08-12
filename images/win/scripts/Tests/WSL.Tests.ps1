Describe "WSL" -Skip:(-not (Test-IsWin22)) {
    It "C:\Windows\System32\bash.exe exists" {
        "C:\Windows\System32\bash.exe" | Should -Exist
    }

    It "The default user is set to root" {
        bash -c "whoami" | Should -Be root
    }

    It "Run powershell in bash session" {
        bash -c "powershell.exe -Command '2+2'" | Should -Be 4
    }
}
