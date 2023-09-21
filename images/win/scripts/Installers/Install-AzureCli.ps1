################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

Write-Host "Install the latest Azure CLI release"
$azCliUrl = "https://aka.ms/installazurecliwindowsx64"
Install-Binary -Url $azCliUrl -Name "azure-cli.msi"
Update-Path

# Store cli extensions outside of the provisioning user's profile
$azureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
$null = New-Item -ItemType "Directory" -Path $azureCliExtensionPath
Set-SystemVariable -SystemVariable "AZURE_EXTENSION_DIR" -value $azureCliExtensionPath

# Store cli config outside of the provisioning user's profile
$azureCliConfigPath = Join-Path $Env:CommonProgramFiles 'AzureCliDirectory'
$null = New-Item -ItemType "Directory" -Path $azureCliConfigPath
Set-SystemVariable -SystemVariable "AZURE_CONFIG_DIR" -value $azureCliConfigPath

# Turn use automation recommended settings to speed up first-call on the hosted runner images.
# See: https://techcommunity.microsoft.com/t5/azure-tools-blog/streamline-configuring-azure-cli-with-az-init/ba-p/3051810

Write-Host "Setting automation defaults for 'az'"
Invoke-ValidateCommand -Command "az config set auto-upgrade.enable=false --only-show-errors"
Invoke-ValidateCommand -Command "az config set core.error_recommendation=off --only-show-errors"
Invoke-ValidateCommand -Command "az config set core.disable_progress_bar=true --only-show-errors"
Invoke-ValidateCommand -Command "az config set core.no_color=true --only-show-errors"
Invoke-ValidateCommand -Command "az config set core.survey_message=false --only-show-errors"

# Though recommended by az init, this may be a breaking change.
# Invoke-ValidateCommand -Command "az config set logging.enable_log_file=no --only-show-errors"


# Warm-up Azure CLI
Write-Host "Warmup 'az'"
Invoke-ValidateCommand -Command "az --help"
    
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure CLI"
