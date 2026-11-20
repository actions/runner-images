################################################################################
##  File:  Install-Apache.ps1
##  Desc:  Install Apache HTTP Server
##  Supply chain security: Apache Lounge - checksum validation
################################################################################

# Stop w3svc service
$w3svcService = Get-Service -Name "w3svc" -ErrorAction SilentlyContinue
if ($w3svcService) {
    Stop-Service $w3svcService
}

# Install the latest Apache Lounge Win64 build (the chocolatey package is no longer updated).
# apachelounge.com rejects PowerShell web requests, so curl.exe is used for downloads.
function Invoke-CurlDownload {
    param (
        [Parameter(Mandatory)] [string] $Url,
        [Parameter(Mandatory)] [string] $Path
    )
    Write-Host "Downloading $Url to $Path..."
    curl.exe --fail --silent --show-error --location --retry 5 --retry-all-errors --retry-delay 10 --output $Path $Url
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to download $Url (curl exit code $LASTEXITCODE)"
    }
    return $Path
}

$baseUrl = "https://www.apachelounge.com"
$downloadPage = Get-Content (Invoke-CurlDownload -Url "$baseUrl/download/" -Path (Join-Path $env:TEMP_DIR "apachelounge.html")) -Raw
$archiveRelativeUrl = [regex]::Matches($downloadPage, 'href="(?<url>/download/VS\d+/binaries/httpd-2\.4\.\d+-\d+-Win64-VS\d+\.zip)"') |
    ForEach-Object { $_.Groups["url"].Value } |
    Select-Object -First 1
if (-not $archiveRelativeUrl) {
    throw "Unable to find Apache Win64 archive on $baseUrl/download/"
}
$archiveUrl = "$baseUrl$archiveRelativeUrl"
$archiveName = Split-Path $archiveUrl -Leaf
$archivePath = Invoke-CurlDownload -Url $archiveUrl -Path (Join-Path $env:TEMP_DIR $archiveName)

#region Supply chain security
# Checksum file lists "SHA256-Checksum for: <file>:" followed by the hash on the next line
$checksumFile = Get-Content (Invoke-CurlDownload -Url "$archiveUrl.txt" -Path (Join-Path $env:TEMP_DIR "$archiveName.txt"))
$checksumLine = $checksumFile | Select-String -Pattern "SHA256-Checksum for: $([regex]::Escape($archiveName))" -Context 0, 1
$externalHash = $checksumLine.Context.PostContext | Select-String -Pattern "[A-Fa-f0-9]{64}" | ForEach-Object { $_.Matches.Value }
if (-not $externalHash) {
    throw "Unable to find SHA256 checksum for $archiveName"
}
Test-FileChecksum $archivePath -ExpectedSHA256Sum $externalHash
#endregion

# Extract to C:\tools\Apache24
$installDir = "C:\tools"
$apachePath = Join-Path $installDir "Apache24"
$extractPath = Join-Path $env:TEMP_DIR "apache"
Expand-7ZipArchive -Path $archivePath -DestinationPath $extractPath
Move-Item -Path (Join-Path $extractPath "Apache24") -Destination $apachePath
Remove-Item -Path $extractPath -Recurse -Force

# Point server root to the install location
$configPath = Join-Path $apachePath "conf\httpd.conf"
(Get-Content $configPath) -replace '^Define SRVROOT ".*"$', "Define SRVROOT `"$($apachePath -replace '\\', '/')`"" `
    | Set-Content $configPath

# Register Apache service, then stop and disable it
& "$apachePath\bin\httpd.exe" -k install -n Apache
if ($LASTEXITCODE -ne 0) {
    throw "Failed to register Apache service"
}
Stop-Service -Name Apache -ErrorAction SilentlyContinue
Set-Service -Name Apache -StartupType Disabled

# Start w3svc service
$w3svcService = Get-Service -Name "w3svc" -ErrorAction SilentlyContinue
if ($w3svcService) {
    Start-Service $w3svcService
}

# Invoke Pester Tests
Invoke-PesterTests -TestFile "Apache"
