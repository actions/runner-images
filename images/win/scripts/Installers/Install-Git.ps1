################################################################################
##  File:  Install-Git.ps1
##  Desc:  Install Git for Windows
################################################################################

Import-Module -Name ImageHelpers

# Install the latest version of Git which is bundled with Git LFS.
# See https://chocolatey.org/packages/git
choco install git -y --package-parameters="/GitAndUnixToolsOnPath /WindowsTerminal /NoShellIntegration"

# Disable GCM machine-wide
[Environment]::SetEnvironmentVariable("GCM_INTERACTIVE", "Never", [System.EnvironmentVariableTarget]::Machine)

exit 0
