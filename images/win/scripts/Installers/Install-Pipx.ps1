#   Set custom directorys for pipx
$env:PIPX_BIN_DIR = "${env:ProgramFiles(x86)}\pipx_bin"
$env:PIPX_HOME = "${env:ProgramFiles(x86)}\pipx"

#   Install pipx
pip install pipx

#   Set environment variables
Add-MachinePathItem "${env:PIPX_BIN_DIR}"
Set-SystemVariable -SystemVariable PIPX_BIN_DIR -Value $env:PIPX_BIN_DIR
Set-SystemVariable -SystemVariable PIPX_HOME -Value $env:PIPX_HOME

#   Test pipx
Invoke-PesterTests -TestFile "Tools" -TestName "Pipx"