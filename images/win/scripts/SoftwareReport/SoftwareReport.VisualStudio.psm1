using module ./SoftwareReport.Helpers.psm1

function Get-VisualStudioVersion {
    param (
        [ArchiveItems] $Archive
    )

    $vsInstance = Get-VisualStudioInstance
    $content = [PSCustomObject]@{
        Name = $vsInstance.DisplayName
        Version = $vsInstance.InstallationVersion
        Path = $vsInstance.InstallationPath
    }
    $Archive.SetHeader($content.Name, 3) | Out-Null
    $Archive.Add("$($content.Name)|$($content.Version)|$($content.Path)", ($content.Name).Replace(" ", "")) | Out-Null
    return $content
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
    $sdkVersion = Get-SDKVersion
    $sdkPackages = @(
        @{Package = 'Windows Software Development Kit'; Version = $sdkVersion}
    )

    # WDK
    $wdkVersion = Get-WDKVersion
    $wdkExtensionVersion = Get-VSExtensionVersion -packageName 'Microsoft.Windows.DriverKit'
    $wdkPackages = @(
        @{Package = 'Windows Driver Kit'; Version = $wdkVersion}
        @{Package = 'Windows Driver Kit Visual Studio Extension'; Version = $wdkExtensionVersion}
    )

    $extensions = @(
        $vsixs
        $ssdtPackages
        $sdkPackages
        $wdkPackages
    )

    $output = $extensions | Foreach-Object {
        [PSCustomObject]$_
    } | Select-Object Package, Version | Sort-Object Package
    $output | ForEach-Object { $Archive.Add("$($_.Package)|$($_.Version)", "VisualStudio_$($_.Package)".Replace(" ", "")) } | Out-Null

    return $output
}

function Get-WindowsSDKs {
    $path = "${env:ProgramFiles(x86)}\Windows Kits\10\Extension SDKs\WindowsDesktop"
    return [PSCustomObject]@{
        Path = $path
        Versions = $(Get-ChildItem $path).Name
    }
}