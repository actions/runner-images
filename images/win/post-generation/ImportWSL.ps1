# Import registry WSL settings
$regFile = "C:\WSLUbuntu\wsl.reg"
if (Test-Path $regFile) {
    cmd /c "reg import $regFile 2>&1"
}