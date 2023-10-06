################################################################################
##  File:  Warmup-User.ps1
##  Desc:  Performs user part of warm up and moves data to C:\Users\Default
################################################################################

#
# more: https://github.com/actions/runner-images-internal/issues/5320
#       https://github.com/actions/runner-images/issues/5301#issuecomment-1648292990
#

Write-Host "Warmup 'devenv.exe /updateconfiguration'"

$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$devEnvPath = "$vsInstallRoot\Common7\IDE\devenv.exe"

cmd.exe /c "`"$devEnvPath`" /updateconfiguration"

Copy-Item ${env:USERPROFILE}\AppData\Local\Microsoft\VisualStudio -Destination c:\users\default\AppData\Local\Microsoft\VisualStudio -Recurse

reg.exe load HKLM\DEFAULT c:\users\default\ntuser.dat
reg.exe copy HKCU\Software\Microsoft\VisualStudio HKLM\DEFAULT\Software\Microsoft\VisualStudio /s

# disable TSVNCache.exe
$registryKeyPath = 'HKCU:\Software\TortoiseSVN'
if (-not(Test-Path -Path $registryKeyPath)) {
    New-Item -Path $registryKeyPath -ItemType Directory -Force
}

New-ItemProperty -Path $RegistryKeyPath -Name CacheType -PropertyType DWORD -Value 0
reg.exe copy HKCU\Software\TortoiseSVN HKLM\DEFAULT\Software\TortoiseSVN /s


# warmup SQL LocalDB
# https://github.com/actions/runner-images/issues/8164

sqllocaldb create MSSQLLocalDB

$localDBInstance = Get-ChildItem -Path 'HKCU:\Software\Microsoft\Microsoft SQL Server\UserInstances'
$instanceName = ($localDBInstance.Name).Split('\').where({ $true },'Last')
$instancePath = 'HKCU:\Software\Microsoft\Microsoft SQL Server\UserInstances\' + $instanceName
$dataDirectory = (Get-ItemProperty -Path $instancePath -Name 'DataDirectory').DataDirectory
$localDBPath = 'C:\LocalDB'
New-Item -ItemType 'Directory' -Path $localDBPath
Move-Item -Path "$dataDirectory\*" -Destination $localDBPath
Set-ItemProperty -Path $instancePath -Name 'DataDirectory' -Value $localDBPath

reg.exe copy 'HKCU\Software\Microsoft\Microsoft SQL Server' 'HKLM\DEFAULT\Software\Microsoft\Microsoft SQL Server' /s

reg.exe unload HKLM\DEFAULT
Write-Host "Warmup-User.ps1 - completed"
