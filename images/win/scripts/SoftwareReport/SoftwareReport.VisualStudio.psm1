function Get-VisualStudioVersion {
    $vsInstance = Get-VisualStudioInstance
    [PSCustomObject]@{
        Name = $vsInstance.DisplayName
        Version = $vsInstance.InstallationVersion
        Path = $vsInstance.InstallationPath
    }
}

function Get-SDKVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    ($installedApplications | Where-Object { $_.DisplayName -eq 'Windows SDK' } | Select-Object -First 1).DisplayVersion
}

function Get-WDKVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    ($installedApplications | Where-Object { $_.DisplayName -eq 'Windows Driver Kit' } | Select-Object -First 1).DisplayVersion
}

function Get-VisualStudioExtensions {
    $vsPackages = (Get-VisualStudioInstance).Packages

    # Additional vsixs
    $toolset = Get-ToolsetContent
    $vsixUrls = $toolset.visualStudio.vsix
    if ($vsixUrls)
    {
        $vsixs = $vsixUrls | ForEach-Object {
            $vsix = Get-VsixExtenstionFromMarketplace -ExtensionMarketPlaceName $_
            
            $vsixVersion = ($vsPackages | Where-Object {$_.Id -match $vsix.VsixId -and $_.type -eq 'vsix'}).Version
            @{
                Package = $vsix.ExtensionName
                Version = $vsixVersion
            }
        }
    }


    # SDK
    if (Test-IsWin19) {
        $sdkVersion = Get-SDKVersion
        $sdkPackages = @(
            @{Package = 'Windows Software Development Kit'; Version = $sdkVersion}
        )
    }

    if (Test-IsWin19) {
        # Wix
        $vs = (Get-VisualStudioVersion).Name.Split()[-1]
        $wixExtensionVersion = ($vsPackages | Where-Object {$_.Id -match 'WixToolset.VisualStudioExtension.Dev' -and $_.type -eq 'vsix'}).Version
        $wixPackages = @(
            @{Package = "WIX Toolset Studio $vs Extension"; Version = $wixExtensionVersion}
        )

        # WDK
        $wdkVersion = Get-WDKVersion
        $wdkExtensionVersion = Get-VSExtensionVersion -packageName 'Microsoft.Windows.DriverKit'
        $wdkPackages = @(
            @{Package = 'Windows Driver Kit'; Version = $wdkVersion}
            @{Package = 'Windows Driver Kit Visual Studio Extension'; Version = $wdkExtensionVersion}
        )
    }

    if (Test-IsWin22) {
        # WDK
        $wdkVersion = Get-WDKVersion
        $wdkPackages = @(
            @{Package = 'Windows Driver Kit'; Version = $wdkVersion}
        )
    }

    $extensions = @(
        $vsixs
        $ssdtPackages
        $sdkPackages
        $wixPackages
        $wdkPackages
    )

    $extensions | Foreach-Object {
        [PSCustomObject]$_
    } | Select-Object Package, Version | Sort-Object Package
}

function Get-WindowsSDKs {
    $path = "${env:ProgramFiles(x86)}\Windows Kits\10\Extension SDKs\WindowsDesktop"
    return [PSCustomObject]@{
        Path = $path
        Versions = $(Get-ChildItem $path).Name
    }
}