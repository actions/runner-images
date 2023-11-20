################################################################################
##  File:  Install-AWSTools.ps1
##  Desc:  Install AWS tools: CLI, Session Manager Plugin, AWS SAM CLI
##  Supply chain security: AWS CLI - managed by package manager, Session Manager Plugin for the AWS CLI - missing, AWS SAM CLI - checksum validation
################################################################################

# Install AWS CLI
Install-ChocoPackage awscli

# Install Session Manager Plugin for the AWS CLI
Install-Binary `
  -Url "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/windows/SessionManagerPluginSetup.exe" `
  -Args ("/silent", "/install") `
  -ExpectedSignature "FF457E5732E98A9F156E657F8CC7C4432507C3BB"
$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\SessionManagerPlugin\bin"

# Install AWS SAM CLI
$packageName = "AWS_SAM_CLI_64_PY3.msi"
$packageUrl = "https://github.com/awslabs/aws-sam-cli/releases/latest/download/$packageName"
$externalHash = Get-HashFromGitHubReleaseBody -RepoOwner "awslabs" -RepoName "aws-sam-cli" -FileName $packageName
Install-Binary `
  -Url $packageUrl `
  -ExpectedSHA256Sum $externalHash

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "AWS"
