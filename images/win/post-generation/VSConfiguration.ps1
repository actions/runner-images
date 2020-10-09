$vsInstallRoot = Get-VisualStudioPath
$devEnvPath = "$vsInstallRoot\Common7\IDE\devenv.exe"

cmd.exe /c "`"$devEnvPath`" /updateconfiguration"

# Step to avoid initial delay for choco scripts
choco upgrade chocolatey