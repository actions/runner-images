################################################################################
##  File:  Install-MSYS2.ps1
##  Desc:  Install MSYS2 and 64-bit gcc, cmake, & llvm (32-bit commented out)
################################################################################

# References
# https://github.com/msys2/MINGW-packages/blob/master/azure-pipelines.yml
# https://packages.msys2.org/group/

$dash = "—"
$wid = 80

$orig_path = $env:PATH
$git_path  = "C:\Program Files\Git"

# get info from https://sourceforge.net/projects/msys2/files/Base/x86_64/
$msy2_uri  = "http://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20190524.tar.xz"
$msy2_sha1 = "cfe5035b1b81b43469d16bfc23be8006b9a44455".ToUpper()

$msy2_file = "$env:AGENT_TEMPDIRECTORY/msys2.tar.xz".replace('\', '/')

# Download the latest msys2 x86_64
Write-Host Starting download
Invoke-WebRequest -UseBasicParsing -Uri $msy2_uri -OutFile $msy2_file
Write-Host Finished download

# check SHA1
$dl_sha1 = (Get-FileHash -Path $msy2_file -Algorithm SHA1).Hash

if ($dl_sha1 -ne $msy2_sha1) {
  Write-Host "SHA1 mismatch, exiting"
  exit 1
}

$msy2_file_u = "/$msy2_file".replace(':', '')

# git has tar.exe in usr/bin, but xz.exe is in mingw64/bin
$env:PATH = "$git_path\mingw64\bin;$orig_path"
$tar      = "$git_path\usr\bin\tar.exe"

# extract tar.xz to C:\
&$tar -Jxf $msy2_file_u -C /c/

Remove-Item $msy2_file

Write-Host Finished extraction

$env:PATH = "C:\msys64\mingw64\bin;C:\msys64\usr\bin;$orig_path"

$ErrorActionPreference = "Continue"

Write-Host " bash.exe -c `"pacman-key --init`"".PadLeft($wid, $dash)
bash.exe -c `"pacman-key --init`" 2> $null

Write-Host " bash.exe -c `"pacman-key --populate msys2`"".PadLeft($wid, $dash)
bash.exe -c `"pacman-key --populate msys2`" 2> $null

Write-Host " pacman --noconfirm -Syyuu".PadLeft($wid, $dash)
pacman.exe -Syyuu --noconfirm 2> $null

# install msys2 packages
Write-Host " Install msys2 packages".PadLeft($wid, $dash)
pacman.exe -S --noconfirm --needed --noprogressbar base-devel compression

# mingw package list
$tools = "___clang ___cmake ___llvm  ___toolchain ___ragel"

# install mingw64 packages
Write-Host " Install mingw64 packages".PadLeft($wid, $dash)
$pre = "mingw-w64-x86_64-"
pacman.exe -S --noconfirm --needed --noprogressbar $tools.replace('___', $pre).split(' ')

# install mingw32 packages
Write-Host " Install mingw32 packages".PadLeft($wid, $dash)
$pre = "mingw-w64-i686-"
pacman.exe -S --noconfirm --needed --noprogressbar $tools.replace('___', $pre).split(' ')

# clean all packages to decrease image size ?
Write-Host " Clean packages".PadLeft($wid, $dash)
pacman -Scc --noconfirm 

Write-Host
Write-Host " Installed mingw64 packages".PadLeft($wid, $dash)
pacman.exe -Qs mingw-w64-x86_64- | grep local/ | sed -r "s/local\/| \(.+\)$//g"

Write-Host
Write-Host " Installed mingw32 packages".PadLeft($wid, $dash)
pacman.exe -Qs mingw-w64-i686- | grep local/ | sed -r "s/local\/| \(.+\)$//g"

Write-Host
Write-Host " Installed msys2 packages".PadLeft($wid, $dash)
pacman.exe -Qs | grep local/ | grep -v mingw-w64 | sed -r "s/local\/| \(.+\)$//g"
