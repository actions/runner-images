| Announcements |
|-|
| [Go versions <=1.23  will be removed from tool-cache](https://github.com/actions/runner-images/issues/14237) |
| [[Windows] Windows 11 Arm with Visual Studio 2026 is now available as a public preview](https://github.com/actions/runner-images/issues/14225) |
| [[ARM] Arm64 runner images now maintained by GitHub](https://github.com/actions/runner-images/issues/14100) |
| [[Windows] `windows-latest` and `windows-2025` image-label will use Windows Server 2025 with Visual Studio 2026 image in June 2026](https://github.com/actions/runner-images/issues/14017) |
| [[Windows] The Windows Server 2025 with Visual Studio 2026 is now generally available in GitHub Actions](https://github.com/actions/runner-images/issues/14016) |
***
# Windows 11 Enterprise
- OS Version: 10.0.26200 Build 8655
- Image Version: 20260628.80.1

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.3.9(1)-release
- Go 1.24.13
- Julia 1.12.0
- Kotlin 2.4.0
- LLVM 20.1.6
- Node 24.18.0
- Perl 5.32.1
- PHP 8.4.22
- Python 3.13.14
- Ruby 3.4.9

### Package Management
- Chocolatey 2.7.3
- Composer 2.10.1
- Helm 4.1.4
- NPM 11.16.0
- NuGet 7.6.0.59
- pip 26.1.2 (python 3.13)
- Pipx 1.15.0
- RubyGems 3.6.9
- Vcpkg (build from commit a040002471)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value    |
| ----------------------- | -------- |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg |

### Project Management
- Ant 1.10.17
- Gradle 9.6
- Maven 3.9.16
- sbt 1.12.12

### Tools
- 7zip 26.02
- aria2 1.37.0
- azcopy 10.32.4
- Bazel 9.1.1
- Bazelisk 1.28.1
- Bicep 0.44.1
- CMake 4.3.4
- CodeQL Action Bundle 2.25.6
- Git 2.54.0.windows.1
- Git LFS 3.7.1
- ImageMagick 7.1.2-25
- InnoSetup 6.7.1
- jq 1.8.1
- Kind 0.32.0
- Kubectl 1.36.2
- Mercurial 6.3.1
- gcc 14.2.0
- gdb 16.2
- GNU Binutils 2.44
- Newman 6.2.2
- NSIS 3.10
- OpenSSL 3.6.3
- Packer 1.15.4
- Pulumi 3.248.0
- R 4.6.1
- Stack 3.11.1
- Swig 4.4.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- yamllint 1.38.0
- Ninja 1.13.2

### CLI Tools
- Alibaba Cloud CLI 3.4.2
- AWS CLI 2.35.11
- AWS SAM CLI 1.162.1
- AWS Session Manager CLI 1.2.835.0
- Azure CLI 2.87.0
- Azure DevOps CLI extension 1.0.5
- GitHub CLI 2.95.0

### Rust Tools
- Cargo 1.96.0
- Rust 1.96.0
- Rustdoc 1.96.0
- Rustup 1.29.0

#### Packages
- bindgen 0.72.1
- cargo-audit 0.22.2
- cargo-outdated 0.19.0
- cbindgen 0.29.4
- Clippy 0.1.96
- Rustfmt 1.9.0

### Browsers and Drivers
- Google Chrome 149.0.7827.201
- Chrome Driver 149.0.7827.155
- Microsoft Edge 149.0.4022.98
- Microsoft Edge Driver 149.0.4022.98
- Mozilla Firefox 152.0.3
- Gecko Driver 0.37.0
- IE Driver 4.14.0.0
- Selenium server 4.45.0

#### Environment variables
| Name              | Value                              |
| ----------------- | ---------------------------------- |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver  |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server.jar    |

### Java
| Version                | Environment Variable |
| ---------------------- | -------------------- |
| 21.0.11+10.0 (default) | JAVA_HOME_21_AARCH64 |
| 23.0.2+7               | JAVA_HOME_23_AARCH64 |

### Cached Tools

#### Go
- 1.24.13
- 1.25.11
- 1.26.4

#### Node.js
- 22.23.1
- 24.18.0

#### Python
- 3.12.10
- 3.13.14
- 3.14.6

#### Ruby
- 3.4.9

### Database tools
- Azure CosmosDb Emulator 2.14.27.0
- DacFx 170.4.83.3
- MySQL 8.0.46.0
- SQL OLEDB Driver 18 18.7.5.0
- SQL OLEDB Driver 19 19.4.1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.31.2  | C:\tools\nginx-1.31.2\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2026
| Name                          | Version       | Path                                                   |
| ----------------------------- | ------------- | ------------------------------------------------------ |
| Visual Studio Enterprise 2026 | 18.7.11919.86 | C:\Program Files\Microsoft Visual Studio\18\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 36.1.43.0       |
| Component.Android.NDK.R27C                                                | 18.7.11812.201  |
| Component.Android.SDK.MAUI                                                | 18.7.11812.201  |
| Component.Linux.CMake                                                     | 18.7.11812.201  |
| Component.Linux.RemoteFileExplorer                                        | 18.7.11812.201  |
| Component.MDD.Linux                                                       | 18.7.11812.201  |
| Component.Microsoft.NET.AppModernization                                  | 18.7.11901.58   |
| Component.Microsoft.VisualStudio.RazorExtension                           | 18.7.11812.201  |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.1.37110.1    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 18.7.11812.201  |
| Component.Microsoft.Web.LibraryManager                                    | 18.7.11812.201  |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.16   |
| Component.OpenJDK                                                         | 18.7.11812.201  |
| Component.Unreal                                                          | 18.7.11812.201  |
| Component.Unreal.Android                                                  | 18.7.11812.201  |
| Component.Unreal.Debugger                                                 | 18.7.11812.201  |
| Component.Unreal.Ide                                                      | 18.7.11812.201  |
| Component.VisualStudio.GitHub.Copilot                                     | 18.7.11812.201  |
| Component.VSInstallerProjects2022_arm64                                   | 3.0.0           |
| ComponentGroup.Microsoft.NET.AppModernization                             | 18.7.11812.201  |
| ios                                                                       | 26.5.10284      |
| maccatalyst                                                               | 26.5.10284      |
| maui.blazor                                                               | 10.0.20.7528    |
| maui.core                                                                 | 10.0.20.7528    |
| maui.windows                                                              | 10.0.20.7528    |
| Microsoft.Component.ClickOnce                                             | 18.7.11812.201  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 18.7.11812.201  |
| Microsoft.Component.MSBuild                                               | 18.7.11812.201  |
| Microsoft.Component.NetFX.Native                                          | 18.7.11812.201  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 18.7.11812.201  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 18.7.11812.201  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 18.7.11812.201  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 18.7.11812.201  |
| Microsoft.Net.Component.4.7.2.SDK                                         | 18.7.11812.201  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 18.7.11812.201  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 18.7.11812.201  |
| Microsoft.Net.Component.4.8.1.SDK                                         | 18.7.11812.201  |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 18.7.11812.201  |
| Microsoft.Net.Component.4.8.SDK                                           | 18.7.11812.201  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 18.7.11812.201  |
| Microsoft.Net.ComponentGroup.4.8.1.DeveloperTools                         | 18.7.11812.201  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 18.7.11812.201  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 18.7.11812.201  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 18.7.11812.201  |
| microsoft.net.runtime.android                                             | 10.1.926.27113  |
| microsoft.net.runtime.android.aot                                         | 10.1.926.27113  |
| microsoft.net.runtime.android.aot.net9                                    | 10.1.926.27113  |
| microsoft.net.runtime.android.net9                                        | 10.1.926.27113  |
| microsoft.net.runtime.ios                                                 | 10.1.926.27113  |
| microsoft.net.runtime.ios.net9                                            | 10.1.926.27113  |
| microsoft.net.runtime.maccatalyst                                         | 10.1.926.27113  |
| microsoft.net.runtime.maccatalyst.net9                                    | 10.1.926.27113  |
| microsoft.net.runtime.mono.tooling                                        | 10.1.926.27113  |
| microsoft.net.runtime.mono.tooling.net9                                   | 10.1.926.27113  |
| microsoft.net.sdk.emscripten                                              | 10.1.926.27113  |
| Microsoft.NetCore.Component.DevelopmentTools                              | 18.7.11812.201  |
| Microsoft.NetCore.Component.Runtime.10.0                                  | 18.7.11901.58   |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 18.7.11901.58   |
| Microsoft.NetCore.Component.SDK                                           | 18.7.11901.58   |
| Microsoft.NetCore.Component.Web                                           | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.AspNet                                   | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.DockerTools                              | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.DslTools                                 | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.FSharp                                   | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Graphics                                 | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.HLSL                                     | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.IISExpress                               | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.NuGet                                    | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Unity                                    | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.14.44.17.14.ARM64                     | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Web                                      | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 18.7.11812.201  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 18.7.11812.201  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 18.7.11812.201  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 18.7.11901.58   |
| Microsoft.VisualStudio.Workload.Node                                      | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.Universal                                 | 18.7.11811.120  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 18.7.11811.120  |
| runtimes.ios                                                              | 10.1.926.27113  |
| runtimes.ios.net9                                                         | 10.1.926.27113  |
| runtimes.maccatalyst                                                      | 10.1.926.27113  |
| runtimes.maccatalyst.net9                                                 | 10.1.926.27113  |
| wasm.tools                                                                | 10.1.926.27113  |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 2.2             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjectsArm64        | 3.0.0           |
| Windows Driver Kit                                                        | 10.1.26100.6584 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26586.0    |
| Windows Software Development Kit                                          | 10.1.26100.8249 |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.51.36247 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.51.36247 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.51.36247 |

#### Installed Windows SDKs
- 10.0.22621.0
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 6.0.136, 6.0.203, 6.0.321, 6.0.428, 8.0.128, 8.0.206, 8.0.319, 8.0.422, 9.0.118, 9.0.205, 9.0.315, 10.0.109, 10.0.204, 10.0.301
- .NET Framework: 4.7.2, 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.5, 6.0.26, 6.0.36, 8.0.6, 8.0.22, 8.0.28, 9.0.6, 9.0.17, 10.0.8, 10.0.9
- Microsoft.NETCore.App: 6.0.5, 6.0.26, 6.0.36, 8.0.6, 8.0.22, 8.0.28, 9.0.6, 9.0.17, 10.0.8, 10.0.9
- Microsoft.WindowsDesktop.App: 6.0.5, 6.0.26, 6.0.36, 8.0.6, 8.0.22, 8.0.28, 9.0.6, 9.0.17, 10.0.8, 10.0.9
- nbgv 3.10.85+c46e47c69b

### PowerShell Tools
- PowerShell 7.6.3

#### Powershell Modules
- Az: 15.6.1
- AWSPowershell: 5.0.241
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.38.0
- Pester: 3.4.0, 5.7.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.25.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.4.5.1
- VSSetup: 2.2.16

