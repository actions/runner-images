################################################################################
##  File:  Install-GDK.ps1
##  Desc:  Install Microsoft Game Developement Kit
################################################################################

#Cloning Microsoft GDK
$repoFolder = "C:\GDK"
git clone https://github.com/microsoft/GDK.git $repoFolder

#Install GDK
$GDKInstaller = "$($repoFolder)\pgdk.exe"
& $GDKInstaller /quiet /norestart