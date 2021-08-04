$vsInstallRoot = (Get-VisualStudioInstance).InstallationPath
$devEnvPath = "$vsInstallRoot\Common7\IDE\devenv.exe"

cmd.exe /c "`"$devEnvPath`" /updateconfiguration"