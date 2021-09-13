################################################################################
##  File:  Install-GDK.ps1
##  Desc:  Install Microsoft Game Developement Kit
################################################################################

#Cloning Microsoft GDK
$repoFolder = "GDK"
git clone https://github.com/microsoft/GDK.git $repoFolder

#Install GDK
$GDKInstaller = "C:\$($repoFolder)\pgdk.exe"
& $GDKInstaller /quiet /norestart