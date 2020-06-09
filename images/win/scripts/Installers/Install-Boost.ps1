################################################################################
##  File:  Set-BoostRoot.ps1
##  Team:  CI-Build
##  Desc:  Install boost using tool cache
################################################################################

Import-Module -Name ImageHelpers

$SoftwareName = "Boost"
$BoostDirectory = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $SoftwareName
$BoostVersions = (Get-ToolsetContent | Select-Object -ExpandProperty toolcache | Where-Object { $_.Name -eq "Boost"}).Versions

foreach($BoostVersion in $BoostVersions)
{
    $BoostInstallationDir = Join-Path -Path $BoostDirectory -ChildPath "$BoostVersion\X86_64"

    $EnvBoostPath = "BOOST_ROOT_{0}" -f ($BoostVersion.Replace('.', '_'))
    setx $EnvBoostPath $BoostInstallationDir /M | Out-Null
}
