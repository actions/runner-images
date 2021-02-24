################################################################################
##  File:  Install-Meteor.ps1
##  Desc:  Install Meteor
################################################################################

Choco-Install -PackageName meteor

# Copy meteor out of installing user's homedir into a general location
$meteorpath = "C:\meteor"
Copy-Item "$env:LOCALAPPDATA\.meteor" $meteorpath -Recurse

# $meteorpath = "$env:LOCALAPPDATA\.meteor"

# Set perms on the meteor install path for everyone
$Acl = Get-ACL $meteorpath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $meteorpath $Acl

# Add the new Meteor installation into the PATH for all users. 
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;$meteorpath"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
