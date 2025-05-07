Describe "Android" {
    function Get-AndroidPackages {
        <#
        .SYNOPSIS
            This function returns a list of available Android packages.

        .DESCRIPTION
            The Get-AndroidPackages function checks if a list of packages is already available in a file.
            If not, it uses the sdkmanager to generate a list of available packages and saves it to a file.
            It then returns the content of this file.

        .PARAMETER SDKRootPath
            The root path of the Android SDK installation.
            If not specified, the function uses the ANDROID_HOME environment variable.

        .EXAMPLE
            Get-AndroidPackages -SDKRootPath "/usr/local/lib/android/sdk"

            This command returns a list of available Android packages for the specified SDK root path.

        .NOTES
            This function requires the Android SDK to be installed.
        #>
        param (
            [Parameter(Mandatory=$false)]
            [string] $SDKRootPath
        )

        if (-not $SDKRootPath) {
            $SDKRootPath = $env:ANDROID_HOME
        }

        $packagesListFile = "$SDKRootPath/packages-list.txt"

        if (-not (Test-Path -Path $packagesListFile -PathType Leaf)) {
            (/usr/local/lib/android/sdk/cmdline-tools/latest/bin/sdkmanager --list --verbose 2>&1) |
                Where-Object { $_ -Match "^[^\s]" } |
                Where-Object { $_ -NotMatch "^(Loading |Info: Parsing |---|\[=+|Installed |Available )" } |
                Where-Object { $_ -NotMatch "^[^;]*$" } |
                Out-File -FilePath $packagesListFile

            Write-Host "Android packages list:"
            Get-Content $packagesListFile
        }

        return Get-Content $packagesListFile
    }

    $androidSdkManagerPackages = Get-AndroidPackages
    [int]$platformMinVersion = (Get-ToolsetContent).android.platform_min_version
    [version]$buildToolsMinVersion = (Get-ToolsetContent).android.build_tools_min_version
    [array]$ndkVersions = (Get-ToolsetContent).android.ndk.versions
    $ndkFullVersions = $ndkVersions |
        ForEach-Object { (Get-ChildItem "/usr/local/lib/android/sdk/ndk/${_}.*" |
        Select-Object -Last 1).Name } | ForEach-Object { "ndk/${_}" }
    # Platforms starting with a letter are the preview versions, which is not installed on the image
    $platformVersionsList = ($androidSdkManagerPackages |
        Where-Object { "$_".StartsWith("platforms;") }) -replace 'platforms;android-', '' |
        Where-Object { $_ -match "^\d" } | Sort-Object -Unique
    $platformsInstalled = $platformVersionsList |
        Where-Object { [int]($_.Split("-")[0]) -ge $platformMinVersion } |
        ForEach-Object { "platforms/android-${_}" }

    $buildToolsList = ($androidSdkManagerPackages | Where-Object { "$_".StartsWith("build-tools;") }) -replace 'build-tools;', ''
    $buildTools = $buildToolsList |
        Where-Object { $_ -match "\d+(\.\d+){2,}$"} |
        Where-Object { [version]$_ -ge $buildToolsMinVersion } |
        Sort-Object -Unique |
        ForEach-Object { "build-tools/${_}" }

    $androidPackages = @(
        $platformsInstalled,
        $buildTools,
        $ndkFullVersions,
        "platform-tools",
        ((Get-ToolsetContent).android.extra_list | ForEach-Object { "extras/${_}" }),
        ((Get-ToolsetContent).android.addon_list | ForEach-Object { "add-ons/${_}" }),
        ((Get-ToolsetContent).android.additional_tools | ForEach-Object { "${_}" })
    )

    $androidPackages = $androidPackages | ForEach-Object { $_ }

    Context "SDKManagers" {
        $testCases = @(
            @{
                PackageName = "Command-line tools"
                Sdkmanager = "$env:ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"
            }
        )

        It "Sdkmanager from <PackageName> is available" -TestCases $testCases {
            "$Sdkmanager --version" | Should -ReturnZeroExitCode
        }
    }

    Context "Packages" {
        $testCases = $androidPackages | ForEach-Object { @{ PackageName = $_ } }

        It "<PackageName>" -TestCases $testCases {
            # Convert 'cmake;3.6.4111459' -> 'cmake/3.6.4111459'
            $PackageName = $PackageName.Replace(";", "/")
            $targetPath = Join-Path $env:ANDROID_HOME $PackageName
            $targetPath | Should -Exist
        }
    }
}
