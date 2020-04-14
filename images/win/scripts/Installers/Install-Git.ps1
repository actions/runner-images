################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################

Import-Module -Name ImageHelpers

# Install the latest version of Git which is bundled with Git LFS.
# See https://chocolatey.org/packages/git
Install-Choco -PackageName git -ArgumentList '--package-parameters="/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration"'
Install-Choco -PackageName hub

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

Add-MachinePathItem "C:\Program Files\Git\bin"

exit 0
