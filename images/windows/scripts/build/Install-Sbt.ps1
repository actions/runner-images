################################################################################
##  File:  Install-Sbt.ps1
##  Desc:  Install sbt for Windows
################################################################################

# Install the latest version of sbt.
# See https://chocolatey.org/packages/sbt
# The version is pinned due to issue with sbt latest version
# See https://github.com/sbt/sbt/issues/8077
Install-ChocoPackage sbt -ArgumentList "--version", "1.10.10

$env:SBT_HOME="${env:ProgramFiles(x86)}\sbt"

# Add sbt binaries to the path
Add-MachinePathItem "$env:SBT_HOME\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Sbt"
