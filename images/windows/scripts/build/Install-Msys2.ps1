################################################################################
##  File:  Install-Msys2.ps1
##  Desc:  Install Msys2 and 64 & 32 bit gcc, cmake, & llvm
################################################################################

# References
# https://github.com/msys2/MINGW-packages/blob/master/azure-pipelines.yml
# https://packages.msys2.org/group/

$logPrefix = "`n" + ("-" * 40) + "`n---"
$origPath = $env:PATH

function Install-Msys2 {
    # We can't use Resolve-GithubReleaseAssetUrl function here
    # because msys2-installer releases don't have a consistent versioning scheme

    $assets = (Invoke-RestMethod -Uri "https://api.github.com/repos/msys2/msys2-installer/releases/latest").assets
    $downloadUri = ($assets | Where-Object { $_.name -match "^msys2-x86_64" -and $_.name.EndsWith(".exe") }).browser_download_url
    $installerName = Split-Path $downloadUri -Leaf
  
    # Download the latest msys2 x86_64, filename includes release date
    Write-Host "Download msys2 installer $installerName"
    $installerPath = Invoke-DownloadWithRetry $downloadUri

    #region Supply chain security - MSYS2
    $externalHash = Get-ChecksumFromUrl -Type "SHA256" `
        -Url ($downloadUri -replace $installerName, "msys2-checksums.txt") `
        -FileName $installerName
    Test-FileChecksum $installerPath -ExpectedSHA256Sum $externalHash
    #endregion

    Write-Host "Starting msys2 installation"
    & $installerPath in --confirm-command --accept-messages --root C:/msys64
    if ($LastExitCode -ne 0) {
        throw "MSYS2 installation failed with exit code $LastExitCode"
    }
    Remove-Item $installerPath
}

function Install-Msys2Packages {
    param (
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [string[]]$Packages
    )

    if (-not $Packages) {
        return
    }

    Write-Host "$logPrefix Install msys2 packages"
    pacman.exe -S --noconfirm --needed --noprogressbar $Packages
    if ($LastExitCode -ne 0) {
        throw "MSYS2 packages installation failed with exit code $LastExitCode"
    }
    taskkill /f /fi "MODULES eq msys-2.0.dll"

    Write-Host "$logPrefix Remove p7zip/7z package due to conflicts"
    pacman.exe -R --noconfirm --noprogressbar p7zip
    if ($LastExitCode -ne 0) {
        throw "Removal of p7zip/7z package failed with exit code $LastExitCode"
    }
}

function Install-MingwPackages {
    param (
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [object[]] $Packages
    )

    if (-not $Packages) {
        return
    }

    Write-Host "$logPrefix Install mingw packages"
    $archs = $Packages.arch

    foreach ($arch in $archs) {
        Write-Host "Installing $arch packages"
        $archPackages = $toolsetContent.mingw | Where-Object { $_.arch -eq $arch }
        $runtimePackages = $archPackages.runtime_packages.name | ForEach-Object { "${arch}-$_" }
        $additionalPackages = $archPackages.additional_packages | ForEach-Object { "${arch}-$_" }
        $packagesToInstall = $runtimePackages + $additionalPackages
        Write-Host "The following packages will be installed: $packagesToInstall"
        pacman.exe -S --noconfirm --needed --noprogressbar $packagesToInstall
        if ($LastExitCode -ne 0) {
            throw "Installation of $arch packages failed with exit code $LastExitCode"
        }
    }

    # clean all packages to decrease image size
    Write-Host "$logPrefix Clean packages"
    pacman.exe -Scc --noconfirm
    if ($LastExitCode -ne 0) {
        throw "Cleaning of packages failed with exit code $LastExitCode"
    }

    $pkgs = pacman.exe -Q
    if ($LastExitCode -ne 0) {
        throw "Listing of packages failed with exit code $LastExitCode"
    }

    foreach ($arch in $archs) {
        Write-Host "$logPrefix Installed $arch packages"
        $pkgs | Select-String -Pattern "^${arch}-"
    }
}

Install-Msys2

# Add msys2 bin tools folders to PATH temporary
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"

Write-Host "$logPrefix pacman --noconfirm -Syyuu"
pacman.exe -Syyuu --noconfirm
if ($LastExitCode -ne 0) {
    throw "Updating of packages failed with exit code $LastExitCode"
}
taskkill /f /fi "MODULES eq msys-2.0.dll"

Write-Host "$logPrefix pacman --noconfirm -Syuu (2nd pass)"
pacman.exe -Syuu --noconfirm
if ($LastExitCode -ne 0) {
    throw "Second pass updating of packages failed with exit code $LastExitCode"
}
taskkill /f /fi "MODULES eq msys-2.0.dll"

$toolsetContent = (Get-ToolsetContent).MsysPackages
Install-Msys2Packages -Packages $toolsetContent.msys2
Install-MingwPackages -Packages $toolsetContent.mingw

$env:PATH = $origPath
Write-Host "`nMSYS2 installation completed"

Invoke-PesterTests -TestFile "MSYS2"
