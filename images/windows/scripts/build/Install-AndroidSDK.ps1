################################################################################
##  File:  Install-AndroidSDK.ps1
##  Desc:  Install and update Android SDK and tools
##  Supply chain security: checksum validation
################################################################################

# Actual Android SDK installation directory
$SDKInstallRoot = "C:\Program Files (x86)\Android\android-sdk"

# Hardlink to the Android SDK installation directory with no spaces in the path.
# ANDROID_NDK* env vars should not contain spaces, otherwise ndk-build.cmd gives an error
# https://github.com/actions/runner-images/issues/1122
$SDKRootPath = "C:\Android\android-sdk"

#region functions
function Install-AndroidSDKPackages {
    <#
    .SYNOPSIS
        This function installs the specified Android SDK packages.

    .DESCRIPTION
        The Install-AndroidSDKPackages function takes an array of package names as a parameter and installs each of them using the sdkmanager.bat script.

    .PARAMETER Packages
        An array of package names in the format of SDK-style paths to be installed.

    .EXAMPLE
        Install-AndroidSDKPackages -Packages "platforms;android-29", "build-tools;29.0.2"

        This command installs the Android SDK Platform 29 and Build-Tools 29.0.2.

    #>
    Param
    (
        [Parameter(Mandatory = $true)]
        [AllowEmptyCollection()]
        [AllowNull()]
        [string[]] $Packages
    )
    
    # The sdkmanager.bat script is used to install Android SDK packages.
    $SDKManager = "$SDKRootPath\cmdline-tools\latest\bin\sdkmanager.bat"

    $errors = @()

    foreach ($package in $Packages) {
        & $SDKManager --install "$package" --sdk_root=$SDKRootPath
        if ($LASTEXITCODE -ne 0) {
            $errors += "Failed to install package $package with exit code $LASTEXITCODE"
        }
    }

    if ($errors.Count -gt 0) {
        throw $errors
    }
}
#endregion

# get packages to install from the toolset
$androidToolset = (Get-ToolsetContent).android
# Newer version(s) require Java 11 by default
# See https://github.com/actions/runner-images/issues/6960
$cmdlineToolsUrl = $androidToolset.commandline_tools_url
$cmdlineToolsArchPath = Invoke-DownloadWithRetry $cmdlineToolsUrl

Test-FileChecksum $cmdlineToolsArchPath -ExpectedSHA256Sum $androidToolset.hash

Expand-7ZipArchive -Path $cmdlineToolsArchPath -DestinationPath "${SDKInstallRoot}\cmdline-tools"

# cmdline tools should be installed in ${SDKInstallRoot}\cmdline-tools\latest\bin, but archive contains ${SDKInstallRoot}\cmdline-tools\bin 
# we need to create the proper folder structure
Invoke-ScriptBlockWithRetry -Command {
    Rename-Item "${SDKInstallRoot}\cmdline-tools\cmdline-tools" "latest" -ErrorAction Stop
}

# Create hardlink at $SDKRootPath pointing to SDK installation directory in Program Files
New-Item -Path (Split-Path $SDKRootPath -Parent) -ItemType Directory -Force
New-Item -Path "$SDKRootPath" -ItemType SymbolicLink -Value "$SDKInstallRoot"

# Install the standard Android SDK licenses. Currently, there isn't a better way to do this,
# so we are base64-encoded a zip of the licenses directory from another installation.
# To create this base64 string, create a zip file that contains nothing but a 'licenses' folder,
# which folder contains the accepted license files found in 'C:\Program Files (x86)\Android\android-sdk\licenses'.
# Then, run this in PowerShell:
#     $LicensesZipFileName = 'C:\Program Files (x86)\Android\android-sdk\Licenses.zip'
#     $base64Content = [Convert]::ToBase64String([IO.File]::ReadAllBytes($LicensesZipFileName))
#     echo $base64Content
# Another possible solution that works in powershell core:
# Write-Ouptut "y" | $sdkmanager.bat <packagename>
$licenseContentBase64 = "UEsDBBQAAAAAAKNK11IAAAAAAAAAAAAAAAAJAAAAbGljZW5zZXMvUEsDBAoAAAAAAJ1K11K7n0IrKgAAACoAAAAhAAAAbGljZW5zZXMvYW5kcm9pZC1nb29nbGV0di1saWNlbnNlDQo2MDEwODViOTRjZDc3ZjBiNTRmZjg2NDA2OTU3MDk5ZWJlNzljNGQ2UEsDBAoAAAAAAKBK11LzQumJKgAAACoAAAAkAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstYXJtLWRidC1saWNlbnNlDQo4NTlmMzE3Njk2ZjY3ZWYzZDdmMzBhNTBhNTU2MGU3ODM0YjQzOTAzUEsDBAoAAAAAAKFK11IKSOJFKgAAACoAAAAcAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstbGljZW5zZQ0KMjQzMzNmOGE2M2I2ODI1ZWE5YzU1MTRmODNjMjgyOWIwMDRkMWZlZVBLAwQKAAAAAACiStdSec1a4SoAAAAqAAAAJAAAAGxpY2Vuc2VzL2FuZHJvaWQtc2RrLXByZXZpZXctbGljZW5zZQ0KODQ4MzFiOTQwOTY0NmE5MThlMzA1NzNiYWI0YzljOTEzNDZkOGFiZFBLAwQKAAAAAACiStdSk6vQKCoAAAAqAAAAGwAAAGxpY2Vuc2VzL2dvb2dsZS1nZGstbGljZW5zZQ0KMzNiNmEyYjY0NjA3ZjExYjc1OWYzMjBlZjlkZmY0YWU1YzQ3ZDk3YVBLAwQKAAAAAACiStdSrE3jESoAAAAqAAAAJAAAAGxpY2Vuc2VzL2ludGVsLWFuZHJvaWQtZXh0cmEtbGljZW5zZQ0KZDk3NWY3NTE2OThhNzdiNjYyZjEyNTRkZGJlZWQzOTAxZTk3NmY1YVBLAwQKAAAAAACjStdSkb1vWioAAAAqAAAAJgAAAGxpY2Vuc2VzL21pcHMtYW5kcm9pZC1zeXNpbWFnZS1saWNlbnNlDQplOWFjYWI1YjVmYmI1NjBhNzJjZmFlY2NlODk0Njg5NmZmNmFhYjlkUEsBAj8AFAAAAAAAo0rXUgAAAAAAAAAAAAAAAAkAJAAAAAAAAAAQAAAAAAAAAGxpY2Vuc2VzLwoAIAAAAAAAAQAYACIHOBcRaNcBIgc4FxFo1wHBTVQTEWjXAVBLAQI/AAoAAAAAAJ1K11K7n0IrKgAAACoAAAAhACQAAAAAAAAAIAAAACcAAABsaWNlbnNlcy9hbmRyb2lkLWdvb2dsZXR2LWxpY2Vuc2UKACAAAAAAAAEAGACUEFUTEWjXAZQQVRMRaNcB6XRUExFo1wFQSwECPwAKAAAAAACgStdS80LpiSoAAAAqAAAAJAAkAAAAAAAAACAAAACQAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstYXJtLWRidC1saWNlbnNlCgAgAAAAAAABABgAsEM0FBFo1wGwQzQUEWjXAXb1MxQRaNcBUEsBAj8ACgAAAAAAoUrXUgpI4kUqAAAAKgAAABwAJAAAAAAAAAAgAAAA/AAAAGxpY2Vuc2VzL2FuZHJvaWQtc2RrLWxpY2Vuc2UKACAAAAAAAAEAGAAsMGUVEWjXASwwZRURaNcB5whlFRFo1wFQSwECPwAKAAAAAACiStdSec1a4SoAAAAqAAAAJAAkAAAAAAAAACAAAABgAQAAbGljZW5zZXMvYW5kcm9pZC1zZGstcHJldmlldy1saWNlbnNlCgAgAAAAAAABABgA7s3WFRFo1wHuzdYVEWjXAfGm1hURaNcBUEsBAj8ACgAAAAAAokrXUpOr0CgqAAAAKgAAABsAJAAAAAAAAAAgAAAAzAEAAGxpY2Vuc2VzL2dvb2dsZS1nZGstbGljZW5zZQoAIAAAAAAAAQAYAGRDRxYRaNcBZENHFhFo1wFfHEcWEWjXAVBLAQI/AAoAAAAAAKJK11KsTeMRKgAAACoAAAAkACQAAAAAAAAAIAAAAC8CAABsaWNlbnNlcy9pbnRlbC1hbmRyb2lkLWV4dHJhLWxpY2Vuc2UKACAAAAAAAAEAGADGsq0WEWjXAcayrRYRaNcBxrKtFhFo1wFQSwECPwAKAAAAAACjStdSkb1vWioAAAAqAAAAJgAkAAAAAAAAACAAAACbAgAAbGljZW5zZXMvbWlwcy1hbmRyb2lkLXN5c2ltYWdlLWxpY2Vuc2UKACAAAAAAAAEAGAA4LjgXEWjXATguOBcRaNcBIgc4FxFo1wFQSwUGAAAAAAgACACDAwAACQMAAAAA"
$licenseContent = [System.Convert]::FromBase64String($licenseContentBase64)
Set-Content -Path "$SDKInstallRoot\android-sdk-licenses.zip" -Value $licenseContent -Encoding Byte
Expand-7ZipArchive -Path "$SDKInstallRoot\android-sdk-licenses.zip" -DestinationPath $SDKInstallRoot

# Install platform-tools
$platformToolsPath = Join-Path -Path $SDKInstallRoot -ChildPath "platform-tools"
if (Test-Path $platformToolsPath) {
    Write-Host "Removing previous platform-tools installation from Visual Studio component"
    Remove-Item $platformToolsPath -Recurse -Force
}
Install-AndroidSDKPackages "platform-tools"

# Get Android SDK packages list
$androidPackages = Get-AndroidPackages -SDKRootPath $SDKRootPath

# Install Android platform versions
# that are greater than or equal to the minimum version
Write-Host "Installing Android SDK packages for platforms..."
$platformList = Get-AndroidPlatformPackages `
    -SDKRootPath $SDKRootPath `
    -minVersion $androidToolset.platform_min_version
Install-AndroidSDKPackages $platformList

# Install Android build-tools versions
# that are greater than or equal to the minimum version
Write-Host "Installing Android SDK packages for build tools..."
$buildToolsList = Get-AndroidBuildToolPackages `
    -SDKRootPath $SDKRootPath `
    -minVersion $androidToolset.build_tools_min_version
Install-AndroidSDKPackages $buildToolsList

# Install Android Emulator
Install-AndroidSDKPackages "emulator"

# Install extras, add-ons and additional tools
Write-Host "Installing Android SDK extras, add-ons and additional tools..."
Install-AndroidSDKPackages ($androidToolset.extras | ForEach-Object { "extras;$_" })
Install-AndroidSDKPackages ($androidToolset.addons | ForEach-Object { "add-ons;$_" })
Install-AndroidSDKPackages ($androidToolset.additional_tools)

# Install NDKs
$ndkMajorVersions = $androidToolset.ndk.versions
$ndkDefaultMajorVersion = $androidToolset.ndk.default
$ndkLatestMajorVersion = $ndkMajorVersions | Select-Object -Last 1

$androidNDKs = @()
foreach ($version in $ndkMajorVersions) {
    $packageNamePrefix = "ndk;$version"
    $package = $androidPackages | Where-Object { $_.StartsWith($packageNamePrefix) } | Sort-Object -Unique | Select-Object -Last 1
    $androidNDKs += $package
}

Write-Host "Installing Android SDK packages for NDKs..."
Install-AndroidSDKPackages $androidNDKs

$ndkLatestVersion = ($androidNDKs | Where-Object { $_ -match "ndk;$ndkLatestMajorVersion" }).Split(';')[1]
$ndkDefaultVersion = ($androidNDKs | Where-Object { $_ -match "ndk;$ndkDefaultMajorVersion" }).Split(';')[1]
$ndkRoot = "$SDKRootPath\ndk\$ndkDefaultVersion"

# Create env variables
[Environment]::SetEnvironmentVariable("ANDROID_HOME", $SDKRootPath, "Machine")
[Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $SDKRootPath, "Machine")
# ANDROID_NDK, ANDROID_NDK_HOME, and ANDROID_NDK_ROOT variables should be set as many customer builds depend on them https://github.com/actions/runner-images/issues/5879
[Environment]::SetEnvironmentVariable("ANDROID_NDK", $ndkRoot, "Machine")
[Environment]::SetEnvironmentVariable("ANDROID_NDK_HOME", $ndkRoot, "Machine")
[Environment]::SetEnvironmentVariable("ANDROID_NDK_ROOT", $ndkRoot, "Machine")

$ndkLatestPath = "$SDKRootPath\ndk\$ndkLatestVersion"
if (Test-Path $ndkLatestPath) {
    [Environment]::SetEnvironmentVariable("ANDROID_NDK_LATEST_HOME", $ndkLatestPath, "Machine")
} else {
    Write-Host "Latest NDK $ndkLatestVersion is not installed at path $ndkLatestPath"
    exit 1
}

Invoke-PesterTests -TestFile "Android"
