################################################################################
##  File:  Install-AzureCli.ps1
##  Desc:  Install Azure CLI
################################################################################

Write-Host "Install the latest Azure CLI release"
$azCliUrl = "https://aka.ms/installazurecliwindowsx64"
Install-Binary -Url $azCliUrl -Name "azure-cli.msi"

# Store cli extensions outside of the provisioning user's profile
$azureCliExtensionPath = Join-Path $Env:CommonProgramFiles 'AzureCliExtensionDirectory'
$null = New-Item -ItemType "Directory" -Path $azureCliExtensionPath
[Environment]::SetEnvironmentVariable("AZURE_EXTENSION_DIR", $azureCliExtensionPath, [System.EnvironmentVariableTarget]::Machine)

# Store cli config outside of the provisioning user's profile
$azureCliConfigPath = Join-Path $Env:CommonProgramFiles 'AzureCliDirectory'
$null = New-Item -ItemType "Directory" -Path $azureCliConfigPath
[Environment]::SetEnvironmentVariable("AZURE_CONFIG_DIR", $azureCliConfigPath, [System.EnvironmentVariableTarget]::Machine)

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

# Turn use automation recommended settings to speed up first-call on the hosted runner images.
az config set auto-upgrade.enable=false
az config set core.error_recommendation=off
az config set core.disable_progress_bar=true
az config set core.only_show_errors=true
az config set core.no_color=true
az config set logging.enable_log_file=no
az config set output.show_survey_link=no
    
Invoke-PesterTests -TestFile "CLI.Tools" -TestName "Azure CLI"
