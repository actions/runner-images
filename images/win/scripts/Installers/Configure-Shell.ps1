# Create shells folder
$shellPath = "C:\shells"
New-Item -Path $shellPath -ItemType Directory | Out-Null

# sh and bash <--> C:\msys64\usr\bin\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\bash.exe" -Target "C:\msys64\bin\bash.exe" | Out-Null
New-Item -ItemType SymbolicLink -Path "$shellPath\sh.exe" -Target "C:\msys64\bin\sh.exe" | Out-Null

# WSL is available on Windows Server 2019
if (Test-IsWin19)
{
    # winbash <--> C:\Windows\System32\bash.exe
    New-Item -ItemType SymbolicLink -Path "$shellPath\winbash.exe" -Target "$env:SystemRoot\System32\bash.exe" | Out-Null
}

# gitbash <--> C:\Program Files\Git\bin\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\gitbash.exe" -Target "$env:ProgramFiles\Git\bin\bash.exe" | Out-Null

# msysbash <--> C:\msys64\usr\bin\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\msysbash.exe" -Target "C:\msys64\usr\bin\bash.exe" | Out-Null

# Add shells to PATH
Add-MachinePathItem $shellPath