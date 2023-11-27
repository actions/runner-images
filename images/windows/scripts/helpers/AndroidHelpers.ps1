function Get-AndroidPackages {
    <#
    .SYNOPSIS
        This function returns a list of available Android packages.

    .DESCRIPTION
        The Get-AndroidPackages function checks if a list of packages is already available in a file.
        If not, it uses the sdkmanager.bat script to generate a list of available packages and saves it to a file. 
        It then returns the content of this file.

    .PARAMETER SDKRootPath
        The root path of the Android SDK installation.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .EXAMPLE
        Get-AndroidPackages -SDKRootPath "C:\Android\SDK"

        This command returns a list of available Android packages for the specified SDK root path.

    .NOTES
        This function requires the Android SDK to be installed and the sdkmanager.bat script to be accessible.

    #>
    Param
    (
        [string] $SDKRootPath
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }

    $packagesListFile = "$SDKRootPath\packages-list.txt"
    $sdkManager = "$SDKRootPath\cmdline-tools\latest\bin\sdkmanager.bat"

    if (-Not (Test-Path -Path $packagesListFile -PathType Leaf)) {
        (cmd /c "$sdkManager --list --verbose 2>&1") |
            Where-Object { $_ -Match "^[^\s]" } |
            Where-Object { $_ -NotMatch "^(Loading |Info: Parsing |---|\[=+|Installed |Available )" } |
            Where-Object { $_ -NotMatch "^[^;]*$" } |
            Out-File -FilePath $packagesListFile
    }

    return Get-Content $packagesListFile
}

function Get-AndroidPlatformPackages {
    <#
    .SYNOPSIS
        This function returns a list of available Android platform packages.

    .DESCRIPTION
        The Get-AndroidPlatformPackages function uses the Get-AndroidPackages function to get a list of available packages
        and filters it to return only platform packages.

    .PARAMETER SDKRootPath
        The root path of the Android SDK installation.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .PARAMETER minimumVersion
        The minimum version of the platform packages to include in the result. Default is 0.

    .EXAMPLE
        Get-AndroidPlatformPackages -SDKRootPath "C:\Android\SDK" -minimumVersion 29

        This command returns a list of available Android platform packages for the specified SDK root path with a minimum version of 29.

    .NOTES
        This function requires the Android SDK to be installed and the sdkmanager.bat script to be accessible.

    #>
    Param
    (
        [string] $SDKRootPath,
        [Alias("minVersion")]
        [int] $minimumVersion = 0
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }

    return (Get-AndroidPackages -SDKRootPath $SDKRootPath) `
    | Where-Object { "$_".StartsWith("platforms;") } `
    | Where-Object { ($_.Split("-")[1] -as [int]) -ge $minimumVersion } `
    | Sort-Object -Unique
}

function Get-AndroidBuildToolPackages {
    <#
    .SYNOPSIS
        This function returns a list of available Android build tool packages.

    .DESCRIPTION
        The Get-AndroidBuildToolPackages function uses the Get-AndroidPackages function to get a list of available packages
        and filters it to return only build tool packages.

    .PARAMETER SDKRootPath
        The root path of the Android SDK installation.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .PARAMETER minimumVersion
        The minimum version of the build tool packages to include in the result. Default is 0.0.0.

    .EXAMPLE
        Get-AndroidBuildToolPackages -SDKRootPath "C:\Android\SDK" -minimumVersion "30.0.2"

        This command returns a list of available Android build tool packages for the specified SDK root path with a minimum version of 30.0.2.

    .NOTES
        This function requires the Android SDK to be installed and the sdkmanager.bat script to be accessible.

    #>
    Param
    (
        [string] $SDKRootPath,
        [Alias("minVersion")]
        [version] $minimumVersion = "0.0.0"
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }

    return (Get-AndroidPackages -SDKRootPath $SDKRootPath) `
    | Where-Object { "$_".StartsWith("build-tools;") } `
    | Where-Object { ($_.Split(";")[1] -as [version]) -ge $minimumVersion } `
    | Sort-Object -Unique
}

function Get-AndroidInstalledPackages {
    <#
    .SYNOPSIS
        Retrieves a list of installed Android packages.

    .DESCRIPTION
        This function retrieves a list of installed Android packages using the specified SDK root path.

    .PARAMETER SDKRootPath
        The root path of the Android SDK.
        If not specified, the function uses the ANDROID_HOME environment variable.

    .EXAMPLE
        Get-AndroidInstalledPackages -SDKRootPath "C:\Android\SDK"
        Retrieves a list of installed Android packages using the specified SDK root path.

    .NOTES
        This function requires the Android SDK to be installed and the SDK root path to be provided.
    #>

    Param
    (
        [string] $SDKRootPath
    )
    
    if (-not $SDKRootPath) {
        $SDKRootPath = $env:ANDROID_HOME
    }
    
    $sdkManager = "$SDKRootPath\cmdline-tools\latest\bin\sdkmanager.bat"

    return (cmd /c "$sdkManager --list_installed 2>&1") -notmatch "Warning"
}
