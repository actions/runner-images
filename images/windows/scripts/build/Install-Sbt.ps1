################################################################################
##  File:  Install-Sbt.ps1
##  Desc:  Install sbt for Windows
################################################################################

# Install sbt 1.x.
# sbt 2.x requires JDK 17 or above, while the default JDK on Windows Server 2022 is JDK 8.
# See https://github.com/actions/runner-images/issues/14236
# See https://chocolatey.org/packages/sbt
Install-ChocoPackage sbt -Version "1.12.12"

$env:SBT_HOME="${env:ProgramFiles(x86)}\sbt"

# Add sbt binaries to the path
Add-MachinePathItem "$env:SBT_HOME\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Sbt"
