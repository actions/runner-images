################################################################################
##  File:  Install-AWS.ps1
##  Desc:  Install AWS tools(AWS CLI, Session Manager Plugin for the AWS CLI, AWS SAM CLI)
##  Supply chain security: AWS CLI - managed by package manager, Session Manager Plugin for the AWS CLI - missing, AWS SAM CLI - checksum validation
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
$packageName = "AWS_SAM_CLI_64_PY3.msi"
$packageUrl = "https://github.com/awslabs/aws-sam-cli/releases/latest/download/$packageName"
$packagePath = Start-DownloadWithRetry -Url $packageUrl -Name $packageName

#region Supply chain security - AWS SAM CLI
$fileHash = (Get-FileHash -Path $packagePath -Algorithm SHA256).Hash
$externalHash = Get-HashFromGitHubReleaseBody -RepoOwner "awslabs" -RepoName "aws-sam-cli" -FileName $packageName
Use-ChecksumComparison $fileHash $externalHash
#endregion

Install-Binary -FilePath $packagePath

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "AWS"
