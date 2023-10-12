Write-Host "Set TLS1.2"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

Write-Host "Install chocolatey"
$chocoExePath = 'C:\ProgramData\Chocolatey\bin'

# Add to system PATH
$systemPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::Machine)
$systemPath += ';' + $chocoExePath
[Environment]::SetEnvironmentVariable("PATH", $systemPath, [System.EnvironmentVariableTarget]::Machine)

# Update local process' path
$userPath = [Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
if ($userPath) {
    $env:Path = $systemPath + ";" + $userPath
} else {
    $env:Path = $systemPath
}

# Verify and run choco installer
$signatureThumbprint = "83AC7D88C66CB8680BCE802E0F0F5C179722764B"
$InstallScriptPath = Start-DownloadWithRetry -Url 'https://chocolatey.org/install.ps1'
Test-FileSignature -FilePath $InstallScriptPath -ExpectedThumbprint $signatureThumbprint
Invoke-Expression $InstallScriptPath

# Turn off confirmation
choco feature enable -n allowGlobalConfirmation

# Initialize environmental variable ChocolateyToolsLocation by invoking choco Get-ToolsLocation function
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force
Get-ToolsLocation
