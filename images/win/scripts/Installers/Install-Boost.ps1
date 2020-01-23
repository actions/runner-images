################################################################################
##  File:  Set-BoostRoot.ps1
##  Team:  CI-Build
##  Desc:  Install boost using tool cache
################################################################################

$BoostDirectory = Join-Path -Path $env:AGENT_TOOLSDIRECTORY -ChildPath "Boost"
$BoostVersions = $env:BOOST_VERSIONS.split(',')
$BoostDefault = $env:BOOST_DEFAULT

foreach($BoostVersion in $BoostVersions)
{
    $BoostInstallationDir = Join-Path -Path $BoostDirectory -ChildPath $BoostVersion

    $EnvBoostPath = "BOOST_ROOT_{0}" -f ($BoostVersion.Replace('.', '_'))
    setx $EnvBoostPath $BoostInstallationDir /M | Out-Null

    if ($BoostVersion -eq $BoostDefault)
    {
        Write-Host "Adding Boost $BoostVersion to the path..."
        # Add the Boost binaries to the path
        Add-MachinePathItem $BoostInstallationDir | Out-Null
        # Set the BOOSTROOT environment variable
        setx BOOST_ROOT $BoostInstallationDir /M | Out-Null
    }
}
