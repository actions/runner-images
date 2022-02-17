################################################################################
##  File:  Install-AndroidSDK.ps1
##  Desc:  Install and update Android SDK and tools
################################################################################

# install command-line tools
$cmdlineToolsUrl = "https://dl.google.com/android/repository/commandlinetools-win-7302050_latest.zip"
$cmdlineToolsArchPath = Start-DownloadWithRetry -Url $cmdlineToolsUrl -Name "cmdline-tools.zip"
$sdkInstallRoot = "C:\Program Files (x86)\Android\android-sdk"
$sdkRoot = "C:\Android\android-sdk"
Extract-7Zip -Path $cmdlineToolsArchPath -DestinationPath "${sdkInstallRoot}\cmdline-tools"

# cmdline tools should be installed in ${sdkInstallRoot}\cmdline-tools\latest\bin, but archive contains ${sdkInstallRoot}\cmdline-tools\bin 
# we need to create the proper folder structure
Invoke-SBWithRetry -Command {
    Rename-Item "${sdkInstallRoot}\cmdline-tools\cmdline-tools" "latest" -ErrorAction Stop
}

# ANDROID_NDK_PATH/HOME should not contain spaces. Otherwise, the script ndk-build.cmd gives an error https://github.com/actions/virtual-environments/issues/1122
# create "C:\Android" directory and a hardlink inside pointed to sdk in Program Files
New-Item -Path "C:\Android" -ItemType Directory
New-Item -Path "$sdkRoot" -ItemType SymbolicLink -Value "$sdkInstallRoot"
$sdkManager = "$sdkRoot\cmdline-tools\latest\bin\sdkmanager.bat"

# Install the standard Android SDK licenses. Currently, there isn't a better way to do this,
# so we are base64-encoded a zip of the licenses directory from another installation.
# To create this base64 string, create a zip file that contains nothing but a 'licenses' folder,
# which folder contains the accepted license files found in 'C:\Program Files (x86)\Android\android-sdk\licenses'.
# Then, run this in PowerShell:
#     $LicensesZipFileName = 'C:\Program Files (x86)\Android\android-sdk\Licenses.zip'
#     $base64Content = [Convert]::ToBase64String([IO.File]::ReadAllBytes($LicensesZipFileName))
#     echo $base64Content
# Another possible solution that works in powershell core:
# Write-Ouptut "y" | $sdkManager <packagename>
$licenseContentBase64 = "UEsDBBQAAAAAAKNK11IAAAAAAAAAAAAAAAAJAAAAbGljZW5zZXMvUEsDBAoAAAAAAJ1K11K7n0IrKgAAACoAAAAhAAAAbGljZW5zZXMvYW5kcm9pZC1nb29nbGV0di1saWNlbnNlDQo2MDEwODViOTRjZDc3ZjBiNTRmZjg2NDA2OTU3MDk5ZWJlNzljNGQ2UEsDBAoAAAAAAKBK11LzQumJKgAAACoAAAAkAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstYXJtLWRidC1saWNlbnNlDQo4NTlmMzE3Njk2ZjY3ZWYzZDdmMzBhNTBhNTU2MGU3ODM0YjQzOTAzUEsDBAoAAAAAAKFK11IKSOJFKgAAACoAAAAcAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstbGljZW5zZQ0KMjQzMzNmOGE2M2I2ODI1ZWE5YzU1MTRmODNjMjgyOWIwMDRkMWZlZVBLAwQKAAAAAACiStdSec1a4SoAAAAqAAAAJAAAAGxpY2Vuc2VzL2FuZHJvaWQtc2RrLXByZXZpZXctbGljZW5zZQ0KODQ4MzFiOTQwOTY0NmE5MThlMzA1NzNiYWI0YzljOTEzNDZkOGFiZFBLAwQKAAAAAACiStdSk6vQKCoAAAAqAAAAGwAAAGxpY2Vuc2VzL2dvb2dsZS1nZGstbGljZW5zZQ0KMzNiNmEyYjY0NjA3ZjExYjc1OWYzMjBlZjlkZmY0YWU1YzQ3ZDk3YVBLAwQKAAAAAACiStdSrE3jESoAAAAqAAAAJAAAAGxpY2Vuc2VzL2ludGVsLWFuZHJvaWQtZXh0cmEtbGljZW5zZQ0KZDk3NWY3NTE2OThhNzdiNjYyZjEyNTRkZGJlZWQzOTAxZTk3NmY1YVBLAwQKAAAAAACjStdSkb1vWioAAAAqAAAAJgAAAGxpY2Vuc2VzL21pcHMtYW5kcm9pZC1zeXNpbWFnZS1saWNlbnNlDQplOWFjYWI1YjVmYmI1NjBhNzJjZmFlY2NlODk0Njg5NmZmNmFhYjlkUEsBAj8AFAAAAAAAo0rXUgAAAAAAAAAAAAAAAAkAJAAAAAAAAAAQAAAAAAAAAGxpY2Vuc2VzLwoAIAAAAAAAAQAYACIHOBcRaNcBIgc4FxFo1wHBTVQTEWjXAVBLAQI/AAoAAAAAAJ1K11K7n0IrKgAAACoAAAAhACQAAAAAAAAAIAAAACcAAABsaWNlbnNlcy9hbmRyb2lkLWdvb2dsZXR2LWxpY2Vuc2UKACAAAAAAAAEAGACUEFUTEWjXAZQQVRMRaNcB6XRUExFo1wFQSwECPwAKAAAAAACgStdS80LpiSoAAAAqAAAAJAAkAAAAAAAAACAAAACQAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstYXJtLWRidC1saWNlbnNlCgAgAAAAAAABABgAsEM0FBFo1wGwQzQUEWjXAXb1MxQRaNcBUEsBAj8ACgAAAAAAoUrXUgpI4kUqAAAAKgAAABwAJAAAAAAAAAAgAAAA/AAAAGxpY2Vuc2VzL2FuZHJvaWQtc2RrLWxpY2Vuc2UKACAAAAAAAAEAGAAsMGUVEWjXASwwZRURaNcB5whlFRFo1wFQSwECPwAKAAAAAACiStdSec1a4SoAAAAqAAAAJAAkAAAAAAAAACAAAABgAQAAbGljZW5zZXMvYW5kcm9pZC1zZGstcHJldmlldy1saWNlbnNlCgAgAAAAAAABABgA7s3WFRFo1wHuzdYVEWjXAfGm1hURaNcBUEsBAj8ACgAAAAAAokrXUpOr0CgqAAAAKgAAABsAJAAAAAAAAAAgAAAAzAEAAGxpY2Vuc2VzL2dvb2dsZS1nZGstbGljZW5zZQoAIAAAAAAAAQAYAGRDRxYRaNcBZENHFhFo1wFfHEcWEWjXAVBLAQI/AAoAAAAAAKJK11KsTeMRKgAAACoAAAAkACQAAAAAAAAAIAAAAC8CAABsaWNlbnNlcy9pbnRlbC1hbmRyb2lkLWV4dHJhLWxpY2Vuc2UKACAAAAAAAAEAGADGsq0WEWjXAcayrRYRaNcBxrKtFhFo1wFQSwECPwAKAAAAAACjStdSkb1vWioAAAAqAAAAJgAkAAAAAAAAACAAAACbAgAAbGljZW5zZXMvbWlwcy1hbmRyb2lkLXN5c2ltYWdlLWxpY2Vuc2UKACAAAAAAAAEAGAA4LjgXEWjXATguOBcRaNcBIgc4FxFo1wFQSwUGAAAAAAgACACDAwAACQMAAAAA"
$licenseContent = [System.Convert]::FromBase64String($licenseContentBase64)
Set-Content -Path "$sdkInstallRoot\android-sdk-licenses.zip" -Value $licenseContent -Encoding Byte
Extract-7Zip -Path "$sdkInstallRoot\android-sdk-licenses.zip" -DestinationPath $sdkInstallRoot

# install platform-tools
$platformToolsPath = Join-Path -Path $sdkInstallRoot -ChildPath "platform-tools"
# Remove outdated platform-tools that was brought by Visual Studio Android package
if (Test-Path $platformToolsPath)
{
    Write-Host "Removing previous platform-tools installation from Visual Studio component"
    Remove-Item $platformToolsPath -Recurse -Force
}

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages "platform-tools"

# get packages to install from the toolset
$androidToolset = (Get-ToolsetContent).android

# get packages info
$androidPackages = Get-AndroidPackages -AndroidSDKManagerPath $sdkManager

# platforms
[int]$platformMinVersion = $androidToolset.platform_min_version
$platformList = Get-AndroidPackagesByVersion -AndroidPackages $androidPackages `
                -PrefixPackageName "platforms;" `
                -MinimumVersion $platformMinVersion `
                -Delimiter "-" `
                -Index 1

# build-tools
[version]$buildToolsMinVersion = $androidToolset.build_tools_min_version
$buildToolsList = Get-AndroidPackagesByVersion -AndroidPackages $androidPackages `
                -PrefixPackageName "build-tools;" `
                -MinimumVersion $buildToolsMinVersion `
                -Delimiter ";" `
                -Index 1

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages $platformList

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages $buildToolsList

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages $androidToolset.extra_list `
                -PrefixPackageName "extras;"

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages $androidToolset.addon_list `
                -PrefixPackageName "add-ons;"

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages $androidToolset.additional_tools

# NDKs
$ndkMajorVersions = $androidToolset.ndk.versions
$ndkDefaultMajorVersion = $androidToolset.ndk.default
$ndkLatestMajorVersion = $ndkMajorVersions | Select-Object -Last 1

$androidNDKs = $ndkMajorVersions | Foreach-Object {
    Get-AndroidPackagesByName -AndroidPackages $androidPackages -PrefixPackageName "ndk;$_" | Sort-Object -Unique | Select-Object -Last 1
}

Install-AndroidSDKPackages -AndroidSDKManagerPath $sdkManager `
                -AndroidSDKRootPath $sdkRoot `
                -AndroidPackages $androidNDKs

$ndkDefaultVersion = ($androidNDKs | Where-Object { $_ -match "ndk;$ndkDefaultMajorVersion" }).Split(';')[1]
$ndkLatestVersion = ($androidNDKs | Where-Object { $_ -match "ndk;$ndkLatestMajorVersion" }).Split(';')[1]

# Android NDK root path.
$ndkRoot = "$sdkRoot\ndk-bundle"
# This changes were added due to incompatibility with android ndk-bundle (ndk;22.0.7026061).
# Link issue virtual-environments: https://github.com/actions/virtual-environments/issues/2481
# Link issue xamarin-android: https://github.com/xamarin/xamarin-android/issues/5526
New-Item -Path $ndkRoot -ItemType SymbolicLink -Value "$sdkRoot\ndk\$ndkDefaultVersion"

if (Test-Path $ndkRoot) {
    setx ANDROID_HOME $sdkRoot /M
    setx ANDROID_SDK_ROOT $sdkRoot /M
    setx ANDROID_NDK_HOME $ndkRoot /M
    setx ANDROID_NDK_PATH $ndkRoot /M
    setx ANDROID_NDK_ROOT $ndkRoot /M
    (Get-Content -Encoding UTF8 "${ndkRoot}\ndk-build.cmd").replace('%~dp0\build\ndk-build.cmd','"%~dp0\build\ndk-build.cmd"')|Set-Content -Encoding UTF8 "${ndkRoot}\ndk-build.cmd"
} else {
    Write-Host "Default NDK $ndkDefaultVersion is not installed at path $ndkRoot"
    exit 1
}

$ndkLatestPath = "$sdkRoot\ndk\$ndkLatestVersion"
if (Test-Path $ndkLatestPath) {
    setx ANDROID_NDK_LATEST_HOME $ndkLatestPath /M
} else {
    Write-Host "Latest NDK $ndkLatestVersion is not installed at path $ndkLatestPath"
    exit 1
}

Invoke-PesterTests -TestFile "Android"
