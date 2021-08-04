Describe "WSL" {
    It "C:\Windows\System32\bash.exe exists" {
        "C:\Windows\System32\bash.exe" | Should -Exist
    }

    It "The default user is set to root" {
        bash -c "whoami" | Should -Be root
    }

    It "Pipeline tee" {
        "Hello" | bash -c "tee" | Should -Be "Hello"
    }

    It "Run powershell in bash session" {
        bash -c "powershell.exe -Command '2+2'" | Should -Be 4
    }
}
