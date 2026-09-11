################################################################################
##  File:  Invoke-WindowsResolverPreflight.ps1
##  Desc:  Validates Windows image dependency resolution without provisioning.
################################################################################

[CmdletBinding()]
param(
    [string] $RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot "../../../..")).Path,
    [ValidateSet("Windows2022", "Windows2025", "Windows2025VS2026", "Windows11Arm64", "Windows11VS2026Arm64")]
    [string] $Image,
    [string] $TemplatePath,
    [string] $ToolsetPath,
    [string] $ScriptsRoot,
    [ValidateSet("x64", "arm64")]
    [string] $Architecture,
    [string] $GitHubToken = $env:GITHUB_TOKEN,
    [switch] $SkipNetwork
)

$ErrorActionPreference = "Stop"
$defaultRepositoryRoot = $RepositoryRoot
$imageConfigurations = @{
    "Windows2022" = @{ Template = "build.windows-2022.pkr.hcl"; Toolset = "toolset-2022.json"; Architecture = "x64" }
    "Windows2025" = @{ Template = "build.windows-2025.pkr.hcl"; Toolset = "toolset-2025.json"; Architecture = "x64" }
    "Windows2025VS2026" = @{ Template = "build.windows-2025-vs2026.pkr.hcl"; Toolset = "toolset-2025-vs2026.json"; Architecture = "x64" }
    "Windows11Arm64" = @{ Template = "build.windows-11-arm64.pkr.hcl"; Toolset = "toolset-win-11-arm64.json"; Architecture = "arm64" }
    "Windows11VS2026Arm64" = @{ Template = "build.windows-11-vs2026-arm64.pkr.hcl"; Toolset = "toolset-win-11-vs2026-arm64.json"; Architecture = "arm64" }
}

function Invoke-PreflightRequest {
    <#
    .SYNOPSIS
        Sends a bounded, retrying request to a dependency endpoint.
    #>
    param(
        [Parameter(Mandatory)]
        [string] $Uri,
        [string] $Method = "Get",
        [hashtable] $Headers = @{},
        [switch] $AllowNotFound,
        [int] $RetryCount = 3
    )

    for ($attempt = 1; $attempt -le $RetryCount; $attempt++) {
        try {
            $requestParameters = @{
                Uri             = $Uri
                Method          = $Method
                Headers         = $Headers
                UseBasicParsing = $true
                TimeoutSec      = 30
            }
            return Invoke-WebRequest @requestParameters
        } catch {
            $statusCode = $_.Exception.Response.StatusCode.value__
            if ($AllowNotFound -and $statusCode -eq 404) {
                return $false
            }
            $isDeterministic = $statusCode -in 400, 401, 403, 404
            if ($isDeterministic -or $attempt -eq $RetryCount) {
                throw "Request to '$Uri' failed on attempt $attempt of $RetryCount (HTTP $statusCode): $($_.Exception.Message)"
            }

            Start-Sleep -Seconds (2 * $attempt)
        }
    }
}

function Assert-PowerShellSyntax {
    <#
    .SYNOPSIS
        Verifies that all Windows PowerShell scripts parse without errors.
    #>
    param(
        [Parameter(Mandatory)]
        [string] $ScriptsRoot
    )

    $scripts = Get-ChildItem -Path $ScriptsRoot -Recurse -Filter "*.ps1"
    if (-not $scripts) {
        throw "No PowerShell scripts found under '$ScriptsRoot'."
    }

    Write-Host "Checking PowerShell syntax for $($scripts.Count) scripts under '$ScriptsRoot'."
    $parseErrors = @()
    $scripts | ForEach-Object {
        $tokens = $null
        $errors = $null
        [void] [System.Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref] $tokens, [ref] $errors)
        $parseErrors += $errors
    }

    if ($parseErrors) {
        throw "PowerShell parser errors:`n$($parseErrors | Out-String)"
    }

    Write-Host "PowerShell syntax check passed."
}

function Assert-TemplateReferences {
    <#
    .SYNOPSIS
        Verifies that local Packer template inputs exist in the repository.
    #>
    param(
        [Parameter(Mandatory)]
        [string] $TemplatePath
    )

    $templateContent = Get-Content -Path $TemplatePath -Raw
    $templateDirectory = [System.IO.Path]::GetFullPath((Split-Path -Path $TemplatePath -Parent))
    $references = [regex]::Matches($templateContent, '"(?<path>\$\{path\.root\}[^\"]+)"') |
        ForEach-Object { $_.Groups['path'].Value } |
        Sort-Object -Unique

    $generatedReportDestinations = @(
        '${path.root}/../Windows2022-Readme.md',
        '${path.root}/../software-report.json'
    )

    $referencesToCheck = $references | Where-Object { $_ -notin $generatedReportDestinations }
    Write-Host "Checking $($referencesToCheck.Count) Packer template references in '$TemplatePath'."

    foreach ($reference in $referencesToCheck) {
        $relativeReferencePath = $reference.Substring('${path.root}'.Length).TrimStart([char[]] @('/', '\'))
        $resolvedPath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($templateDirectory, $relativeReferencePath))
        if (-not (Test-Path -Path $resolvedPath)) {
            throw "Packer template reference does not exist: '$reference' (resolved to '$resolvedPath')."
        }
    }

    Write-Host "Packer template reference check passed."
}

function Assert-ToolcacheAssets {
    <#
    .SYNOPSIS
        Verifies that requested Windows toolcache assets resolve from manifests.
    #>
    param(
        [Parameter(Mandatory)]
        [object] $Toolset
    )

    foreach ($tool in $Toolset.toolcache | Where-Object { $_.url }) {
        $manifest = (Invoke-PreflightRequest -Uri $tool.url).Content | ConvertFrom-Json
        foreach ($version in $tool.versions) {
            $asset = $manifest |
                Where-Object { $_.version -like $version -and $_.version -as [version] } |
                Select-Object -ExpandProperty files |
                Where-Object {
                    $_.platform -eq $tool.platform -and
                    $_.arch -eq $tool.arch -and
                    $_.toolset -eq $tool.toolset
                } |
                Select-Object -First 1

            if (-not $asset -or -not $asset.download_url) {
                throw "No toolcache asset resolves for $($tool.name) $version ($($tool.platform)/$($tool.arch))."
            }
        }
    }
}

function Get-PackageFeedVersions {
    <#
    .SYNOPSIS
        Gets the published versions of a package from a NuGet V2-compatible feed.
    #>
    param(
        [Parameter(Mandatory)]
        [string] $FeedUri,
        [Parameter(Mandatory)]
        [string] $PackageName
    )

    $encodedPackageName = [uri]::EscapeDataString($PackageName)
    $content = (Invoke-PreflightRequest -Uri "$FeedUri/FindPackagesById()?id='$encodedPackageName'").Content
    $versions = [regex]::Matches($content, '<d:Version(?:\s[^>]*)?>(?<version>[^<]+)</d:Version>') |
        ForEach-Object { $_.Groups['version'].Value } |
        Sort-Object -Unique

    return $versions
}

function Test-PackageFeedVersion {
    <#
    .SYNOPSIS
        Verifies that an exact package version resolves from a NuGet V2-compatible feed.
    #>
    param(
        [Parameter(Mandatory)]
        [string] $FeedUri,
        [Parameter(Mandatory)]
        [string] $PackageName,
        [Parameter(Mandatory)]
        [string] $Version
    )

    $encodedPackageName = [uri]::EscapeDataString($PackageName)
    $encodedVersion = [uri]::EscapeDataString($Version)
    $response = Invoke-PreflightRequest -Uri "$FeedUri/Packages(Id='$encodedPackageName',Version='$encodedVersion')" -AllowNotFound

    return [bool] $response
}

function Assert-ChocolateyPackages {
    <#
    .SYNOPSIS
        Verifies that configured Chocolatey packages and pinned versions resolve.
    #>
    param(
        [Parameter(Mandatory)]
        [object] $Toolset
    )

    foreach ($package in $Toolset.choco.common_packages) {
        if ($package.version -and -not (Test-PackageFeedVersion -FeedUri "https://community.chocolatey.org/api/v2" -PackageName $package.name -Version $package.version)) {
            throw "Chocolatey package '$($package.name)' does not provide requested version '$($package.version)'."
        }

        if (-not $package.version -and -not (Get-PackageFeedVersions -FeedUri "https://community.chocolatey.org/api/v2" -PackageName $package.name)) {
            throw "No Chocolatey package resolves for '$($package.name)'."
        }
    }
}

function Assert-PowerShellGalleryModules {
    <#
    .SYNOPSIS
        Verifies that configured PowerShell Gallery modules and pinned versions resolve.
    #>
    param(
        [Parameter(Mandatory)]
        [object] $Toolset
    )

    foreach ($module in $Toolset.powershellModules) {
        foreach ($version in $module.versions) {
            if (-not (Test-PackageFeedVersion -FeedUri "https://www.powershellgallery.com/api/v2" -PackageName $module.name -Version $version)) {
                throw "PowerShell Gallery module '$($module.name)' does not provide requested version '$version'."
            }
        }

        if (-not $module.versions -and -not (Get-PackageFeedVersions -FeedUri "https://www.powershellgallery.com/api/v2" -PackageName $module.name)) {
            throw "No PowerShell Gallery module resolves for '$($module.name)'."
        }
    }
}

function Assert-GitHubReleaseAssets {
    <#
    .SYNOPSIS
        Verifies that selected GitHub release asset patterns still resolve.
    #>
    param(
        [Parameter(Mandatory)]
        [object] $Toolset,
        [Parameter(Mandatory)]
        [ValidateSet("amd64", "arm64")]
        [string] $GitHubCliArchitecture,
        [switch] $IncludeDockerCompose,
        [switch] $IncludeDockerWinCred,
        [string] $GitHubToken
    )

    $headers = @{}
    if ($GitHubToken) {
        $headers.Authorization = "Bearer $GitHubToken"
    }

    $assetRequirements = @(
        @{ Repository = "actions/action-versions"; Version = "latest"; Pattern = "action-versions.zip" },
        @{ Repository = "cli/cli"; Version = "latest"; Pattern = "gh_*_windows_$GitHubCliArchitecture.msi" },
        @{ Repository = "microsoft/WSL"; Version = "latest"; Pattern = "wsl.*.x64.msi" },
        @{ Repository = "msys2/msys2-installer"; Version = "latest"; Pattern = "msys2-x86_64*.exe" },
        @{ Repository = "SeleniumHQ/selenium"; Version = "$($Toolset.selenium.version).*"; Pattern = "selenium-server-*.jar" },
        @{ Repository = "facebook/zstd"; Version = "latest"; Pattern = "zstd-*-win64.zip" }
    )

    if ($IncludeDockerCompose) {
        $assetRequirements += @{ Repository = "docker/compose"; Version = $Toolset.docker.components.compose; Pattern = "docker-compose-windows-x86_64.exe" }
    }
    if ($IncludeDockerWinCred) {
        $assetRequirements += @{ Repository = "docker/docker-credential-helpers"; Version = "latest"; Pattern = "docker-credential-wincred-*amd64.exe" }
    }

    foreach ($requirement in $assetRequirements) {
        $releases = (Invoke-PreflightRequest -Uri "https://api.github.com/repos/$($requirement.Repository)/releases?per_page=100" -Headers $headers).Content | ConvertFrom-Json
        $matchingReleases = $releases | Where-Object { -not $_.prerelease }
        if ($requirement.Version -eq "latest") {
            $matchingReleases = $matchingReleases | Select-Object -First 1
        } else {
            $matchingReleases = $matchingReleases | Where-Object { $_.tag_name -match ($requirement.Version -replace '\.', '\.' -replace '\*', '.*') }
        }

        $asset = $matchingReleases.assets | Where-Object { $_.name -like $requirement.Pattern } | Select-Object -First 1
        if (-not $asset) {
            throw "No GitHub release asset matches '$($requirement.Pattern)' for $($requirement.Repository) $($requirement.Version)."
        }
    }
}

function Assert-VsixMetadata {
    <#
    .SYNOPSIS
        Verifies that Visual Studio extension metadata and overrides resolve.
    #>
    param(
        [Parameter(Mandatory)]
        [object] $Toolset
    )

    $downloadOverrides = @{
        "ProBITools.MicrosoftReportProjectsforVisualStudio2022" = "https://download.microsoft.com/download/1fd275d8-5163-476b-910b-e2f678b3fdbc/Microsoft.DataTools.ReportingServices.vsix"
        "ProBITools.MicrosoftAnalysisServicesModelingProjects2022" = "https://download.microsoft.com/download/7c91cb5c-1e9c-4df7-a053-d2852e22c658/Microsoft.DataTools.AnalysisServices.vsix"
    }

    foreach ($extension in $Toolset.visualStudio.vsix) {
        if ($downloadOverrides.ContainsKey($extension)) {
            [void] (Invoke-PreflightRequest -Uri $downloadOverrides[$extension] -Method Head)
            continue
        }

        $content = (Invoke-PreflightRequest -Uri "https://marketplace.visualstudio.com/items?itemName=$extension").Content
        foreach ($field in "UniqueIdentifierValue", "VsixId", "AssetUri", "Microsoft.VisualStudio.Services.Payload.FileName") {
            if ($content -notmatch [regex]::Escape($field)) {
                throw "Visual Studio Marketplace response for '$extension' is missing '$field'."
            }
        }
    }
}

function Invoke-WindowsResolverPreflight {
    <#
    .SYNOPSIS
        Runs the Windows image dependency-resolution preflight.
    #>
    param(
        [ValidateSet("Windows2022", "Windows2025", "Windows2025VS2026", "Windows11Arm64", "Windows11VS2026Arm64")]
        [string] $Image,
        [string] $RepositoryRoot = $defaultRepositoryRoot,
        [string] $TemplatePath,
        [string] $ToolsetPath,
        [string] $ScriptsRoot,
        [ValidateSet("x64", "arm64")]
        [string] $Architecture,
        [string] $GitHubToken = $env:GITHUB_TOKEN,
        [switch] $SkipNetwork
    )

    if (-not $Image -and (-not $TemplatePath -or -not $ToolsetPath -or -not $ScriptsRoot)) {
        throw "Specify -Image or provide -TemplatePath, -ToolsetPath, and -ScriptsRoot."
    }

    if ($Image) {
        $imageConfiguration = $imageConfigurations[$Image]
        if (-not $Architecture) {
            $Architecture = $imageConfiguration.Architecture
        }
        if (-not $TemplatePath) {
            $TemplatePath = Join-Path $RepositoryRoot "images/windows/templates/$($imageConfiguration.Template)"
        }
        if (-not $ToolsetPath) {
            $ToolsetPath = Join-Path $RepositoryRoot "images/windows/toolsets/$($imageConfiguration.Toolset)"
        }
    }

    if (-not $ScriptsRoot) {
        $ScriptsRoot = Join-Path $RepositoryRoot "images/windows"
    }

    Write-Host "Starting Windows resolver preflight."
    if ($Image) {
        Write-Host "Selected image: $Image"
    } else {
        Write-Host "Selected image: custom effective paths"
    }
    Write-Host "Template path: $TemplatePath"
    Write-Host "Toolset path: $ToolsetPath"
    Write-Host "Scripts root: $ScriptsRoot"

    Assert-PowerShellSyntax -ScriptsRoot $ScriptsRoot
    Assert-TemplateReferences -TemplatePath $TemplatePath

    if ($SkipNetwork) {
        Write-Host "Skipping network dependency checks because -SkipNetwork was specified."
        Write-Host "Static Windows resolver preflight checks passed."
        return
    }

    if (-not $Architecture) {
        throw "Specify -Image or -Architecture for network dependency checks."
    }

    $gitHubCliArchitecture = if ($Architecture -eq "x64") { "amd64" } else { "arm64" }
    $templateContent = Get-Content -Path $TemplatePath -Raw
    $includeDockerCompose = $templateContent -match [regex]::Escape("Install-DockerCompose.ps1")
    $includeDockerWinCred = $templateContent -match [regex]::Escape("Install-DockerWinCred.ps1")

    $toolset = Get-Content -Path $ToolsetPath -Raw | ConvertFrom-Json
    Write-Host "Checking toolcache manifests."
    Assert-ToolcacheAssets -Toolset $toolset
    Write-Host "Checking Chocolatey packages."
    Assert-ChocolateyPackages -Toolset $toolset
    Write-Host "Checking PowerShell Gallery modules."
    Assert-PowerShellGalleryModules -Toolset $toolset
    Write-Host "Checking GitHub release assets."
    Assert-GitHubReleaseAssets -Toolset $toolset -GitHubCliArchitecture $gitHubCliArchitecture -IncludeDockerCompose:$includeDockerCompose -IncludeDockerWinCred:$includeDockerWinCred -GitHubToken $GitHubToken
    Write-Host "Checking Visual Studio extension metadata."
    Assert-VsixMetadata -Toolset $toolset

    Write-Host "Windows resolver preflight checks passed."
}

if ($MyInvocation.InvocationName -ne ".") {
    $preflightParameters = @{
        RepositoryRoot = $RepositoryRoot
        GitHubToken    = $GitHubToken
        SkipNetwork    = $SkipNetwork
    }

    foreach ($parameterName in "Image", "TemplatePath", "ToolsetPath", "ScriptsRoot", "Architecture") {
        $parameterValue = Get-Variable -Name $parameterName -ValueOnly
        if ($parameterValue) {
            $preflightParameters[$parameterName] = $parameterValue
        }
    }

    Invoke-WindowsResolverPreflight @preflightParameters
}
