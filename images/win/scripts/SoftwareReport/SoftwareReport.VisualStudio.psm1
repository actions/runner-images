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

    # Wix
    $vs = (Get-VisualStudioVersion).Name.Split()[-1]
    $wixPackageVersion = Get-WixVersion
    $wixExtensionVersion = (Get-VisualStudioPackages | Where-Object {$_.Id -match 'WixToolset.VisualStudioExtension.Dev' -and $_.type -eq 'vsix'}).Version

    # WDK
    $wdkPackageVersion = Get-VSExtensionVersion -packageName 'Microsoft.Windows.DriverKit'
    $wdkExtensionVersion = Get-WDKVersion

    $extensions = @(
        $vsixs
        @{Package = 'Windows Driver Kit'; Version = $wdkPackageVersion}
        @{Package = 'Windows Driver Kit Visual Studio Extension'; Version = $wdkExtensionVersion}
        @{Package = 'WIX Toolset'; Version = $wixPackageVersion}
        @{Package = "WIX Toolset Studio $vs Extension"; Version = $wixExtensionVersion}
    )

    $extensions | Foreach-Object {
        [PSCustomObject]$_
    } | Select-Object Package, Version | Sort-Object Package
}