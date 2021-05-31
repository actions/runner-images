function Get-VisualStudioVersion {
    $vsVersion = vswhere -format json | ConvertFrom-Json
    [PSCustomObject]@{
        Name = $vsVersion.displayName
        Version = $vsVersion.installationVersion
        Path = $vsVersion.installationPath
    }
}

function Get-WixVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    ($installedApplications | Where-Object { $_.DisplayName -match "wix" } | Select-Object -First 1).DisplayVersion
}

function Get-WDKVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    ($installedApplications | Where-Object { $_.DisplayName -eq 'Windows Driver Kit' } | Select-Object -First 1).DisplayVersion
}

function Get-VisualStudioExtensions {
    # Additional vsixs
    $toolset = Get-ToolsetContent
    $vsixUrls = $toolset.visualStudio.vsix
    if ($vsixUrls)
    {
        $vsixs = $vsixUrls | ForEach-Object {
            $vsix = Get-VsixExtenstionFromMarketplace -ExtensionMarketPlaceName $_
            $vsixVersion = (Get-VisualStudioPackages | Where-Object {$_.Id -match $vsix.VsixId -and $_.type -eq 'vsix'}).Version
            @{
                Package = $vsix.ExtensionName
                Version = $vsixVersion
            }
        }
    }

    # SSDT extensions for VS2017
    $vs = (Get-VisualStudioVersion).Name.Split()[-1]
    if ($vs -eq "2017")
    {
        $analysisPackageVersion = Get-VSExtensionVersion -packageName '04a86fc2-dbd5-4222-848e-911638e487fe'
        $reportingPackageVersion = Get-VSExtensionVersion -packageName '717ad572-c4b7-435c-c166-c2969777f718'
        $integrationPackageName = Get-VSExtensionVersion -packageName 'd1b09713-c12e-43cc-9ef4-6562298285ab'
        $ssdtPackages = @(
            @{Package = 'SSDT Microsoft Analysis Services Projects'; Version = $analysisPackageVersion}
            @{Package = 'SSDT SQL Server Integration Services Projects'; Version = $reportingPackageVersion}
            @{Package = 'SSDT Microsoft Reporting Services Projects'; Version = $integrationPackageName}
        )
    }

    # Wix
    $wixPackageVersion = Get-WixVersion
    $wixExtensionVersion = (Get-VisualStudioPackages | Where-Object {$_.Id -match 'WixToolset.VisualStudioExtension.Dev' -and $_.type -eq 'vsix'}).Version

    # WDK
    $wdkPackageVersion = Get-VSExtensionVersion -packageName 'Microsoft.Windows.DriverKit'
    $wdkExtensionVersion = Get-WDKVersion

    $extensions = @(
        $vsixs
        $ssdtPackages
        @{Package = 'Windows Driver Kit'; Version = $wdkPackageVersion}
        @{Package = 'Windows Driver Kit Visual Studio Extension'; Version = $wdkExtensionVersion}
        @{Package = 'WIX Toolset'; Version = $wixPackageVersion}
        @{Package = "WIX Toolset Studio $vs Extension"; Version = $wixExtensionVersion}
    )

    $extensions | Foreach-Object {
        [PSCustomObject]$_
    } | Select-Object Package, Version | Sort-Object Package
}