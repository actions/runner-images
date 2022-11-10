param (
    [Parameter(Mandatory)][string]
    $OutputDirectory
)

$global:ErrorActionPreference = "Stop"
$global:ErrorView = "NormalView"
Set-StrictMode -Version Latest

. (Join-Path $PSScriptRoot "SoftwareReport.ArchiveItem.ps1")
Import-Module MarkdownPS
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Android.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Browsers.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.CachedTools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Common.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Databases.psm1") -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/SoftwareReport.Helpers.psm1" -DisableNameChecking
Import-Module "$PSScriptRoot/../helpers/Common.Helpers.psm1" -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Java.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Rust.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.Tools.psm1") -DisableNameChecking
Import-Module (Join-Path $PSScriptRoot "SoftwareReport.WebServers.psm1") -DisableNameChecking

# Restore file owner in user profile
Restore-UserOwner

$markdown = ""
$archive = [ArchiveItems]::New()

$OSName = Get-OSName
$markdown += New-MDHeader $archive.SetHeader("$OSName", 1) -Level 1

$kernelVersion = Get-KernelVersion
$markdown += New-MDList -Style Unordered -Lines @(
    $archive.Add("$kernelVersion", "KernelVersion")
    $archive.Add("Image Version: $env:IMAGE_VERSION", "ImageVersion")
)

$markdown += New-MDHeader $archive.SetHeader("Installed Software", 2) -Level 2
$markdown += New-MDHeader $archive.SetHeader("Language and Runtime", 3) -Level 3

$runtimesList = @(
    ((Get-BashVersion), "Bash"),
    ((Get-DashVersion), "Dash"),
    ((Get-CPPVersions), "CPP"),
    ((Get-FortranVersions), "Fortran"),
    ((Get-MsbuildVersion), "Msbuild"),
    ((Get-MonoVersion), "Mono"),
    ((Get-NodeVersion), "Node"),
    ((Get-PerlVersion), "Perl"),
    ((Get-PythonVersion), "Python"),
    ((Get-Python3Version), "Python3"),
    ((Get-RubyVersion), "Ruby"),
    ((Get-JuliaVersion), "Julia"),
    ((Get-ClangVersions), "Clang"),
    ((Get-ClangFormatVersions), "ClangFormat"),
    ((Get-ClangTidyVersions), "ClangTidy"),
    ((Get-KotlinVersion), "Kotlin"),
    ((Get-SwiftVersion), "Swift")
)

if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $runtimesList += @(
        ((Get-ErlangVersion), "Erlang"),
        ((Get-ErlangRebar3Version), "ErlangRebar3")
    )
}

$runtimesTitlesList = $runtimesList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($runtimesTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Package Management", 3) -Level 3

$packageManagementList = @(
    ((Get-HomebrewVersion), "Homebrew"),
    ((Get-CpanVersion), "Cpan"),
    ((Get-GemVersion), "Gem"),
    ((Get-MinicondaVersion), "Miniconda"),
    ((Get-NuGetVersion), "NuGet"),
    ((Get-HelmVersion), "Helm"),
    ((Get-NpmVersion), "Npm"),
    ((Get-YarnVersion), "Yarn"),
    ((Get-PipxVersion), "Pipx"),
    ((Get-PipVersion), "Pip"),
    ((Get-Pip3Version), "Pip3"),
    ((Get-VcpkgVersion), "Vcpkg")
)

$packageManagementTitlesList = $packageManagementList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($packageManagementTitlesList | Sort-Object)

$markdown += New-MDHeader "Notes:" -Level 5
$reportHomebrew = @'
```
Location: /home/linuxbrew
Note: Homebrew is pre-installed on image but not added to PATH.
run the eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" command
to accomplish this.
```
'@
$markdown += New-MDParagraph -Lines $reportHomebrew

$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-PackageManagementEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Project Management", 3) -Level 3
$projectManagementList = @()
if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $projectManagementList += @(
        ((Get-AntVersion), "Ant"),
        ((Get-GradleVersion), "Gradle"),
        ((Get-MavenVersion), "Maven"),
        ((Get-SbtVersion), "Sbt")
    )
}

if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $projectManagementList += @(
        ,((Get-LernaVersion), "Lerna")
    )
}
$projectManagementTitlesList = $projectManagementList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($projectManagementTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Tools", 3) -Level 3
$toolsList = @(
    ((Get-AnsibleVersion), "Ansible"),
    ((Get-AptFastVersion), "AptFast"),
    ((Get-AzCopyVersion), "AzCopy"),
    ((Get-BazelVersion), "Bazel"),
    ((Get-BazeliskVersion), "Bazelisk"),
    ((Get-BicepVersion), "Bicep"),
    ((Get-CodeQLBundleVersion), "CodeQL"),
    ((Get-CMakeVersion), "CMake"),
    ((Get-DockerMobyClientVersion), "DockerMobyClient"),
    ((Get-DockerMobyServerVersion), "DockerMobyServer"),
    ((Get-DockerComposeV1Version), "DockerComposeV1"),
    ((Get-DockerComposeV2Version), "DockerComposeV2"),
    ((Get-DockerBuildxVersion), "DockerBuildx"),
    ((Get-DockerAmazonECRCredHelperVersion), "DockerAmazonECRCredHelper"),
    ((Get-BuildahVersion), "Buildah"),
    ((Get-PodManVersion), "PodMan"),
    ((Get-SkopeoVersion), "Skopeo"),
    ((Get-GitVersion), "Git"),
    ((Get-GitLFSVersion), "GitLFS"),
    ((Get-GitFTPVersion), "GitFTP"),
    ((Get-HavegedVersion), "Haveged"),
    ((Get-HerokuVersion), "Heroku"),
    ((Get-LeiningenVersion), "Leiningen"),
    ((Get-SVNVersion), "SVN"),
    ((Get-JqVersion), "Jq"),
    ((Get-YqVersion), "Yq"),
    ((Get-KindVersion), "Kind"),
    ((Get-KubectlVersion), "Kubectl"),
    ((Get-KustomizeVersion), "Kustomize"),
    ((Get-MediainfoVersion), "Mediainfo"),
    ((Get-HGVersion), "HG"),
    ((Get-MinikubeVersion), "Minikube"),
    ((Get-NewmanVersion), "Newman"),
    ((Get-NVersion), "NV"),
    ((Get-NvmVersion), "Nvm"),
    ((Get-OpensslVersion), "Openssl"),
    ((Get-PackerVersion), "Packer"),
    ((Get-ParcelVersion), "Parcel"),
    ((Get-PulumiVersion), "Pulumi"),
    ((Get-RVersion), "RVersion"),
    ((Get-SphinxVersion), "Sphinx"),
    ((Get-TerraformVersion), "Terraform"),
    ((Get-YamllintVersion), "Yamllint"),
    ((Get-ZstdVersion), "Zstd")
)

if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $toolsList += @(
        ((Get-PhantomJSVersion), "PhantomJS"),
        ((Get-HHVMVersion), "HHVM")
    )
}

if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $toolsList += ,((Get-FastlaneVersion), "Fastlane")
}

$toolsTitlesList = $toolsList | ForEach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($toolsTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("CLI Tools", 3) -Level 3
$cliToolsList = @(
    ((Get-AlibabaCloudCliVersion), "AlibabaCloudCli"),
    ((Get-AWSCliVersion), "AWSCli"),
    ((Get-AWSCliSessionManagerPluginVersion), "AWSCliSessionManagerPlugin"),
    ((Get-AWSSAMVersion), "AWSSAMV"),
    ((Get-AzureCliVersion), "AzureCli"),
    ((Get-AzureDevopsVersion), "AzureDevops"),
    ((Get-GitHubCliVersion), "GitHubCli"),
    ((Get-GoogleCloudSDKVersion), "GoogleCloudSDK"),
    ((Get-HubCliVersion), "HubCli"),
    ((Get-NetlifyCliVersion), "NetlifyCli"),
    ((Get-OCCliVersion), "OCCli"),
    ((Get-ORASCliVersion), "ORASCli"),
    ((Get-VerselCliversion), "VerselCli")
)

$cliToolsTitlesList = $cliToolsList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($cliToolsTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Java", 3) -Level 3
$markdown += Get-JavaVersions $archive | New-MDTable
$markdown += New-MDNewLine

if ((Test-IsUbuntu20) -or (Test-IsUbuntu22)) {
    $markdown += New-MDHeader $archive.SetHeader("GraalVM", 3) -Level 3
    $markdown += Build-GraalVMTable $archive | New-MDTable
    $markdown += New-MDNewLine
}

$markdown += Build-PHPSection $archive

$markdown += New-MDHeader $archive.SetHeader("Haskell", 3) -Level 3
$haskellList = @(
    ((Get-GHCVersion), "GHC"),
    ((Get-GHCupVersion), "GHCup"),
    ((Get-CabalVersion), "Cabal"),
    ((Get-StackVersion), "Stack")
)

$haskellTitlesList = $haskellList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($haskellTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Rust Tools", 3) -Level 3
$rustToolsList = @(
    ((Get-RustVersion), "Rust"),
    ((Get-RustupVersion), "Rustup"),
    ((Get-RustdocVersion), "Rustdoc"),
    ((Get-CargoVersion), "Cargo")
)

$rustToolsTitlesList = $rustToolsList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($rustToolsTitlesList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Packages", 4) -Level 4
$packagesList = @(
    ((Get-BindgenVersion), "Bindgen"),
    ((Get-CargoAuditVersion), "CargoAudit"),
    ((Get-CargoOutdatedVersion), "CargoOutdated"),
    ((Get-CargoClippyVersion), "CargoClippy"),
    ((Get-CbindgenVersion), "Cbindgen"),
    ((Get-RustfmtVersion), "Rustfmt")
)

$packagesToolsList = $packagesList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ($packagesToolsList | Sort-Object)

$markdown += New-MDHeader $archive.SetHeader("Browsers and Drivers", 3) -Level 3

$browsersAndDriversList = @(
    ((Get-ChromeVersion), "Chrome"),
    ((Get-ChromeDriverVersion), "ChromeDriver"),
    ((Get-ChromiumVersion), "Chromium"),
    ((Get-EdgeVersion), "Edge"),
    ((Get-EdgeDriverVersion), "Edgedriver"),
    ((Get-SeleniumVersion), "Selenium")
)

if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $browsersAndDriversList += @(
        ((Get-FirefoxVersion), "Firefox"),
        ((Get-GeckodriverVersion), "Geckodriver")
    )
}

$browsersAndDriversTitlesList = $browsersAndDriversList | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines $browsersAndDriversTitlesList
$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-BrowserWebdriversEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader(".NET Core SDK", 3) -Level 3
$markdown += New-MDList -Style Unordered -Lines @(
    $archive.Add((Get-DotNetCoreSdkVersions), "DotNetCoreSdk")
)

$markdown += New-MDHeader $archive.SetHeader(".NET tools", 3) -Level 3
$tools = Get-DotnetTools $archive
$markdown += New-MDList -Lines $tools -Style Unordered

$markdown += New-MDHeader $archive.SetHeader("Databases", 3) -Level 3
$databaseLists = @(
    ,((Get-SqliteVersion), "Sqlite")
)

if ((Test-IsUbuntu18) -or (Test-IsUbuntu20)) {
    $databaseLists += @(
        ,((Get-MongoDbVersion), "MongoDb")
    )
}

$databaseTitlesLists = $databaseLists | Foreach-Object {$archive.Add($_)}
$markdown += New-MDList -Style Unordered -Lines ( $databaseTitlesLists | Sort-Object )

$markdown += Build-PostgreSqlSection $archive
$markdown += Build-MySQLSection $archive
$markdown += Build-MSSQLToolsSection $archive

$markdown += New-MDHeader $archive.SetHeader("Cached Tools", 3) -Level 3
$markdown += Build-CachedToolsSection $archive

$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-GoEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("PowerShell Tools", 3) -Level 3
$markdown += New-MDList -Lines ($archive.Add((Get-PowershellVersion), "PowerShellTools")) -Style Unordered

$markdown += New-MDHeader $archive.SetHeader("PowerShell Modules", 4) -Level 4
$markdown += Get-PowerShellModules $archive | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader $archive.SetHeader("Az PowerShell Modules", 4) -Level 4
$markdown += New-MDList -Style Unordered -Lines @(
    $archive.Add((Get-AzModuleVersions), "AzPowerShellModules")
)

$markdown += Build-WebServersSection $archive

$markdown += New-MDHeader $archive.SetHeader("Android", 3) -Level 3
$markdown += Build-AndroidTable $archive | New-MDTable
$markdown += New-MDNewLine
$markdown += New-MDHeader $archive.SetHeader("Environment variables", 4) -Level 4
$markdown += Build-AndroidEnvironmentTable $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Cached Docker images", 3) -Level 3
$markdown += Get-CachedDockerImagesTableData $archive | New-MDTable
$markdown += New-MDNewLine

$markdown += New-MDHeader $archive.SetHeader("Installed apt packages", 3) -Level 3
$markdown += Get-AptPackages $archive | New-MDTable

Test-BlankElement
$markdown | Out-File -FilePath "${OutputDirectory}/Ubuntu-Readme.md"
$archive.ToJsonGrouped() | Out-File "${OutputDirectory}/Ubuntu-Archive-Grouped.json"
