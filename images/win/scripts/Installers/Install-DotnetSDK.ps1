################################################################################
##  File:  Install-DotnetSDK.ps1
##  Desc:  Install all released versions of the dotnet sdk and populate package
##         cache.  Should run after VS and Node
################################################################################

# ensure temp
New-Item -Path C:\Temp -Force -ItemType Directory

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor "Tls12"

$templates = @(
    'console',
    'mstest',
    'web',
    'mvc',
    'webapi'
)

function InstallSDKVersion (
    $sdkVersion
)
{
    if (!(Test-Path -Path "C:\Program Files\dotnet\sdk\$sdkVersion"))
    {
        Write-Host "Installing dotnet $sdkVersion"
        .\dotnet-install.ps1 -Architecture x64 -Version $sdkVersion -InstallDir $(Join-Path -Path $env:ProgramFiles -ChildPath 'dotnet')
    }
    else
    {
        Write-Host "Sdk version $sdkVersion already installed"
    }

    # Fix for issue 1276.  This will be fixed in 3.1.
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dotnet/sdk/82bc30c99f1325dfaa7ad450be96857a4fca2845/src/Tasks/Microsoft.NET.Build.Tasks/targets/Microsoft.NET.Sdk.ImportPublishProfile.targets" -outfile "C:\Program Files\dotnet\sdk\$sdkVersion\Sdks\Microsoft.NET.Sdk\targets\Microsoft.NET.Sdk.ImportPublishProfile.targets"

    # warm up dotnet for first time experience
    $templates | ForEach-Object {
        $template = $_
        $projectPath = Join-Path -Path C:\temp -ChildPath $template
        New-Item -Path $projectPath -Force -ItemType Directory
        Push-Location -Path $projectPath
        & $env:ProgramFiles\dotnet\dotnet.exe new globaljson --sdk-version "$sdkVersion"
        & $env:ProgramFiles\dotnet\dotnet.exe new $template
        Pop-Location
        Remove-Item $projectPath -Force -Recurse
    }
}

function InstallAllValidSdks()
{
    Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/dotnet/core/master/release-notes/releases-index.json' -UseBasicParsing -OutFile 'releases-index.json'
    $dotnetChannels = Get-Content -Path 'releases-index.json' | ConvertFrom-Json

    # Consider all channels except preview/eol channels.
    # Sort the channels in ascending order
    # HACK: Explicitly adding eol channel 2.2 for a grace period as this channel is wierdly marked as eol with no higher 2.x channel
    $dotnetChannels = $dotnetChannels.'releases-index' | Where-Object { (!$_."support-phase".Equals('preview') -and !$_."support-phase".Equals('eol')) -or ($_."channel-version" -eq "2.2") } | Sort-Object { [Version] $_."channel-version" }

    # Download installation script.
    Invoke-WebRequest -Uri 'https://dot.net/v1/dotnet-install.ps1' -UseBasicParsing -OutFile 'dotnet-install.ps1'

    ForEach ($dotnetChannel in $dotnetChannels)
    {
        $channelVersion = $dotnetChannel.'channel-version';
        Invoke-WebRequest -Uri $dotnetChannel.'releases.json' -UseBasicParsing -OutFile "releases-$channelVersion.json"
        $currentReleases = Get-Content -Path "releases-$channelVersion.json" | ConvertFrom-Json
        # filtering out the preview/rc releases
        $currentReleases = $currentReleases.'releases' | Where-Object { !$_.'release-version'.Contains('-') } | Sort-Object { [Version] $_.'release-version' }

        ForEach ($release in $currentReleases)
        {
            if ($release.'sdks'.Count -gt 0)
            {
                Write-Host 'Found sdks property in release: ' + $release.'release-version' + 'with sdks count: ' + $release.'sdks'.Count


                # Remove duplicate entries & preview/rc version from download list
                # Sort the sdks on version
                $sdks = @($release.'sdk');

                $sdks += $release.'sdks' | Where-Object { !$_.'version'.Contains('-') -and !$_.'version'.Equals($release.'sdk'.'version') }
                $sdks = $sdks | Sort-Object { [Version] $_.'version' }

                ForEach ($sdk in $sdks)
                {
                    InstallSDKVersion -sdkVersion $sdk.'version'
                }
            }
            elseif (!$release.'sdk'.'version'.Contains('-'))
            {
                $sdkVersion = $release.'sdk'.'version'
                InstallSDKVersion -sdkVersion $sdkVersion
            }
        }
    }
}

function RunPostInstallationSteps()
{
    Add-MachinePathItem "C:\Program Files\dotnet"
    # Run script at startup for all users
    $cmdDotNet = 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -Command "[System.Environment]::SetEnvironmentVariable(''PATH'',"""$env:USERPROFILE\.dotnet\tools;$env:PATH""", ''USER'')"'

    # Update Run key to run a script at logon
    Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "DOTNETUSERPATH" -Value $cmdDotNet
}

InstallAllValidSdks
RunPostInstallationSteps
