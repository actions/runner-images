$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$devEnvPath = "$vsInstallRoot\Common7\IDE\devenv.exe"

# Initialize Visual Studio Experimental Instance
# The Out-Null cmdlet is required to ensure PowerShell waits until the '/ResetSettings' command fully completes.
& "$devEnvPath" /RootSuffix Exp /ResetSettings General.vssettings /Command File.Exit | Out-Null

cmd.exe /c "`"$devEnvPath`" /updateconfiguration"

#
# https://github.com/actions/runner-images/issues/5301
#
$warmup_vdproj = $(Join-Path $PSScriptRoot 'warmup.vdproj')
& "$devEnvPath" $warmup_vdproj /build Release | Out-Null
