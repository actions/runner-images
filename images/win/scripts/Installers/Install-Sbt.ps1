################################################################################
##  File:  Install-Sbt.ps1
##  Desc:  Install sbt for Windows
################################################################################
$ErrorActionPreference = "Stop"

Import-Module -Name ImageHelpers

# Install the latest version of sbt.
# See https://chocolatey.org/packages/sbt
choco install sbt -y

$env:SBT_HOME="${env:ProgramFiles(x86)}\sbt"

# Add sbt binaries to the path
Add-MachinePathItem "$env:SBT_HOME\bin"
$env:Path = Get-MachinePath

# Done
exit 0
