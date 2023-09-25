################################################################################
##  File:  Install-AWS.ps1
##  Desc:  Install AWS tools(AWS CLI, Session Manager Plugin for the AWS CLI, AWS SAM CLI)
################################################################################

# Install AWS CLI
Choco-Install -PackageName awscli

# Install Session Manager Plugin for the AWS CLI
$sessionManagerName = "SessionManagerPluginSetup.exe"
$sessionManagerUrl = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/$sessionManagerName"
$sessionManagerSignatureThumbprint = "FF457E5732E98A9F156E657F8CC7C4432507C3BB"
Install-Binary -Url $sessionManagerUrl -Name $sessionManagerName -ArgumentList ("/silent", "/install")  -ExpectedSignature $sessionManagerSignatureThumbprint
$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\SessionManagerPlugin\bin"

# Install AWS SAM CLI
$awsSamCliSignatureThumbprint = "F28DEBE58B2178C93427CD3D0F8B24CE128FA0D1"
Install-Binary -Url "https://github.com/awslabs/aws-sam-cli/releases/latest/download/AWS_SAM_CLI_64_PY3.msi" -Name "AWS_SAM_CLI_64_PY3.msi" -ExpectedSignature $awsSamCliSignatureThumbprint

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "AWS"
