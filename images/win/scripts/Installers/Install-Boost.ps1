################################################################################
##  File:  Set-BoostRoot.ps1
##  Team:  CI-Build
##  Desc:  Install boost using tool cache
################################################################################

Import-Module -Name ImageHelpers

$SoftwareName = "Boost"
$BoostDirectory = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath $SoftwareName
$BoostVersions = (Get-ToolsByName -SoftwareName $SoftwareName).Versions | Foreach-Object {"{0}.0" -f $_}

foreach($BoostVersion in $BoostVersions)
{
    $BoostInstallationDir = Join-Path -Path $BoostDirectory -ChildPath $BoostVersion

    $EnvBoostPath = "BOOST_ROOT_{0}" -f ($BoostVersion.Replace('.', '_'))
    setx $EnvBoostPath $BoostInstallationDir /M | Out-Null
}
