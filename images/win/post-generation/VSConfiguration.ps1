$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$devEnvPath = "$vsInstallRoot\Common7\IDE\devenv.exe"

# Initialize Visual Studio Experimental Instance
# The Out-Null cmdlet is required to ensure PowerShell waits until the '/ResetSettings' command fully completes.
& "$devEnvPath" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit | Out-Null

cmd.exe /c "`"$devEnvPath`" /updateconfiguration"