################################################################################
##  File:  Install-AWS-SAM.ps1
##  Desc:  Install aws sam cli
##         https://aws.amazon.com/serverless/sam/
################################################################################

Install-MSI -MsiUrl "https://github.com/awslabs/aws-sam-cli/releases/latest/download/AWS_SAM_CLI_64_PY3.msi" -MsiName "AWS_SAM_CLI_64_PY3.msi"