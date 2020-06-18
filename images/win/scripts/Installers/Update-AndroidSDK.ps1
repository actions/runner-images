################################################################################
##  File:  Update-AndroidSDK.ps1
##  Desc:  Install and update Android SDK and tools
################################################################################

# Download the latest command line tools so that we can accept all of the licenses.
# See https://developer.android.com/studio/#command-tools
$sdkArchPath = Start-DownloadWithRetry -Url "https://dl.google.com/android/repository/sdk-tools-windows-4333796.zip" -Name "android-sdk-tools.zip"

# Don't replace the one that VS installs as it seems to break things.
Expand-Archive -Path $sdkArchPath -DestinationPath android-sdk -Force

$sdk = Get-Item -Path .\android-sdk

# Install the standard Android SDK licenses. In the past, there wasn't a better way to do this,
# so we are base64-encoding a zip of the licenses directory from another installation.
# To create this base64 string, create a zip file that contains nothing but a 'licenses' folder,
# which folder contains the accepted license files found in 'C:\Program Files (x86)\Android\android-sdk\licenses'.
# Then, run this in PowerShell:
#     $LicensesZipFileName = 'C:\Program Files (x86)\Android\android-sdk\Licenses.zip'
#     $base64Content = [Convert]::ToBase64String([IO.File]::ReadAllBytes($LicensesZipFileName))
#     echo $base64Content
#
# Future: see if the base64 technique can be avoided by running this PowerShell script to accept all licenses.
# This fails when run on a live agent, likely because non-interactive mode is set.
# It may work fine during image generation (this script).
#     for($i=0; $i -lt 100; $i++) { $response += "y`n"}; $response | .\sdkmanager.bat --licenses
$base64Content = "UEsDBBQAAAAAAKJeN06amkPzKgAAACoAAAAhAAAAbGljZW5zZXMvYW5kcm9pZC1nb29nbGV0di1saWNlbnNlDQpmYzk0NmU4ZjIzMWYzZTMxNTliZjBiN2M2NTVjOTI0Y2IyZTM4MzMwUEsDBBQAAAAIAKBrN05E+YSqQwAAAFQAAAAcAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstbGljZW5zZQXByREAIQgEwP9WmYsjhxgOKJN/CNs9vmdOQ2zdRw2dxQnWjqQ/3oIgXQM9vqUiwkiX8ljWea4ZlCF3xTo1pz6w+wdQSwMEFAAAAAAAxV43TpECY7AqAAAAKgAAACQAAABsaWNlbnNlcy9hbmRyb2lkLXNkay1wcmV2aWV3LWxpY2Vuc2UNCjUwNDY2N2Y0YzBkZTdhZjFhMDZkZTlmNGIxNzI3Yjg0MzUxZjI5MTBQSwMEFAAAAAAAzF43TpOr0CgqAAAAKgAAABsAAABsaWNlbnNlcy9nb29nbGUtZ2RrLWxpY2Vuc2UNCjMzYjZhMmI2NDYwN2YxMWI3NTlmMzIwZWY5ZGZmNGFlNWM0N2Q5N2FQSwMEFAAAAAAAz143TqxN4xEqAAAAKgAAACQAAABsaWNlbnNlcy9pbnRlbC1hbmRyb2lkLWV4dHJhLWxpY2Vuc2UNCmQ5NzVmNzUxNjk4YTc3YjY2MmYxMjU0ZGRiZWVkMzkwMWU5NzZmNWFQSwMEFAAAAAAA0l43Tu2ee/8qAAAAKgAAACYAAABsaWNlbnNlcy9taXBzLWFuZHJvaWQtc3lzaW1hZ2UtbGljZW5zZQ0KNjNkNzAzZjU2OTJmZDg5MWQ1YWNhY2ZiZDhlMDlmNDBmYzk3NjEwNVBLAQIUABQAAAAAAKJeN06amkPzKgAAACoAAAAhAAAAAAAAAAEAIAAAAAAAAABsaWNlbnNlcy9hbmRyb2lkLWdvb2dsZXR2LWxpY2Vuc2VQSwECFAAUAAAACACgazdORPmEqkMAAABUAAAAHAAAAAAAAAABACAAAABpAAAAbGljZW5zZXMvYW5kcm9pZC1zZGstbGljZW5zZVBLAQIUABQAAAAAAMVeN06RAmOwKgAAACoAAAAkAAAAAAAAAAEAIAAAAOYAAABsaWNlbnNlcy9hbmRyb2lkLXNkay1wcmV2aWV3LWxpY2Vuc2VQSwECFAAUAAAAAADMXjdOk6vQKCoAAAAqAAAAGwAAAAAAAAABACAAAABSAQAAbGljZW5zZXMvZ29vZ2xlLWdkay1saWNlbnNlUEsBAhQAFAAAAAAAz143TqxN4xEqAAAAKgAAACQAAAAAAAAAAQAgAAAAtQEAAGxpY2Vuc2VzL2ludGVsLWFuZHJvaWQtZXh0cmEtbGljZW5zZVBLAQIUABQAAAAAANJeN07tnnv/KgAAACoAAAAmAAAAAAAAAAEAIAAAACECAABsaWNlbnNlcy9taXBzLWFuZHJvaWQtc3lzaW1hZ2UtbGljZW5zZVBLBQYAAAAABgAGANoBAACPAgAAAAA="
$content = [System.Convert]::FromBase64String($base64Content)
Set-Content -Path .\android-sdk-licenses.zip -Value $content -Encoding Byte
Expand-Archive -Path .\android-sdk-licenses.zip -DestinationPath 'C:\Program Files (x86)\Android\android-sdk' -Force


# run the updates.
# keep newer versions in descending order

$sdk_root = "C:\Program Files (x86)\Android\android-sdk"

Push-Location -Path $sdk.FullName

& '.\tools\bin\sdkmanager.bat' --sdk_root=$sdk_root `
    "platform-tools" `
    "platforms;android-30" `
    "platforms;android-29" `
    "platforms;android-28" `
    "platforms;android-27" `
    "platforms;android-26" `
    "platforms;android-25" `
    "platforms;android-24" `
    "platforms;android-23" `
    "platforms;android-22" `
    "platforms;android-21" `
    "platforms;android-19" `
    "build-tools;30.0.0" `
    "build-tools;29.0.3" `
    "build-tools;29.0.2" `
    "build-tools;29.0.1" `
    "build-tools;29.0.0" `
    "build-tools;28.0.3" `
    "build-tools;28.0.2" `
    "build-tools;28.0.1" `
    "build-tools;28.0.0" `
    "build-tools;27.0.3" `
    "build-tools;27.0.2" `
    "build-tools;27.0.1" `
    "build-tools;27.0.0" `
    "build-tools;26.0.3" `
    "build-tools;26.0.2" `
    "build-tools;26.0.1" `
    "build-tools;26.0.0" `
    "build-tools;25.0.3" `
    "build-tools;25.0.2" `
    "build-tools;25.0.1" `
    "build-tools;25.0.0" `
    "build-tools;24.0.3" `
    "build-tools;24.0.2" `
    "build-tools;24.0.1" `
    "build-tools;24.0.0" `
    "build-tools;23.0.3" `
    "build-tools;23.0.2" `
    "build-tools;23.0.1" `
    "build-tools;22.0.1" `
    "build-tools;21.1.2" `
    "build-tools;20.0.0" `
    "build-tools;19.1.0" `
    "extras;android;m2repository" `
    "extras;google;m2repository" `
    "extras;google;google_play_services" `
    "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" `
    "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.1" `
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" `
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" `
    "add-ons;addon-google_apis-google-24" `
    "add-ons;addon-google_apis-google-23" `
    "add-ons;addon-google_apis-google-22" `
    "add-ons;addon-google_apis-google-21" `
    "cmake;3.6.4111459" `
    "cmake;3.10.2.4988404" `
    "patcher;v4" `
    "ndk-bundle"

    # Android NDK root path.
    $ndk_root = "C:\Program Files (x86)\Android\android-sdk\ndk-bundle"

    if (Test-Path $ndk_root){
        setx ANDROID_HOME $sdk_root /M
        setx ANDROID_NDK_HOME $ndk_root /M
        setx ANDROID_NDK_PATH $ndk_root /M
    } else {
        Write-Host "NDK is not installed at path $ndk_root"
        exit 1
    }

Pop-Location

