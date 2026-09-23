Describe "Windows resolver preflight unit tests" {
    BeforeAll {
        . (Join-Path $PSScriptRoot ".." "Invoke-WindowsResolverPreflight.ps1")
    }

    Context "Invoke-PreflightRequest" {
        It "returns a successful response without retrying" {
            Mock Invoke-WebRequest { [PSCustomObject] @{ StatusCode = 200 } }

            $response = Invoke-PreflightRequest -Uri "https://example.test/dependency"

            $response.StatusCode | Should -Be 200
            Should -Invoke Invoke-WebRequest -Times 1 -Exactly
        }

        It "retries transient request failures before reporting the final error" {
            Mock Invoke-WebRequest { throw [System.Net.WebException]::new("Temporary network failure") }
            Mock Start-Sleep {}

            { Invoke-PreflightRequest -Uri "https://example.test/dependency" -RetryCount 3 } |
                Should -Throw "*attempt 3 of 3*"

            Should -Invoke Invoke-WebRequest -Times 3 -Exactly
            Should -Invoke Start-Sleep -Times 2 -Exactly
        }
    }

    Context "Assert-ToolcacheAssets" {
        BeforeEach {
            $toolset = [PSCustomObject] @{
                toolcache = @(
                    [PSCustomObject] @{
                        name = "ExampleTool"
                        url = "https://example.test/manifest.json"
                        versions = @("1.2.*")
                        platform = "win32"
                        arch = "x64"
                        toolset = $null
                    }
                )
            }
        }

        It "accepts an asset matching the requested version and platform" {
            $manifest = @(
                @{ version = "1.2.3"; files = @(@{ platform = "win32"; arch = "x64"; toolset = $null; download_url = "https://example.test/tool.zip" }) }
            ) | ConvertTo-Json -Depth 5
            Mock Invoke-PreflightRequest { [PSCustomObject] @{ Content = $manifest } }

            { Assert-ToolcacheAssets -Toolset $toolset } | Should -Not -Throw
        }

        It "fails when no matching asset is available" {
            $manifest = @(
                @{ version = "1.2.3"; files = @(@{ platform = "linux"; arch = "x64"; toolset = $null; download_url = "https://example.test/tool.tar.gz" }) }
            ) | ConvertTo-Json -Depth 5
            Mock Invoke-PreflightRequest { [PSCustomObject] @{ Content = $manifest } }

            { Assert-ToolcacheAssets -Toolset $toolset } |
                Should -Throw "No toolcache asset resolves for ExampleTool 1.2.* (win32/x64)."
        }
    }

    Context "Assert-GitHubReleaseAssets" {
        BeforeEach {
            $toolset = [PSCustomObject] @{
                docker = [PSCustomObject] @{
                    components = [PSCustomObject] @{ compose = "2.40.3" }
                }
                selenium = [PSCustomObject] @{ version = "4" }
            }
            $release = @(
                @{
                    tag_name = "v4.0.0"
                    prerelease = $false
                    assets = @(
                        @{ name = "action-versions.zip" }
                        @{ name = "gh_4.0.0_windows_amd64.msi" }
                        @{ name = "gh_4.0.0_windows_arm64.msi" }
                        @{ name = "docker-credential-wincred-v0.9.4-amd64.exe" }
                        @{ name = "wsl.2.0.0.x64.msi" }
                        @{ name = "msys2-x86_64-20250101.exe" }
                        @{ name = "selenium-server-4.0.0.jar" }
                        @{ name = "zstd-1.5.7-win64.zip" }
                    )
                }
            ) | ConvertTo-Json -Depth 5
            $dockerComposeRelease = @(
                @{
                    tag_name = "v2.40.3"
                    prerelease = $false
                    assets = @(@{ name = "docker-compose-windows-x86_64.exe" })
                }
            ) | ConvertTo-Json -Depth 5
            Mock Invoke-PreflightRequest {
                if ($Uri -like "*docker/compose*") {
                    return [PSCustomObject] @{ Content = $dockerComposeRelease }
                }

                return [PSCustomObject] @{ Content = $release }
            }
        }

        It "checks the selected ARM64 GitHub CLI asset without Docker assets" {
            { Assert-GitHubReleaseAssets -Toolset $toolset -GitHubCliArchitecture "arm64" -GitHubToken "test-token" } | Should -Not -Throw
            Should -Invoke Invoke-PreflightRequest -Times 6 -Exactly
            Should -Invoke Invoke-PreflightRequest -ParameterFilter { $Headers.Authorization -eq "Bearer test-token" } -Times 6 -Exactly
            Should -Invoke Invoke-PreflightRequest -ParameterFilter { $Uri -like "*docker/compose*" -or $Uri -like "*docker-credential-helpers*" } -Times 0 -Exactly
        }

        It "fails when the pinned Docker Compose release is unavailable" {
            $wrongDockerComposeRelease = @(
                @{
                    tag_name = "v2.40.4"
                    prerelease = $false
                    assets = @(@{ name = "docker-compose-windows-x86_64.exe" })
                }
            ) | ConvertTo-Json -Depth 5
            Mock Invoke-PreflightRequest { [PSCustomObject] @{ Content = $wrongDockerComposeRelease } } -ParameterFilter { $Uri -like "*docker/compose*" }

            { Assert-GitHubReleaseAssets -Toolset $toolset -GitHubCliArchitecture "amd64" -IncludeDockerCompose } |
                Should -Throw "No GitHub release asset matches 'docker-compose-windows-x86_64.exe' for docker/compose 2.40.3."
        }

        It "uses the Selenium version requested by the toolset" {
            $toolset.selenium.version = "5"

            { Assert-GitHubReleaseAssets -Toolset $toolset -GitHubCliArchitecture "arm64" } |
                Should -Throw "No GitHub release asset matches 'selenium-server-*.jar' for SeleniumHQ/selenium 5.*."
        }

        It "checks Docker Compose and WinCred when the selected template provisions them" {
            { Assert-GitHubReleaseAssets -Toolset $toolset -GitHubCliArchitecture "amd64" -IncludeDockerCompose -IncludeDockerWinCred } | Should -Not -Throw
            Should -Invoke Invoke-PreflightRequest -ParameterFilter { $Uri -like "*docker/compose*" } -Times 1 -Exactly
            Should -Invoke Invoke-PreflightRequest -ParameterFilter { $Uri -like "*docker-credential-helpers*" } -Times 1 -Exactly
        }
    }

    Context "Assert-ChocolateyPackages" {
        It "accepts an available package and its requested version" {
            $toolset = [PSCustomObject] @{
                choco = [PSCustomObject] @{
                    common_packages = @([PSCustomObject] @{ name = "Example.Package"; version = "1.2.3" })
                }
            }
            Mock Invoke-PreflightRequest { [PSCustomObject] @{ Content = "<d:Version>1.2.3</d:Version>" } }

            { Assert-ChocolateyPackages -Toolset $toolset } | Should -Not -Throw
        }

        It "fails when a requested package version is unavailable" {
            $toolset = [PSCustomObject] @{
                choco = [PSCustomObject] @{
                    common_packages = @([PSCustomObject] @{ name = "Example.Package"; version = "1.2.3" })
                }
            }
            Mock Invoke-PreflightRequest { $false }

            { Assert-ChocolateyPackages -Toolset $toolset } |
                Should -Throw "Chocolatey package 'Example.Package' does not provide requested version '1.2.3'."
        }
    }

    Context "Assert-PowerShellGalleryModules" {
        It "accepts available modules and their requested versions" {
            $toolset = [PSCustomObject] @{
                powershellModules = @(
                    [PSCustomObject] @{ name = "Example.Module"; versions = @("1.0.0", "2.0.0") }
                    [PSCustomObject] @{ name = "Unpinned.Module"; versions = $null }
                )
            }
            Mock Invoke-PreflightRequest { [PSCustomObject] @{ Content = "<d:Version>1.0.0</d:Version><d:Version>2.0.0</d:Version>" } }

            { Assert-PowerShellGalleryModules -Toolset $toolset } | Should -Not -Throw
        }

        It "fails when a requested module version is unavailable" {
            $toolset = [PSCustomObject] @{
                powershellModules = @([PSCustomObject] @{ name = "Example.Module"; versions = @("1.0.0") })
            }
            Mock Invoke-PreflightRequest { $false }

            { Assert-PowerShellGalleryModules -Toolset $toolset } |
                Should -Throw "PowerShell Gallery module 'Example.Module' does not provide requested version '1.0.0'."
        }
    }

    Context "Assert-VsixMetadata" {
        It "uses canonical download overrides and verifies Marketplace metadata" {
            $toolset = [PSCustomObject] @{
                visualStudio = [PSCustomObject] @{
                    vsix = @(
                        "ProBITools.MicrosoftReportProjectsforVisualStudio2022",
                        "Example.Publisher.Extension"
                    )
                }
            }
            $marketplaceContent = "UniqueIdentifierValue VsixId AssetUri Microsoft.VisualStudio.Services.Payload.FileName"
            Mock Invoke-PreflightRequest { [PSCustomObject] @{ Content = $marketplaceContent } }

            { Assert-VsixMetadata -Toolset $toolset } | Should -Not -Throw
            Should -Invoke Invoke-PreflightRequest -ParameterFilter { $Method -eq "Head" } -Times 1 -Exactly
            Should -Invoke Invoke-PreflightRequest -ParameterFilter { $Uri -like "https://marketplace.visualstudio.com/*" } -Times 1 -Exactly
        }
    }

    Context "Effective downstream paths" {
        BeforeEach {
            $preparedRoot = Join-Path $TestDrive "prepared-image"
            $templateDirectory = Join-Path $preparedRoot "templates"
            $scriptsRoot = Join-Path $preparedRoot "scripts"
            $templatePath = Join-Path $templateDirectory "build.windows-custom.pkr.hcl"
            $toolsetPath = Join-Path $preparedRoot "toolset.json"

            New-Item -Path $templateDirectory, $scriptsRoot -ItemType Directory -Force | Out-Null
            Set-Content -Path (Join-Path $scriptsRoot "Provision.ps1") -Value 'Write-Host "valid script"'
            Set-Content -Path $templatePath -Value 'sources = ["${path.root}/../scripts/Provision.ps1"]'
            Set-Content -Path $toolsetPath -Value '{"preflightMarker":"effective"}'
        }

        It "resolves path.root relative to the supplied template" {
            { Assert-TemplateReferences -TemplatePath $templatePath } | Should -Not -Throw
        }

        It "normalizes nested path.root references relative to the supplied template" {
            $repositoryRoot = Join-Path $TestDrive "repo"
            $nestedTemplateDirectory = Join-Path $repositoryRoot "images/custom-image/templates"
            $certificatesDirectory = Join-Path $repositoryRoot "shared/assets/certificates"
            $nestedTemplatePath = Join-Path $nestedTemplateDirectory "build.pkr.hcl"

            New-Item -Path $nestedTemplateDirectory, $certificatesDirectory -ItemType Directory -Force | Out-Null
            Set-Content -Path (Join-Path $certificatesDirectory "root.crt") -Value "certificate"
            Set-Content -Path $nestedTemplatePath -Value 'sources = ["${path.root}/../../../shared/assets/certificates"]'

            { Assert-TemplateReferences -TemplatePath $nestedTemplatePath } | Should -Not -Throw
        }

        It "reports the normalized path when a nested template reference is missing" {
            $repositoryRoot = Join-Path $TestDrive "repo"
            $nestedTemplateDirectory = Join-Path $repositoryRoot "images/custom-image/templates"
            $nestedTemplatePath = Join-Path $nestedTemplateDirectory "build.pkr.hcl"
            $reference = '${path.root}/../../../shared/assets/missing-certificates'
            $expectedPath = [System.IO.Path]::GetFullPath((Join-Path $repositoryRoot "shared/assets/missing-certificates"))

            New-Item -Path $nestedTemplateDirectory -ItemType Directory -Force | Out-Null
            Set-Content -Path $nestedTemplatePath -Value "sources = [`"$reference`"]"

            { Assert-TemplateReferences -TemplatePath $nestedTemplatePath } |
                Should -Throw "*'$reference' (resolved to '$expectedPath')*"
        }

        It "uses the supplied scripts root for syntax validation" {
            { Assert-PowerShellSyntax -ScriptsRoot $scriptsRoot } | Should -Not -Throw
        }

        It "uses all supplied effective paths without requiring an image" {
            Mock Assert-ToolcacheAssets {}
            Mock Assert-ChocolateyPackages {}
            Mock Assert-PowerShellGalleryModules {}
            Mock Assert-GitHubReleaseAssets {}
            Mock Assert-VsixMetadata {}

            {
                Invoke-WindowsResolverPreflight `
                    -TemplatePath $templatePath `
                    -ToolsetPath $toolsetPath `
                    -ScriptsRoot $scriptsRoot `
                    -Architecture "x64"
            } | Should -Not -Throw

            Should -Invoke Assert-ToolcacheAssets -ParameterFilter { $Toolset.preflightMarker -eq "effective" } -Times 1 -Exactly
        }

        It "requires an image when an effective path is omitted" {
            { Invoke-WindowsResolverPreflight -TemplatePath $templatePath -SkipNetwork } |
                Should -Throw "Specify -Image or provide -TemplatePath, -ToolsetPath, and -ScriptsRoot."
        }

        It "requires an architecture for network checks when no image is selected" {
            { Invoke-WindowsResolverPreflight -TemplatePath $templatePath -ToolsetPath $toolsetPath -ScriptsRoot $scriptsRoot } |
                Should -Throw "Specify -Image or -Architecture for network dependency checks."
        }
    }

    Context "Template-specific GitHub release requirements" {
        BeforeEach {
            Mock Assert-ToolcacheAssets {}
            Mock Assert-ChocolateyPackages {}
            Mock Assert-PowerShellGalleryModules {}
            Mock Assert-GitHubReleaseAssets {}
            Mock Assert-VsixMetadata {}
        }

        It "omits Docker assets for <Image>" -TestCases @(
            @{ Image = "Windows11Arm64" }
            @{ Image = "Windows11VS2026Arm64" }
        ) {
            param($Image)

            { Invoke-WindowsResolverPreflight -Image $Image } | Should -Not -Throw

            Should -Invoke Assert-GitHubReleaseAssets -ParameterFilter {
                -not $IncludeDockerCompose -and -not $IncludeDockerWinCred
            } -Times 1 -Exactly
        }

        It "includes Docker assets for the Windows 2025 template" {
            { Invoke-WindowsResolverPreflight -Image "Windows2025" } | Should -Not -Throw

            Should -Invoke Assert-GitHubReleaseAssets -ParameterFilter {
                $IncludeDockerCompose -and $IncludeDockerWinCred
            } -Times 1 -Exactly
        }
    }

    It "runs the static preflight for <Image> without network access" -TestCases @(
        @{ Image = "Windows2022" }
        @{ Image = "Windows2025" }
        @{ Image = "Windows2025VS2026" }
        @{ Image = "Windows11Arm64" }
        @{ Image = "Windows11VS2026Arm64" }
    ) {
        param($Image)

        { Invoke-WindowsResolverPreflight -Image $Image -SkipNetwork } | Should -Not -Throw
    }
}
