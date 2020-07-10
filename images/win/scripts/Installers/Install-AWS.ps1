################################################################################
##  File:  Install-awscli.ps1
##  Desc:  Install awscli
################################################################################

Choco-Install -PackageName awscli

Invoke-PesterTests -TestFile "Tools" -TestName "AWS"

$sessionManagerName = "SessionManagerPluginSetup.exe"
$sessionManagerUrl = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/$sessionManagerName"
Install-Binary -Url $sessionManagerUrl -Name $sessionManagerName -ArgumentList ("/silent", "/install")
$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\SessionManagerPlugin\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "AWSSessionManagerPlugin"