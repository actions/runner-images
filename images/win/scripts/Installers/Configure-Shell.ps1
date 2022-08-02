# Create shells folder
$shellPath = "C:\shells"
New-Item -Path $shellPath -ItemType Directory | Out-Null

# add a wrapper for C:\msys64\usr\bin\bash.exe
@'
@echo off
setlocal
IF NOT DEFINED MSYS2_PATH_TYPE set MSYS2_PATH_TYPE=strict
IF NOT DEFINED MSYSTEM set MSYSTEM=mingw64
set CHERE_INVOKING=1
C:\msys64\usr\bin\bash.exe -leo pipefail %*
'@ | Out-File -FilePath "$shellPath\msys2bash.cmd" -Encoding ascii

# gitbash <--> C:\Program Files\Git\bin\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\gitbash.exe" -Target "$env:ProgramFiles\Git\bin\bash.exe" | Out-Null

# wslbash <--> C:\Windows\System32\bash.exe
New-Item -ItemType SymbolicLink -Path "$shellPath\wslbash.exe" -Target "$env:SystemRoot\System32\bash.exe" | Out-Null
