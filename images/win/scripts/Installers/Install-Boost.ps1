################################################################################
##  File:  Install-Boost.ps1
##  Desc:  Install boost using tool cache
################################################################################

$ToolCache = 'C:\hostedtoolcache\windows\boost'
$BoostDirectory = Join-Path -Path $env:ProgramFiles -ChildPath "Boost"
$BoostVersionsToInstall = $env:BOOST_VERSIONS.split(',')
$BoostDefault = $env:BOOST_DEFAULT

foreach($BoostVersion in $BoostVersionsToInstall)
{
    $ZipName = Join-Path -Path $ToolCache -ChildPath "boost_${BoostVersion}_msvc-14.1.zip"

    if (-Not (Test-Path $ZipName))
    {
        Write-Host "$ZipName not found"
        exit 1
    }
    
    Write-Host "Expanding $ZipName"

    $BoostInstallationDir = Join-Path -Path $BoostDirectory -ChildPath $BoostVersion
    # Expand-Archive slower for 70% than 7z
    & "$env:ProgramFiles\7-Zip\7z.exe" x $ZipName -o"$BoostDirectory" -y

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

# Removing boost cache folder
Write-Host "Removing boost cache folder"
if (Test-Path $ToolCache)
{
    Remove-Item -Path $ToolCache -Force -Recurse
}
