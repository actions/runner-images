################################################################################
##  File:  Install-Kotlin.ps1
##  Desc:  Install Kotlin
################################################################################

# Install Kotlin
$kotlinVersion = (Get-ToolsetContent).kotlin.version
$kotlinBinaryName = (Get-ToolsetContent).kotlin.binary_name
$json = Invoke-RestMethod -Uri "https://api.github.com/repos/JetBrains/kotlin/releases?per_page=100"
$kotlinDownloadUrl = $json.Where{ -not $_.prerelease }.assets.browser_download_url | 
    Where-Object { $_ -like "*${kotlinBinaryName}-${kotlinVersion}*" } |
    Select-Object -First 1

$kotlinInstallerPath = Start-DownloadWithRetry -Url $kotlinDownloadUrl -Name "$kotlinBinaryName.zip"

Write-Host "Expand Kotlin archive"
$kotlinPath = "C:\tools"
Extract-7Zip -Path $kotlinInstallerPath -DestinationPath $kotlinPath

# Add to PATH
Add-MachinePathItem "$kotlinPath\kotlinc\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Kotlin"