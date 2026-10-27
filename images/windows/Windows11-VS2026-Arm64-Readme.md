| Announcements |
|-|
| [[Windows] The `windows-11-arm` image label will use Windows 11 Arm64 with Visual Studio 2026 image in September 2026](https://github.com/actions/runner-images/issues/14602) |
| [[Windows] The Windows 11 Arm64 with Visual Studio 2026 is now generally available in GitHub Actions](https://github.com/actions/runner-images/issues/14592) |
***
# Windows 11 Enterprise
- OS Version: 10.0.26200 Build 9711
- Image Version: 20261021.192.1

## Windows features

## Installed Software

### Language and Runtime
- Bash 5.3.15(2)-release
- Go 1.24.13
- Julia 1.12.0
- Kotlin 2.4.21
- LLVM 22.1.8
- Node 24.22.1
- Perl 5.32.1
- PHP 8.4.27
- Python 3.13.17
- Ruby 3.4.11

### Package Management
- Chocolatey 2.7.4
- Composer 2.10.3
- Helm 4.1.4
- NPM 11.19.1
- NuGet 7.9.0.83
- pip 26.2.2 (python 3.13)
- Pipx 1.18.4
- RubyGems 3.6.9
- Vcpkg (build from commit 8c5c88430a)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value    |
| ----------------------- | -------- |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg |

### Project Management
- Ant 1.10.18
- Gradle 9.8
- Maven 3.9.16
- sbt 1.12.12

### Tools
- 7zip 26.05
- aria2 1.37.0
- azcopy 10.32.8
- Bazel 9.3.1
- Bazelisk 1.28.1
- Bicep 0.48.1
- CMake 4.4.4
- CodeQL Action Bundle 2.27.3
- Git 2.56.0.windows.2
- Git LFS 3.8.0
- ImageMagick 7.1.2-25
- InnoSetup 6.7.1
- jq 1.8.2
- Kind 0.33.0
- Kubectl 1.37.1
- Mercurial 6.3.1
- gcc 14.2.0
- gdb 16.2
- GNU Binutils 2.44
- Newman 6.2.3
- NSIS 3.10
- OpenSSL 3.6.5
- Packer 1.16.0
- Pulumi 3.270.0
- R 4.6.1 (x86_64, emulated)
- Stack 3.11.1
- Swig 4.4.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- yamllint 1.38.0
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- Alibaba Cloud CLI 3.5.1
- AWS CLI 2.38.3
- AWS SAM CLI 1.169.0
- AWS Session Manager CLI 1.2.896.0
- Azure CLI 2.91.0
- Azure DevOps CLI extension 1.0.9
- GitHub CLI 2.103.0

### Rust Tools
- Cargo 1.99.1
- Rust 1.99.1
- Rustdoc 1.99.1
- Rustup 1.29.2

#### Packages
- bindgen 0.73.2
- cargo-audit 0.22.2
- cargo-outdated 0.19.0
- cbindgen 0.29.4
- Clippy 0.1.99
- Rustfmt 1.10.0

### Browsers and Drivers
- Google Chrome 156.0.8078.48
- Chrome Driver 156.0.8078.47
- Microsoft Edge 155.0.4283.62
- Microsoft Edge Driver 155.0.4283.62
- Mozilla Firefox 158.0.1
- Gecko Driver 0.37.1
- IE Driver 4.14.0.0
- Selenium server 4.51.0

#### Environment variables
| Name              | Value                              |
| ----------------- | ---------------------------------- |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver  |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server.jar    |

### Java
| Version                 | Environment Variable |
| ----------------------- | -------------------- |
| 21.0.12+101.0 (default) | JAVA_HOME_21_AARCH64 |
| 23.0.2+7                | JAVA_HOME_23_AARCH64 |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### MSYS2
- Pacman 6.1.0

#### Notes
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```

### Cached Tools

#### Go
- 1.24.13
- 1.25.14
- 1.26.10

#### Node.js
- 22.23.4
- 24.22.1

#### Python
- 3.12.10
- 3.13.16
- 3.14.9
- 3.15.1

#### Ruby
- 3.4.11

### Database tools
- Azure CosmosDb Emulator 2.14.28.0
- DacFx 170.4.83.3
- MySQL 8.4.13.0
- SQL OLEDB Driver 18 18.7.5.0
- SQL OLEDB Driver 19 19.4.1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.31.8  | C:\tools\nginx-1.31.8\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2026
| Name                          | Version         | Path                                                   |
| ----------------------------- | --------------- | ------------------------------------------------------ |
| Visual Studio Enterprise 2026 | 18.11.12315.225 | C:\Program Files\Microsoft Visual Studio\18\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 36.1.118.0      |
| Component.Android.NDK.R27C                                                | 18.11.12301.404 |
| Component.Android.SDK.MAUI                                                | 18.11.12301.404 |
| Component.Linux.CMake                                                     | 18.11.12301.404 |
| Component.Linux.RemoteFileExplorer                                        | 18.11.12301.404 |
| Component.MDD.Linux                                                       | 18.11.12301.404 |
| Component.Microsoft.NET.AppModernization                                  | 18.11.12301.404 |
| Component.Microsoft.VisualStudio.RazorExtension                           | 18.11.12301.404 |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.1.37110.1    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 18.11.12301.404 |
| Component.Microsoft.Web.LibraryManager                                    | 18.11.12301.404 |
| Component.Microsoft.Windows.DriverKit                                     | 18.11.12301.404 |
| Component.OpenJDK                                                         | 18.11.12301.404 |
| Component.Unreal                                                          | 18.11.12301.404 |
| Component.Unreal.Android                                                  | 18.11.12301.404 |
| Component.Unreal.Debugger                                                 | 18.11.12301.404 |
| Component.Unreal.Ide                                                      | 18.11.12301.404 |
| Component.VisualStudio.GitHub.Copilot                                     | 18.11.12301.404 |
| Component.VSInstallerProjects2022_arm64                                   | 3.0.0           |
| ComponentGroup.Copilot.DotNet.Skills                                      | 18.11.12301.404 |
| ComponentGroup.Microsoft.NET.AppModernization                             | 18.11.12301.404 |
| ios                                                                       | 26.5.10315      |
| maccatalyst                                                               | 26.5.10315      |
| maui.blazor                                                               | 10.0.110.9434   |
| maui.core                                                                 | 10.0.110.9434   |
| maui.windows                                                              | 10.0.110.9434   |
| Microsoft.Component.ClickOnce                                             | 18.11.12301.404 |
| Microsoft.Component.CodeAnalysis.SDK                                      | 18.11.12301.404 |
| Microsoft.Component.MSBuild                                               | 18.11.12301.404 |
| Microsoft.Component.NetFX.Native                                          | 18.11.12301.404 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 18.11.12301.404 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.2.SDK                                         | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.1.SDK                                         | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.SDK                                           | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.4.8.1.DeveloperTools                         | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 18.11.12301.404 |
| microsoft.net.runtime.android                                             | 10.1.1326.50504 |
| microsoft.net.runtime.android.aot                                         | 10.1.1326.50504 |
| microsoft.net.runtime.android.aot.net9                                    | 10.1.1326.50504 |
| microsoft.net.runtime.android.net9                                        | 10.1.1326.50504 |
| microsoft.net.runtime.ios                                                 | 10.1.1326.50504 |
| microsoft.net.runtime.ios.net9                                            | 10.1.1326.50504 |
| microsoft.net.runtime.maccatalyst                                         | 10.1.1326.50504 |
| microsoft.net.runtime.maccatalyst.net9                                    | 10.1.1326.50504 |
| microsoft.net.runtime.mono.tooling                                        | 10.1.1326.50504 |
| microsoft.net.runtime.mono.tooling.net9                                   | 10.1.1326.50504 |
| microsoft.net.sdk.emscripten                                              | 10.1.1326.50504 |
| Microsoft.NetCore.Component.DevelopmentTools                              | 18.11.12301.404 |
| Microsoft.NetCore.Component.Runtime.10.0                                  | 18.11.12306.233 |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 18.11.12306.233 |
| Microsoft.NetCore.Component.SDK                                           | 18.11.12306.233 |
| Microsoft.NetCore.Component.Web                                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.AspNet                                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DockerTools                              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DslTools                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.FSharp                                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Graphics                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.HLSL                                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.IISExpress                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.NuGet                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Unity                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.14.44.17.14.ARM64                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Web                                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 18.11.12315.133 |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 18.11.12301.404 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Workload.Node                                      | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.Universal                                 | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 18.9.11915.232  |
| runtimes.ios                                                              | 10.1.1326.50504 |
| runtimes.ios.net9                                                         | 10.1.1326.50504 |
| runtimes.maccatalyst                                                      | 10.1.1326.50504 |
| runtimes.maccatalyst.net9                                                 | 10.1.1326.50504 |
| wasm.tools                                                                | 10.1.1326.50504 |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 2.2             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjectsArm64        | 3.0.0           |
| Windows Driver Kit                                                        | 10.1.26100.6584 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26586.0    |
| Windows Software Development Kit                                          | 10.1.26100.9457 |

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
- .NET Core SDK: 8.0.132, 8.0.206, 8.0.319, 8.0.426, 9.0.122, 9.0.205, 9.0.319, 10.0.113, 10.0.204, 10.0.303, 10.0.402
- .NET Framework: 4.7.2, 4.8, 4.8.1
- Microsoft.AspNetCore.App: 8.0.6, 8.0.22, 8.0.32, 9.0.6, 9.0.21, 10.0.8, 10.0.11, 10.0.13
- Microsoft.NETCore.App: 8.0.6, 8.0.22, 8.0.32, 9.0.6, 9.0.21, 10.0.8, 10.0.11, 10.0.13
- Microsoft.WindowsDesktop.App: 8.0.6, 8.0.22, 8.0.32, 9.0.6, 9.0.21, 10.0.8, 10.0.11, 10.0.13
- nbgv 3.10.94+dea9a6c17c

### PowerShell Tools
- PowerShell 7.6.7

#### Powershell Modules
- Az: 15.6.1
- AWSPowershell: 5.0.320
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.41.2
- Pester: 3.4.0, 5.9.0
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.25.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.4.5.1
- VSSetup: 2.2.16

## Notes
```
Microsoft Defender is not disabled on this image. Tamper Protection is enabled by default on Windows 11 and prevents the image build from disabling it. See https://github.com/actions/runner-images/issues/14326 for details.
```

