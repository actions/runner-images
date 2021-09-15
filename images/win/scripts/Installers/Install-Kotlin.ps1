################################################################################
##  File:  Install-Kotlin.ps1
##  Desc:  Install Kotlin
################################################################################

# Install Kotlin
$url = "https://api.github.com/repos/JetBrains/kotlin/releases/latest"
[System.String] $kotlinLatest = (Invoke-RestMethod -Uri $url).assets.browser_download_url -match "kotlin-compiler"
$kotlinInstallerPath = Start-DownloadWithRetry -Url $kotlinLatest -Name "kotlin-compiler.zip"

Write-Host "Expand Kotlin archive"
$kotlinPath = "C:\tools"
Extract-7Zip -Path $kotlinInstallerPath -DestinationPath $kotlinPath

# Add to PATH
Add-MachinePathItem "$kotlinPath\kotlinc\bin"

Invoke-PesterTests -TestFile "Tools" -TestName "Kotlin"