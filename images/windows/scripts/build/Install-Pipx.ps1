################################################################################
##  File:  Install-Pipx.ps1
##  Desc:  Install pipx and pipx packages
################################################################################

Write-Host "Installing pipx..."
$env:PIPX_BIN_DIR = "${env:ProgramFiles(x86)}\pipx_bin"
$env:PIPX_HOME = "${env:ProgramFiles(x86)}\pipx"

pip install pipx

Add-MachinePathItem "${env:PIPX_BIN_DIR}"
[System.Environment]::SetEnvironmentVariable("PIPX_BIN_DIR", $env:PIPX_BIN_DIR, "Machine")
[System.Environment]::SetEnvironmentVariable("PIPX_HOME", $env:PIPX_HOME, "Machine")

Invoke-PesterTests -TestFile "Tools" -TestName "Pipx"

Write-Host "Installing pipx packages..."

$pipxToolset = (Get-ToolsetContent).pipx
foreach ($tool in $pipxToolset) {
  if ($tool.python) {
    $pythonPath = (Get-Item -Path "${env:AGENT_TOOLSDIRECTORY}\Python\${tool.python}.*\x64\python-${tool.python}*").FullName
    Write-Host "Install ${tool.package} into python ${tool.python}"
    pipx install $tool.package --python $pythonPath
  } else {
    Write-Host "Install ${tool.package} into default python"
    pipx install $tool.package
  }
}

Invoke-PesterTests -TestFile "PipxPackages"
