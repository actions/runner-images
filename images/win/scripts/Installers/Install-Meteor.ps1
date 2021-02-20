################################################################################
##  File:  Install-Meteor.ps1
##  Desc:  Install Meteor
################################################################################

Choco-Install -PackageName meteor

# Copy meteor out of installing user's homedir into a general location
# $meteorpath = "C:\meteor"
# Copy-Item $env:LOCALAPPDATA\.meteor $meteorpath -Recurse

$meteorpath = $env:LOCALAPPDATA\.meteor

# Set perms on the meteor install path for everyone
$Acl = Get-ACL $meteorpath
$AccessRule= New-Object System.Security.AccessControl.FileSystemAccessRule("everyone","FullControl","ContainerInherit,Objectinherit","none","Allow")
$Acl.AddAccessRule($AccessRule)
Set-Acl $meteorpath $Acl

# Add the new Meteor installation into the PATH for all users. 
$OldPath = Get-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name "Path"
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\Session Manager\Environment" -Name "Path" -Value "$OldPath;$meteorpath"

# Prefetch the recent Meteor releases
# meteor update --release 2.0
# meteor update --release 1.21.12
# meteor update --release 1.11
# meteor update --release 1.10.3
# meteor update --release 1.10.2
# meteor update --release 1.10.1
# meteor update --release 1.9.3
# meteor update --release 1.9.2
# meteor update --release 1.9.1
# meteor update --release 1.9
# meteor update --release 1.8.3
# meteor update --release 1.8.2
# meteor update --release 1.8.1
# meteor update --release 1.8.0