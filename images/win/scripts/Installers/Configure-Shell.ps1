# Create shells folder
$shellPath = "C:\Shells"
New-Item -Path $shellPath -ItemType Directory | Out-Null

# sh and bash <--> C:\msys64\usr\bin\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\msysbash.exe" -Target "C:\msys64\usr\bin\bash.exe" | Out-Null
New-Item -ItemType SymbolicLink -Path "$shellPath\msyssh.exe" -Target "C:\msys64\usr\bin\sh.exe" | Out-Null

# gitbash <--> C:\Program Files\Git\bin\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\gitbash.exe" -Target "$env:ProgramFiles\Git\bin\bash.exe" | Out-Null

# WSL is available on Windows Server 2019
if (Test-IsWin19)
{
    # wslbash <--> C:\Windows\System32\bash.exe
    New-Item -ItemType SymbolicLink -Path "$shellPath\wslbash.exe" -Target "$env:SystemRoot\System32\bash.exe" | Out-Null
}
