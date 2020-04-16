####################################################################################
##  File:  Install-MongoDB.ps1
##  Desc:  Install MongoDB
####################################################################################

choco install mongodb

Add-MachinePathItem "$($env:SystemDrive)\Program Files\MongoDB\Server\4.2\bin"
