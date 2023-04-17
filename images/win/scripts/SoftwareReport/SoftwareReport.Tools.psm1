function Get-Aria2Version {
    (aria2c -v | Out-String) -match "(?<version>(\d+\.){1,}\d+)" | Out-Null
    $aria2Version = $Matches.Version
    return $aria2Version
}

function Get-AzCosmosDBEmulatorVersion {
    $regKey = gci HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | gp | ? { $_.DisplayName -eq 'Azure Cosmos DB Emulator' }
    $installDir = $regKey.InstallLocation
    $exeFilePath = Join-Path $installDir 'CosmosDB.Emulator.exe'
    $version = (Get-Item $exeFilePath).VersionInfo.FileVersion
    return $version
}

function Get-BazelVersion {
    ((cmd /c "bazel --version 2>&1") | Out-String) -match "bazel (?<version>\d+\.\d+\.\d+)" | Out-Null
    $bazelVersion = $Matches.Version
    return $bazelVersion
}

function Get-BazeliskVersion {
    ((cmd /c "bazelisk version 2>&1") | Out-String) -match "Bazelisk version: v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $bazeliskVersion = $Matches.Version
    return $bazeliskVersion
}

function Get-BicepVersion {
    (bicep --version | Out-String) -match  "bicep cli version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $bicepVersion = $Matches.Version
    return $bicepVersion
}

function Get-RVersion {
    ($(cmd /c "Rscript --version 2>&1") | Out-String) -match "Rscript .* version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $rVersion = $Matches.Version
    return $rVersion
}

function Get-CMakeVersion {
    ($(cmake -version) | Out-String) -match  "cmake version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $cmakeVersion = $Matches.Version
    return $cmakeVersion
}

function Get-CodeQLBundleVersions {
    $CodeQLVersionsWildcard = Join-Path $Env:AGENT_TOOLSDIRECTORY -ChildPath "CodeQL" | Join-Path -ChildPath "*"
    $CodeQLVersionPaths = Get-ChildItem $CodeQLVersionsWildcard 
    $CodeQlVersions=@()
    foreach ($CodeQLVersionPath in $CodeQLVersionPaths) {
        $FullCodeQLVersionPath = $CodeQLVersionPath | Select-Object -Expand FullName
        $CodeQLPath = Join-Path $FullCodeQLVersionPath -ChildPath "x64" | Join-Path -ChildPath "codeql" | Join-Path -ChildPath "codeql.exe"
        $CodeQLVersion = & $CodeQLPath version --quiet
        $CodeQLVersions += $CodeQLVersion
    }
    return $CodeQLVersions
}

function Get-DockerVersion {
    $dockerVersion = $(docker version --format "{{.Server.Version}}")
    return $dockerVersion
}

function Get-DockerComposeVersion {
    $dockerComposeVersion = docker-compose version --short
    return $dockerComposeVersion
}

function Get-DockerComposeVersionV2 {
    $dockerComposeVersion = docker compose version --short
    return $dockerComposeVersion
}

function Get-DockerWincredVersion {
    $dockerCredVersion = docker-credential-wincred version | Take-Part -Part 2 | Take-Part -Part 0 -Delimiter "v"
    return $dockerCredVersion
}

function Get-GitVersion {
    $gitVersion = git --version | Take-Part -Part -1
    return $gitVersion
}

function Get-GitLFSVersion {
    $(git-lfs version) -match "git-lfs\/(?<version>\d+\.\d+\.\d+)" | Out-Null
    $gitLfsVersion = $Matches.Version
    return $gitLfsVersion
}

function Get-InnoSetupVersion {
    $innoSetupVersion = $(choco list --local-only innosetup) | Select-String -Pattern "InnoSetup"
    return ($innoSetupVersion -replace "^InnoSetup").Trim()
}

function Get-JQVersion {
    $jqVersion = ($(jq --version) -Split "jq-")[1]
    return $jqVersion
}

function Get-KubectlVersion {
    $kubectlVersion = (kubectl version --client --output=json | ConvertFrom-Json).clientVersion.gitVersion.Replace('v','')
    return $kubectlVersion
}

function Get-KindVersion {
    $(kind version) -match "kind v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $kindVersion = $Matches.Version
    return $kindVersion
}

function Get-MinGWVersion {
    (gcc --version | Select-String -Pattern "MinGW-W64") -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $mingwVersion = $Matches.Version
    return $mingwVersion
}

function Get-MySQLVersion {
    $mysqlCommand = Get-Command -Name "mysql"
    $mysqlVersion = $mysqlCommand.Version.ToString()
    return $mysqlVersion
}

function Get-SQLOLEDBDriverVersion {
    $SQLOLEDBDriverVersion = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSOLEDBSQL' InstalledVersion).InstalledVersion
    return $SQLOLEDBDriverVersion
}

function Get-MercurialVersion {
    ($(hg --version) | Out-String) -match "version (?<version>\d+\.\d+\.?\d*)" | Out-Null
    $mercurialVersion = $Matches.Version
    return $mercurialVersion
}

function Get-NSISVersion {
    $nsisVersion =  &"c:\Program Files (x86)\NSIS\makensis.exe" "/Version"
    return $nsisVersion.TrimStart("v")
}

function Get-OpenSSLVersion {
    $(openssl version) -match "OpenSSL (?<version>\d+\.\d+\.\d+\w?) " | Out-Null
    $opensslVersion = $Matches.Version
    return $opensslVersion
}

function Get-PackerVersion {
    return "Packer $(packer --version)"
}

function Get-ParcelVersion {
    $parcelVersion = parcel --version
    return "$parcelVersion"
}

function Get-PulumiVersion {
    return (pulumi version).TrimStart("v")
}

function Get-SQLPSVersion {
    $module = Get-Module -Name SQLPS -ListAvailable
    $version = $module.Version
    return $version
}

function Get-SVNVersion {
    $svnVersion = $(svn --version --quiet)
    return $svnVersion
}

function Get-VSWhereVersion {
    ($(Get-Command -Name vswhere).FileVersionInfo.ProductVersion) -match "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $vswhereVersion = $Matches.Version
    return $vswhereVersion
}

function Get-WinAppDriver {
    $winAppDriverVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo("C:\Program Files (x86)\Windows Application Driver\WinAppDriver.exe").FileVersion
    return $winAppDriverVersion
}

function Get-WixVersion {
    $regKey = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $installedApplications = Get-ItemProperty -Path $regKey
    $wixToolsetVersion = ($installedApplications | Where-Object { $_.BundleCachePath -imatch ".*\\WiX\d*\.exe$" } | Select-Object -First 1).DisplayName
    return ($wixToolsetVersion -replace "^WiX Toolset v").Trim()
}

function Get-ZstdVersion {
    $(zstd --version) -match "v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $zstdVersion = $Matches.Version
    return $zstdVersion
}

function Get-AzureCLIVersion {
    $azureCLIVersion = $(az version) | ConvertFrom-Json | Foreach{ $_."azure-cli" }
    return $azureCLIVersion
}

function Get-AzCopyVersion {
    return ($(azcopy --version) -replace "^azcopy version").Trim()
}

function Get-AzureDevopsExtVersion {
    $azureDevExtVersion = (az version | ConvertFrom-Json | ForEach-Object { $_."extensions" })."azure-devops"
    return $azureDevExtVersion
}

function Get-AWSCLIVersion {
    $(aws --version) -match "aws-cli\/(?<version>\d+\.\d+\.\d+)" | Out-Null
    $awscliVersion = $Matches.Version
    return $awscliVersion
}

function Get-AWSSAMVersion {
    $(sam --version) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $awssamVersion = $Matches.Version
    return $awssamVersion
}

function Get-AWSSessionManagerVersion {
    $awsSessionManagerVersion = $(session-manager-plugin --version)
    return $awsSessionManagerVersion
}

function Get-AlibabaCLIVersion {
    $alicliVersion = $(aliyun version)
    return $alicliVersion
}

function Get-CloudFoundryVersion {
    $(cf version) -match  "(?<version>\d+\.\d+\.\d+)" | Out-Null
    $cfVersion = $Matches.Version
    return $cfVersion
}

function Get-HubVersion {
    ($(hub version) | Select-String -Pattern "hub version") -match "hub version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $hubVersion = $Matches.Version
    return $hubVersion
}

function Get-7zipVersion {
    (7z | Out-String) -match "7-Zip (?<version>\d+\.\d+\.?\d*)" | Out-Null
    $version = $Matches.Version
    return $version
}

function Get-GHCVersion {
    ((ghc --version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $ghcVersion = $Matches.Version
    return $ghcVersion
}

function Get-CabalVersion {
    ((cabal --version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+\.\d+)" | Out-Null
    $cabalVersion = $Matches.Version
    return $cabalVersion
}

function Get-StackVersion {
    ((stack --version --quiet) | Out-String) -match "Version (?<version>\d+\.\d+\.\d+)," | Out-Null
    $stackVersion = $Matches.Version
    return $stackVersion
}

function Get-GoogleCloudSDKVersion {
    return (((cmd /c "gcloud --version") -match "Google Cloud SDK") -replace "Google Cloud SDK").Trim()
}

function Get-ServiceFabricSDKVersion {
    $serviceFabricSDKVersion = Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Service Fabric\' -Name FabricVersion
    return $serviceFabricSDKVersion
}

function Get-NewmanVersion {
    return $(newman --version)
}

function Get-GHVersion {
    ($(gh --version) | Select-String -Pattern "gh version") -match "gh version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $ghVersion = $Matches.Version
    return $ghVersion
}

function Get-VisualCPPComponents {
    $regKeys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    $vcpp = Get-ItemProperty -Path $regKeys | Where-Object DisplayName -like "Microsoft Visual C++*"
    $vcpp | Sort-Object DisplayName, DisplayVersion | ForEach-Object {
        $isMatch = $_.DisplayName -match "^(?<Name>Microsoft Visual C\+\+ \d{4})\s+(?<Arch>\w{3})\s+(?<Ext>.+)\s+-"
        if ($isMatch) {
            $name = '{0} {1}' -f $matches["Name"], $matches["Ext"]
            $arch = $matches["Arch"].ToLower()
            $version = $_.DisplayVersion
            [PSCustomObject]@{
                Name = $name
                Architecture = $arch
                Version = $version
            }
        }
    }
}

function Get-DacFxVersion {
    $dacfxversion = & "$env:ProgramFiles\Microsoft SQL Server\160\DAC\bin\sqlpackage.exe" /version
    return $dacfxversion
}

function Get-SwigVersion {
    (swig -version | Out-String) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $swigVersion = $Matches.Version
    return $swigVersion
}

function Get-ImageMagickVersion {
    (magick -version | Select-String -Pattern "Version") -match "(?<version>\d+\.\d+\.\d+-\d+)" | Out-Null
    $magickVersion = $Matches.Version
    return $magickVersion
}
