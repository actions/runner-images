################################################################################
##  File:  Validate-AzureCosmosDbEmulator.ps1
##  Desc:  Validate Azure CosmosDb Emulator installation.
################################################################################

$SoftwareName = 'Azure CosmosDb Emulator'
$regKey = gci HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | gp | ? { $_.DisplayName -eq 'Azure Cosmos DB Emulator' }

if ($regKey -eq $null)
{
    Write-Host "The $regKey registry key is not set"
    exit 1
}
else
{
    Write-Host "The $regKey registry key is set"
}

$installDir = $regKey.InstallLocation
if ($installDir -eq $null)
{
    Write-Host "The $SoftwareName installation directory registry value is not set"
    exit 1
}
else
{
    Write-Host "The $SoftwareName installation directory registry value is set to: $installDir"
}

$exeFilePath = Join-Path $installDir 'CosmosDB.Emulator.exe'
if (!(Test-Path $exeFilePath))
{
    Write-Host "$SoftwareName is not installed"
    exit 1
}

$fileVersion = (Get-Item $exeFilePath).VersionInfo.FileVersion
Write-Host "$SoftwareName is successfully installed: $fileVersion"
