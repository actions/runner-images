################################################################################
##  File:  Install-Msys2.ps1
##  Desc:  Install Msys2 and 64-bit gcc, cmake, & llvm (32-bit commented out)
################################################################################

# References
# https://github.com/msys2/MINGW-packages/blob/master/azure-pipelines.yml
# https://packages.msys2.org/group/

$origPath = $env:PATH
$gitPath  = "$env:ProgramFiles\Git"

$msys2_release = "https://api.github.com/repos/msys2/msys2-installer/releases/latest"

$msys2Uri = ((Invoke-RestMethod $msys2_release).assets | Where-Object {
  $_.name -match "x86_64" -and $_.name.EndsWith("tar.xz") }).browser_download_url

$msys2File = "$env:TEMP\msys2.tar.xz"

# Download the latest msys2 x86_64
Write-Host "Starting msys2 download using $($msys2Uri.split('/')[-1])"
(New-Object System.Net.WebClient).DownloadFile($msys2Uri, $msys2File)
Write-Host "Finished download"

# nix style path for tar
$msys2FileU = "/$msys2File".replace(':', '').replace('\', '/')

# Git tar needs exe's from mingw64\bin
$env:PATH = "$gitPath\usr\bin;$gitPath\mingw64\bin;$origPath"

$tar = "$gitPath\usr\bin\tar.exe"

# extract tar.xz to C:\
Write-Host "Starting msys2 extraction from $msys2FileU"
&$tar -xJf $msys2FileU -C /c/
Remove-Item $msys2File
Write-Host "Finished extraction"

# Add msys2 bin tools folders to PATH temporary
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"

Write-Host "bash pacman-key --init"
bash.exe -c "pacman-key --init 2>&1"

Write-Host "bash pacman-key --populate msys2"
bash.exe -c "pacman-key --populate msys2 2>&1"

Write-Host "pacman -Sy --noconfirm --needed pacman"
pacman -Sy --noconfirm --needed pacman
pacman -Su --noconfirm

# Force stop gpg-agent to continue installation
Get-Process gpg-agent -ErrorAction SilentlyContinue | Stop-Process -Force

Write-Host "pacman --noconfirm -Syyuu"
pacman.exe -Syyuu --noconfirm
pacman.exe -Syuu --noconfirm

Write-Host "Install msys2 packages"
pacman.exe -S --noconfirm --needed --noprogressbar base-devel compression

Write-Host "Remove p7zip/7z package due to conflicts"
pacman.exe -R --noconfirm --noprogressbar p7zip

# mingw package list
$tools = "___clang ___cmake ___llvm  ___toolchain ___ragel"

# install mingw64 packages
Write-Host "Install mingw64 packages"
$pre = "mingw-w64-x86_64-"
pacman.exe -S --noconfirm --needed --noprogressbar $tools.replace('___', $pre).split(' ')

# install mingw32 packages
Write-Host "Install mingw32 packages"
$pre = "mingw-w64-i686-"
pacman.exe -S --noconfirm --needed --noprogressbar $tools.replace('___', $pre).split(' ')

# clean all packages to decrease image size
Write-Host "Clean packages"
pacman.exe -Scc --noconfirm

Write-Host "Installed mingw64 packages"
pacman.exe -Qs --noconfirm mingw-w64-x86_64-

Write-Host "Installed mingw32 packages"
pacman.exe -Qs --noconfirm mingw-w64-i686-

Write-Host "Installed msys2 packages"
pacman.exe -Qs --noconfirm

Write-Host "MSYS2 installation completed"

exit 0