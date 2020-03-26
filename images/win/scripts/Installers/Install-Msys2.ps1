################################################################################
##  File:  Install-Msys2.ps1
##  Desc:  Install Msys2 and 64-bit gcc, cmake, & llvm (32-bit commented out)
################################################################################

# References
# https://github.com/msys2/MINGW-packages/blob/master/azure-pipelines.yml
# https://packages.msys2.org/group/

$origPath = $env:PATH
$gitPath  = "$env:ProgramFiles\Git"

# get info from https://sourceforge.net/projects/msys2/files/Base/x86_64/
$msys2Uri  = "http://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20190524.tar.xz"
$msys2File = "$env:TEMP\msys2.tar.xz"

# Download the latest msys2 x86_64
Write-Host "Starting msys2 download"
(New-Object System.Net.WebClient).DownloadFile($msys2Uri, $msys2File)
Write-Host "Finished download"

$msys2FileU = "/$msys2File".replace(':', '')

$tar = "$gitPath\usr\bin\tar.exe"

# extract tar.xz to C:\
Write-Host "Starting msys2 extraction"
&$tar -Jxf $msys2FileU -C /c/
Remove-Item $msys2File
Write-Host "Finished extraction"

# Add msys2 bin tools folders to PATH temporary
$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$origPath"

Write-Host "bash pacman-key --init"
bash.exe -c "pacman-key --init 2>&1"

Write-Host "bash pacman-key --populate msys2"
bash.exe -c "pacman-key --populate msys2 2>&1"

Write-Host "pacman --noconfirm -Syyuu"
pacman.exe -Syyuu --noconfirm
pacman.exe -Syuu --noconfirm

Write-Host "Install msys2 packages"
pacman.exe -S --noconfirm --needed --noprogressbar base-devel compression

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