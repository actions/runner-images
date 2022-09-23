$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$devEnvPath = "$vsInstallRoot\Common7\IDE\devenv.exe"

# Initialize Visual Studio Experimental Instance
# The Out-Null cmdlet is required to ensure PowerShell waits until the '/ResetSettings' command fully completes.
# The temp/empty C# file is required to ensure VS MEF is fully initialized
Set-Content -Path "$env:TEMP\temp.cs" -Value "//"

& "$devEnvPath" "$env:TEMP\temp.cs" /RootSuffix Exp /NoSplash /ResetSettings General.vssettings /Command File.Exit | Out-Null
