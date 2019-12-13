################################################################################
##  File:  Install-AzureModules.ps1
##  Desc:  Install Azure PowerShell modules
################################################################################

Add-Type -AssemblyName System.IO.Compression.FileSystem

function Download-Zip
{
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory = $true
        )]
        [string]
        $BlobUri
    )

    Write-Host "Downloading the zip from blob: '$BlobUri'"
    $fileName = "azureps_" + "$(Get-Random)" + ".zip"
    $targetLocation = Join-Path $ENV:Temp -ChildPath $fileName
    Write-Host "Download target location: '$targetLocation'"
    $webClient = New-Object Net.WebClient
    $null = $webClient.DownloadFileAsync($BlobUri, $targetLocation)
    while ($webClient.IsBusy) { }
    Write-Host "Download complete. Target Location: '$targetLocation'"
    return $targetLocation
}

function Extract-Zip
{
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory = $true
        )]
        [string]
        $ZipFilePath,

        [Parameter(
            Mandatory = $true
        )]
        [string]
        $TargetLocation
    )

    Write-Host "Expanding the Zip File: '$ZipFilePath'. Target: '$TargetLocation'"
    $null = [System.IO.Compression.ZipFile]::ExtractToDirectory($ZipFilePath, $TargetLocation)
    Write-Host "Extraction completed successfully."
}

Set-PSRepository -InstallationPolicy Trusted -Name PSGallery

# We try to detect the whether Azure PowerShell is installed using .msi file. If it is installed, we find it's version, then it needs to be uninstalled manually (because the uninstallation requires the PowerShell session to be closed)
$regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
$installedApplications = Get-ItemProperty -Path $regKey
$SdkVersion = ($installedApplications | Where-Object { $_.DisplayName -and $_.DisplayName.toLower().Contains("microsoft azure powershell") } | Select-Object -First 1).DisplayVersion

if($SdkVersion -eq $null)
{
    Write-Host "No .msi Installation Present"
}
else
{
    Write-Host "An Azure PowerShell Installation through installer has been detected. Please close this powershell session and manually uninstall the Azure PowerShell from the Add or Remove Programs in the Control Panel. Then, rerun this script from an Admin PowerShell"
    throw "An Azure PowerShell Installation through installer has been detected. Please close this powershell session and manually uninstall the Azure PowerShell from the Add or Remove Programs in the Control Panel. Then, rerun this script from an Admin PowerShell"
}

# We will try to uninstall any installation of Azure PowerShell

$modules = Get-Module -Name Azure -ListAvailable
Write-Host "The Azure Modules initially present are:"
$modules | Select-Object Name,Version,Path | Format-Table

foreach($module in $modules)
{
    # add logging for telling what module we are working on now
    if(Test-Path -LiteralPath $module.Path)
    {
        try
        {
            Uninstall-Module -Name Azure -RequiredVersion $module.Version.tostring() -Force
        }
        catch
        {
            Write-Host "The Uninstallation of Azure Module version: $($module.Version.tostring()) failed with the error: $($_.Exception.Message) . Please Check if there isn't any other PowerShell session open."
            throw $_.Exception.Message
        }
    }
}

$modules = Get-Module -Name AzureRM -ListAvailable
Write-Host "The AzureRM Modules initially present are:"
$modules | Select-Object Name,Version,Path | Format-Table

foreach($module in $modules)
{
    # add logging for telling what module we are working on now
    if(Test-Path -LiteralPath $module.Path)
    {
        try
        {
            Uninstall-Module -Name AzureRM -RequiredVersion $module.Version.tostring() -Force
        }
        catch
        {
            Write-Host "The Uninstallation of AzureRM Module version: $($module.Version.tostring()) failed with the error: $($_.Exception.Message) . Please Check if there isn't any other PowerShell session open."
            throw $_.Exception.Message
        }
    }
}

#after this, the only installations available through a Get-Module cmdlet should be nothing

$modules = Get-Module -Name Azure -ListAvailable

foreach($module in $modules)
{
    Write-Host "Module found: $($module.Name)  Module Version: $($module.Version)"
    if($module.Version.ToString() -ne " ")
    {
        Write-Host "Another installation of Azure module is detected with version $($module.Version.ToString()) at path: $($module.Path)"
        throw "Azure module uninstallation unsuccessful"
    }
}

$modules = Get-Module -Name AzureRM -ListAvailable

foreach($module in $modules)
{
    write-host "Module found: $($module.Name)  Module Version: $($module.Version)"
    if($module.Version.ToString() -ne " ")
    {
        Write-Host "Another installation of AzureRM module is detected with version $($module.Version.ToString()) at path: $($module.Path)"
        throw "AzureRM module uninstallation unsuccessful"
    }
}

#### NOW The correct Modules need to be saved in C:\Modules

if($(Test-Path -LiteralPath "C:\Modules") -eq $true)
{
    Write-Host "C:\Modules directory is already present. Beginning to clear it up completely"
    Remove-Item -Path "C:\Modules" -Recurse -Force
}

mkdir "C:\Modules"

$directoryListing = Get-ChildItem -Path "C:\Modules"

if($directoryListing.Length -gt 0)
{
     Write-Host "C:\Modules was not deleted properly. It still has the following contents:"
     $directoryListing
}
else {
    Write-Host "The Directory is clean. There are no contents present in it"
}

# Download and unzip the stored AzurePSModules from the vstsagentools public blob
$extractLocation = "C:\Modules"
$azurePsUri = @(
    "https://vstsagenttools.blob.core.windows.net/tools/azurepowershellmodules/AzurePSModules.M157.20190808.27979.zip",
    "https://vstsagenttools.blob.core.windows.net/tools/azurepowershellmodules/AzureRmPSModules.M157.20190808.27379.zip",
    "https://vstsagenttools.blob.core.windows.net/tools/azurepowershellmodules/AzPSModules.M163.20191211.17769.zip"
)

$azureRMModulePath = "C:\Modules\azurerm_2.1.0"
$azureModulePath = "C:\Modules\azure_2.1.0"
$finalPath = ""
$environmentPSModulePath = [Environment]::GetEnvironmentVariable("PSModulePath", "Machine")
$existingPaths = $environmentPSModulePath -split ';' -replace '\\$',''

if ($existingPaths -notcontains $azureRMModulePath) {
    $finalPath = $azureRMModulePath
}

if ($existingPaths -notcontains $azureModulePath) {
    if($finalPath -ne "") {
        $finalPath = $finalPath + ";" + $azureModulePath
    }
    else {
        $finalPath = $azureModulePath
    }
}

if($finalPath -ne "") {
    [Environment]::SetEnvironmentVariable("PSModulePath", $finalPath + ";" + $env:PSModulePath, "Machine")
}

$env:PSModulePath = $env:PSModulePath.TrimStart(';')

foreach ($uri in $azurePsUri)
{
    $targetFile = Download-Zip -BlobUri $uri
    Extract-Zip -ZipFilePath $targetFile -TargetLocation $extractLocation
}
