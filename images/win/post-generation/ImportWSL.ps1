# Import registry WSL settings
$regFile = "C:\WSLUbuntu\wsl.reg"
if (Test-Path $regFile) {
    reg import $regFile
}