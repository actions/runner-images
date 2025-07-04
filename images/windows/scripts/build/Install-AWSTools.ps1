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
    -InstallArgs ("/silent", "/install") `
    -ExpectedSubject 'CN="Amazon Web Services, Inc.", OU=AWS Systems Manager, O="Amazon Web Services, Inc.", L=Seattle, S=Washington, C=US, SERIALNUMBER=4152954, OID.2.5.4.15=Private Organization, OID.1.3.6.1.4.1.311.60.2.1.2=Delaware, OID.1.3.6.1.4.1.311.60.2.1.3=US'
$env:Path = $env:Path + ";$env:ProgramFiles\Amazon\SessionManagerPlugin\bin"

# Install AWS SAM CLI
$downloadUrl = Resolve-GithubReleaseAssetUrl `
    -Repo "awslabs/aws-sam-cli" `
    -Version "latest" `
    -UrlMatchPattern "AWS_SAM_CLI_64_PY3.msi"
$externalHash = Get-ChecksumFromGithubRelease `
    -Repo "awslabs/aws-sam-cli" `
    -Version "latest" `
    -FileName (Split-Path $downloadUrl -Leaf) `
    -HashType "SHA256"

Install-Binary `
    -Url $downloadUrl `
    -ExpectedSHA256Sum $externalHash

Invoke-PesterTests -TestFile "CLI.Tools" -TestName "AWS"
