################################################################################
##  File:  Install-Msys2.ps1
##  Desc:  Install Msys2 and 64 & 32 bit gcc, cmake, & llvm
################################################################################

# References
# https://github.com/msys2/MINGW-packages/blob/master/azure-pipelines.yml
# https://packages.msys2.org/group/

$dash = "-" * 40

$origPath = $env:PATH
$gitPath  = "$env:ProgramFiles\Git"

$msys2_release = "https://api.github.com/repos/msys2/msys2-installer/releases/latest"

$msys2Uri = ((Invoke-RestMethod $msys2_release).assets | Where-Object {
  $_.name -match "x86_64" -and $_.name.EndsWith("tar.xz") }).browser_download_url

# Download the latest msys2 x86_64, filename includes release date
Write-Host "Starting msys2 download using $($msys2Uri.split('/')[-1])"
$msys2File = Start-DownloadWithRetry -Url $msys2Uri
Write-Host "Finished download"

# nix style path for tar
$msys2FileU = "/$msys2File".replace(':', '').replace('\', '/')

# Git tar needs exe's from mingw64\bin
$env:PATH = "$gitPath\usr\bin;$gitPath\mingw64\bin;$origPath"

$tar = "$gitPath\usr\bin\tar.exe"

# extract tar.xz to C:\
Write-Host "Starting msys2 extraction"
&$tar -xJf $msys2FileU -C /c/
Remove-Item $msys2File
Write-Host "Finished extraction"

# Add msys2 bin tools folders to PATH temporary
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"

Write-Host "`n$dash bash pacman-key --init"
bash.exe -c "pacman-key --init 2>&1"

Write-Host "bash pacman-key --populate msys2"
bash.exe -c "pacman-key --populate msys2 2>&1"

Write-Host "`n$dash pacman --noconfirm -Syyuu"
pacman.exe -Syyuu --noconfirm
taskkill /f /fi "MODULES eq msys-2.0.dll"
Write-Host "`n$dash pacman --noconfirm -Syuu (2nd pass)"
pacman.exe -Syuu  --noconfirm
taskkill /f /fi "MODULES eq msys-2.0.dll"

$toolsetContent = (Get-ToolsetContent).MsysPackages

Write-Host "`n$dash Install msys2 packages"
$msys2Packages = $toolsetContent.msys2
pacman.exe -S --noconfirm --needed --noprogressbar $msys2Packages
taskkill /f /fi "MODULES eq msys-2.0.dll"

Write-Host "`n$dash Remove p7zip/7z package due to conflicts"
pacman.exe -R --noconfirm --noprogressbar p7zip

# install mingw packages
$archs = $toolsetContent.mingw.arch
foreach ($arch in $archs)
{
  Write-Host "Installing $arch packages"
  $archPackages = $toolsetContent.mingw | Where-Object { $_.arch -eq $arch }
  $runtimePackages = $archPackages.runtime_packages.name | ForEach-Object { "${arch}-$_" }
  $additionalPackages = $archPackages.additional_packages | ForEach-Object { "${arch}-$_" }
  $packagesToInstall = $runtimePackages + $additionalPackages
  Write-Host "The following packages will be installed: $packagesToInstall"
  pacman.exe -S --noconfirm --needed --noprogressbar $packagesToInstall
}

# clean all packages to decrease image size
Write-Host "`n$dash Clean packages"
pacman.exe -Scc --noconfirm

$pkgs = pacman.exe -Q

foreach ($arch in $archs)
{
  Write-Host "`n$dash Installed $arch packages"
  $pkgs | grep ^${arch}-
}

$env:PATH = $origPath
Write-Host "`nMSYS2 installation completed"

Invoke-PesterTests -TestFile "MSYS2"
