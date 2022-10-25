function Initialize-RustEnvironment {
    $env:RUSTUP_HOME = "C:\Users\Default\.rustup"
    $env:CARGO_HOME = "C:\Users\Default\.cargo"
    $env:Path += ";$env:CARGO_HOME\bin"
}

function Get-OSName {
    return (Get-CimInstance -ClassName Win32_OperatingSystem).Caption
}

function Get-OSVersion {
    $OSVersion = (Get-CimInstance -ClassName Win32_OperatingSystem).Version
    $OSBuild = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion' UBR).UBR
    return "OS Version: $OSVersion Build $OSBuild"
}

function Get-BashVersion {
    $version = bash --% -c 'echo ${BASH_VERSION}'
    return "Bash $version"
}

function Get-RustVersion {
    Initialize-RustEnvironment
    $rustVersion = [regex]::matches($(rustc --version), "\d+\.\d+\.\d+").Value
    return $rustVersion
}

function Get-RustupVersion {
    $rustupInfo = cmd /c "rustup --version 2>NUL"
    $version = [regex]::matches($rustupInfo, "\d+\.\d+\.\d+").Value
    return $version
}

function Get-RustCargoVersion {
    $version = [regex]::matches($(cargo --version), "\d+\.\d+\.\d+").Value
    return $version
}

function Get-RustdocVersion {
    $version = [regex]::matches($(rustdoc --version), "\d+\.\d+\.\d+").Value
    return $version
}

function Get-RustfmtVersion {
    $version = [regex]::matches($(rustfmt --version), "\d+\.\d+\.\d+").Value
    return $version
}

function Get-RustClippyVersion {
    $version = [regex]::matches($(cargo clippy  --version), "\d+\.\d+\.\d+").Value
    return $version
}

function Get-BindgenVersion {
    return bindgen --version
}

function Get-CbindgenVersion {
    return cbindgen --version
}

function Get-CargoAuditVersion {
    return cargo-audit --version
}

function Get-CargoOutdatedVersion {
    return cargo outdated --version
}

function Get-PythonVersion {
    return & python --version
}

function Get-PowershellCoreVersion {
    return & pwsh --version
}

function Get-RubyVersion {
    $rubyVersion = $(ruby --version).split(" ")[1]
    return "Ruby $rubyVersion"
}

function Get-GoVersion {
    $(go version) -match "go(?<version>\d+\.\d+\.\d+)" | Out-Null
    $goVersion = $Matches.Version
    return "Go $goVersion"
}

function Get-KotlinVersion {
    $kotlinVersion = $((cmd /c "kotlinc  -version 2>&1") | Out-String).split(" ")[2]
    return "Kotlin $kotlinVersion"
}

function Get-PHPVersion {
    ($(php --version) | Out-String) -match "PHP (?<version>\d+\.\d+\.\d+)" | Out-Null
    $phpVersion = $Matches.Version
    return "PHP $phpVersion"
}

function Get-JuliaVersion {
    $juliaVersion = [regex]::matches($(julia --version), "\d+\.\d+\.\d+").Value
    return "Julia $juliaVersion"
}

function Get-LLVMVersion {
    $llvmVersion = [regex]::matches($(clang --version), "\d+\.\d+\.\d+").Value
    return "LLVM $llvmVersion"
}

function Get-PerlVersion {
    ($(perl --version) | Out-String) -match "\(v(?<version>\d+\.\d+\.\d+)\)" | Out-Null
    $perlVersion = $Matches.Version
    return "Perl $perlVersion"
}

function Get-NodeVersion {
    $nodeVersion = $(node --version).split("v")[1]
    return "Node $nodeVersion"
}

function Get-ChocoVersion {
    return "Chocolatey $(choco --version)"
}

function Get-VcpkgVersion {
    $commitId = git -C "C:\vcpkg" rev-parse --short HEAD
    return "Vcpkg (build from master \<$commitId>)"
}

function Get-NPMVersion {
    return "NPM $(npm -version)"
}

function Get-YarnVersion {
    return "Yarn $(yarn -version)"
}

function Get-RubyGemsVersion {
    return "RubyGems $(gem --version)"
}

function Get-HelmVersion {
    ($(helm version --short) | Out-String) -match "v(?<version>\d+\.\d+\.\d+)" | Out-Null
    $helmVersion = $Matches.Version
    return "Helm $helmVersion"
}

function Get-PipVersion {
    ($(pip --version) | Out-String) -match "(?<version>pip [\d\.]+) .+ (?<python>\(python [\d\.]+\))" | Out-Null
    $pipVersion = $Matches.Version
    $pythonVersion = $Matches.Python
    return "$pipVersion $pythonVersion"
}

function Get-CondaVersion {
    $condaVersion = & "$env:CONDA\Scripts\conda.exe" --version
    return "Mini$condaVersion (pre-installed on the image but not added to PATH)"
}

function Get-ComposerVersion {
    composer --version | Take-Part -Part 0,2
}

function Get-NugetVersion {
    (nuget help) -match "NuGet Version" -replace "Version: "
}

function Get-AntVersion {
    ($(ant -version) | Out-String) -match "version (?<version>\d+\.\d+\.\d+)" | Out-Null
    $antVersion = $Matches.Version
    return "Ant $antVersion"
}

function Get-MavenVersion {
    ($(mvn -version) | Out-String) -match "Apache Maven (?<version>\d+\.\d+\.\d+)" | Out-Null
    $mavenVersion = $Matches.Version
    return "Maven $mavenVersion"
}

function Get-GradleVersion {
    ($(gradle -version) | Out-String) -match "Gradle (?<version>\d+\.\d+)" | Out-Null
    $gradleVersion = $Matches.Version
    return "Gradle $gradleVersion"
}

function Get-SbtVersion {
    $sbtVersion = (sbt -version) -match "sbt script version:" -replace "script version: "
    return "$sbtVersion"
}

function Get-DotnetSdks {
    $sdksRawList = dotnet --list-sdks
    $sdkVersions = ($sdksRawList | Foreach-Object {$_.Split()[0]}) -join ' '
    $sdkPath = $sdksRawList[0].Split(' ', 2)[1] -replace '\[|]'
    [PSCustomObject]@{
        Versions = $sdkVersions
        Path = $sdkPath
    }
}

function Get-DotnetTools {
    $env:Path += ";C:\Users\Default\.dotnet\tools"
    $dotnetTools = (Get-ToolsetContent).dotnet.tools

    $toolsList = @()

    foreach  ($dotnetTool in $dotnetTools) {
        $toolsList += $dotnetTool.name + " " + (Invoke-Expression $dotnetTool.getversion)
    }
    return $toolsList
}

function Get-DotnetRuntimes {
    $runtimesRawList = dotnet --list-runtimes
    $runtimesRawList | Group-Object {$_.Split()[0]} | ForEach-Object {
        $runtimeName = $_.Name
        $runtimeVersions = ($_.Group | Foreach-Object {$_.split()[1]}) -join ' '
        $runtimePath = $_.Group[0].Split(' ', 3)[2] -replace '\[|]'
        [PSCustomObject]@{
            "Runtime" = $runtimeName
            "Versions" = $runtimeVersions
            "Path" = $runtimePath
        }
    }
}

function Get-DotnetFrameworkTools {
    $path = "${env:ProgramFiles(x86)}\Microsoft SDKs\Windows\*\*\NETFX*"
    Get-ChildItem -Path $path -Directory | Group-Object {
        $_.Fullname -Replace " \d+\.\d+(\.\d+)?", " <version>"
    } | ForEach-Object {
        [PSCustomObject]@{
            Versions =  $_.Group.Name | ForEach-Object { $_.Split(" ")[1] }
            Path = $_.Name
        }
    }
}

function Get-PowerShellAzureModules {
    # Module names
    $names = @{
        'az' = 'Az'
        'azurerm' = 'AzureRM'
        'azure' = 'Azure'
    }

    # Get default module version
    $defaults = @{
        'azurerm' = (Get-Module -Name AzureRM -ListAvailable).Version
        'azure' = (Get-Module -Name Azure -ListAvailable).Version
    }

    $modulesPath = "C:\Modules"
    $modules = Get-ChildItem -Path $modulesPath | Sort-Object Name |  Group-Object {$_.Name.Split('_')[0]}
    $modules | ForEach-Object {
        $group = $_.group | Sort-Object {[Version]$_.Name.Split('_')[1].Replace(".zip","")}
        $moduleName = $names[$_.Name]
        $moduleVersions = $group | ForEach-Object {$_.Name.Split('_')[1]}
        $moduleVersions = $moduleVersions -join '<br>'
        $modulePath = (($group.FullName).Split("_"))[0] + '_\<version\>'

        # set default version
        $defaultVersion = $defaults[$_.Name]
        if ($defaultVersion) {
            $moduleVersions = $moduleVersions.Replace($defaultVersion, "$defaultVersion [Installed]")
        }

        [PSCustomObject]@{
            Module = $moduleName
            Version = $moduleVersions
            Path = $modulePath
        }
    }
}

function Get-PowerShellModules {
    $modules = (Get-ToolsetContent).powershellModules.name

    $psModules = Get-Module -Name $modules -ListAvailable | Sort-Object Name | Group-Object Name
    $psModules | ForEach-Object {
        $moduleName = $_.Name
        $moduleVersions = ($_.group.Version | Sort-Object -Unique) -join '<br>'

        [PSCustomObject]@{
            Module = $moduleName
            Version = $moduleVersions
        }
    }
}

function Get-CachedDockerImages {
    return (docker images --digests --format "* {{.Repository}}:{{.Tag}}").Split("*") | Where-Object { $_ }
}

function Get-CachedDockerImagesTableData {
    $allImages = docker images --digests --format "*{{.Repository}}:{{.Tag}}|{{.Digest}} |{{.CreatedAt}}"
    if (-not $allImages) {
        return $null
    }

    $allImages.Split("*") | Where-Object { $_ } | ForEach-Object {
        $parts = $_.Split("|")
        [PSCustomObject] @{
            "Repository:Tag" = $parts[0]
            "Digest" = $parts[1]
            "Created" = $parts[2].split(' ')[0]
        }
    } | Sort-Object -Property "Repository:Tag"
}

function Get-ShellTarget {
    $shells = Get-ChildItem C:\shells -File | Select-Object Name, @{n="Target";e={
        if ($_.Name -eq "msys2bash.cmd") {
            "C:\msys64\usr\bin\bash.exe"
        } else {
            @($_.Target)[0]
        }
    }} | Sort-Object Name
    $shells | New-MDTable -Columns ([ordered]@{Name = "left"; Target = "left";})
}

function Get-PacmanVersion {
    $msys2BinDir = "C:\msys64\usr\bin"
    $pacmanPath = Join-Path $msys2BinDir "pacman.exe"
    $rawVersion = & $pacmanPath --version
    $rawVersion.Split([System.Environment]::NewLine)[1] -match "\d+\.\d+(\.\d+)?" | Out-Null
    $pacmanVersion = $matches[0]
    return "Pacman $pacmanVersion"
}

function Get-YAMLLintVersion {
    yamllint --version
}

function Get-BizTalkVersion {
    $bizTalkReg = Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\BizTalk Server\3.0"
    return "$($bizTalkReg.ProductName) $($bizTalkReg.ProductVersion)"
}

function Get-PipxVersion {
    $pipxVersion = pipx --version
    return "Pipx $pipxVersion"
}

function Build-PackageManagementEnvironmentTable {
    $envVariables = @(
        @{
            "Name" = "VCPKG_INSTALLATION_ROOT"
            "Value" = $env:VCPKG_INSTALLATION_ROOT
        }
    )
    if (Test-IsWin19) {
        $envVariables += @(
            @{
                "Name" = "CONDA"
                "Value" = $env:CONDA
            }
        )
    }
    return $envVariables | ForEach-Object {
        [PSCustomObject] @{
            "Name" = $_.Name
            "Value" = $_.Value
        }
    }
}
