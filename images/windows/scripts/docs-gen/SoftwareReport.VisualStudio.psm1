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
    $vsixPackagesList = $toolset.visualStudio.vsix
    if ($vsixPackagesList) {
        $vsixs = $vsixPackagesList | ForEach-Object {
            $vsixPackage = Get-VsixInfoFromMarketplace $_
            $vsixVersion = ($vsPackages | Where-Object { $_.Id -match $vsixPackage.VsixId -and $_.type -eq 'vsix' }).Version
            @{
                Package = $vsixPackage.ExtensionName
                Version = $vsixVersion
            }
        }
    }

    # SDK
    $sdkVersion = Get-SDKVersion
    $sdkPackages = @(
        @{Package = 'Windows Software Development Kit'; Version = $sdkVersion }
    )

    # WDK
    if (-not (Test-IsWin25)) {
        $wdkVersion = Get-WDKVersion
        $wdkPackages = @(
            @{Package = 'Windows Driver Kit'; Version = $wdkVersion }
        )
    }

    # WDK extension
    $wdkExtensionVersion = Get-VSExtensionVersion -packageName 'Microsoft.Windows.DriverKit'
    $wdkExtensions = @(
        @{Package = 'Windows Driver Kit Visual Studio Extension'; Version = $wdkExtensionVersion }
    )

    $extensions = @(
        $vsixs
        $sdkPackages
        $wdkPackages
        $wdkExtensions
    )

    $extensions | Foreach-Object {
        [PSCustomObject] $_
    } | Select-Object Package, Version | Sort-Object Package
}

function Get-WindowsSDKs {
    $path = "${env:ProgramFiles(x86)}\Windows Kits\10\Extension SDKs\WindowsDesktop"
    return [PSCustomObject]@{
        Path     = $path
        Versions = $(Get-ChildItem $path).Name
    }
}
