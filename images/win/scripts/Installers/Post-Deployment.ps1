# Create shells folder
$shellPath = "C:\shells"
$null = New-Item -Path $shellPath -ItemType Directory

# MSYS2 <--> C:\msys64\usr\bin\bash.exe
$null = New-Item -ItemType SymbolicLink -Path "$shellPath\msys2.exe" -Target "C:\msys64\usr\bin\bash.exe"

# sh and bash <--> C:\msys64\usr\bin\bash.exe
$null = New-Item -ItemType SymbolicLink -Path "$shellPath\bash.exe" -Target "C:\msys64\usr\bin\bash.exe"
$null = New-Item -ItemType SymbolicLink -Path "$shellPath\sh.exe" -Target "C:\msys64\usr\bin\sh.exe"

# winbash <--> C:\Windows\System32\bash.exe
$null = New-Item -ItemType SymbolicLink -Path "$shellPath\winbash.exe" -Target "$env:SystemRoot\System32\bash.exe"

# git4bash <--> C:\Program Files\Git\bin\bash.exe
$null = New-Item -ItemType SymbolicLink -Path "$shellPath\git4bash.exe" -Target "$env:ProgramFiles\Git\bin\bash.exe"

# Add shells to PATH
Add-MachinePathItem $shellPath