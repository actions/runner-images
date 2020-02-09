################################################################################
##  File:  Install-Julia.ps1
##  Desc:  Install Julia
################################################################################

Import-Module -Name ImageHelpers -Force
function Install-JuliaVersion
{
    Param
    (
        [String]$juliaVersion,
        [Switch]$addToDefaultPath
    )

    # Split versions.
    $juliaMajorVersion = $juliaVersion.split(".")[0] + "." + $juliaVersion.split(".")[1]

    # Download the Julia installer.
    Write-Host "Downloading Julia $juliaVersion..."
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -UseBasicParsing -Uri "https://julialang-s3.julialang.org/bin/winnt/x64/$juliaMajorVersion/julia-$juliaVersion-win64.exe" -OutFile "julia-$juliaVersion-win64.exe"

    # Install Julia.
    # The installer will change in Julia 1.4. For future-proofing, a version check is run.
    if ( $juliaMajorVersion -ge "1.4")
    {
        Start-Process -FilePath "julia-$juliaVersion-win64.exe" -ArgumentList "/SILENT /dir=C:\Julia" -NoNewWindow -Wait
    }
    else
    {
        Start-Process -FilePath "julia-$juliaVersion-win64.exe" -ArgumentList "/S /D=C:\Julia" -NoNewWindow -Wait
    }

    # Delete unnecessary files to conserve space.
    Write-Host "Deleting downloaded installer..."
    Remove-Item "julia-$juliaVersion-win64.exe"

    # Make this the default version of Julia?
    if ($addToDefaultPath)
    {
        Write-Host "Adding Julia $juliaVersion to the path..."
        # Add the Julia binaries to the path.
        Add-MachinePathItem "C:\Julia\Julia-$juliaVersion\bin" | Out-Null
    }

    # Done
    Write-Host "Done installing Julia $juliaVersion."
    return "C:\Julia\Julia-$juliaVersion"
}

# Install Julia
$juliaVersionsToInstall = $env:JULIA_VERSIONS.split(",")

foreach($julia in $juliaVersionsToInstall) {
    Write-Host "Installing Julia ${julia}"
    if($julia -eq $env:JULIA_DEFAULT) {
        $installDirectory = Install-JuliaVersion -juliaVersion $julia -addToDefaultPath
    } else {
        $installDirectory = Install-JuliaVersion -juliaVersion $julia
    }
    setx $envName "$installDirectory" /M
}
