| Announcements |
|-|
| [[Windows] The `windows-11-arm` image label will use Windows 11 Arm64 with Visual Studio 2026 image in September 2026](https://github.com/actions/runner-images/issues/14602) |
| [[Windows] The Windows 11 Arm64 with Visual Studio 2026 is now generally available in GitHub Actions](https://github.com/actions/runner-images/issues/14592) |
***
# Windows Server 2025
- OS Version: 10.0.26100 Build 33674
- Image Version: 20261030.294.1

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled
- Windows Subsystem for Linux (Default, WSLv2): 3.0.3.0

## Installed Software

### Language and Runtime
- Bash 5.3.15(2)-release
- Go 1.24.13
- Julia 1.12.0
- Kotlin 2.4.21
- LLVM 20.1.8
- Node 22.23.4
- Perl 5.42.0
- PHP 8.5.12
- Python 3.12.10
- Ruby 3.3.13

### Package Management
- Chocolatey 2.7.5
- Composer 2.11.0
- Helm 4.1.4
- Miniconda 26.9.4 (pre-installed on the image but not added to PATH)
- NPM 10.9.9
- NuGet 7.9.0.83
- pip 26.2.2 (python 3.12)
- Pipx 1.18.10
- RubyGems 3.5.22
- Vcpkg (build from commit d186940b2f)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.18
- Gradle 9.8
- Maven 3.9.16
- sbt 1.12.12

### Tools
- 7zip 26.05
- aria2 1.37.0
- azcopy 10.34.1
- Bazel 9.3.1
- Bazelisk 1.28.1
- Bicep 0.48.1
- Cabal 3.18.2.0
- CMake 4.4.5
- CodeQL Action Bundle 2.27.3
- Docker 29.7.2
- Docker Compose 2.40.3
- Docker-wincred 0.9.12
- ghc 9.14.1
- Git 2.56.0.windows.4
- Git LFS 3.8.1
- ImageMagick 7.1.2-25
- InnoSetup 6.7.1
- jq 1.8.2
- Kind 0.33.0
- Kubectl 1.37.2
- gcc 15.2.0
- gdb 17.1
- GNU Binutils 2.46
- Newman 6.2.3
- OpenSSL 3.6.5
- Packer 1.16.0
- Pulumi 3.273.0
- R 4.6.1
- Service Fabric Runtime 11.7.157.1
- Service Fabric SDK 8.7.157.1
- Stack 3.11.1
- Swig 4.4.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.38.0
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- AWS CLI 2.39.1
- AWS SAM CLI 1.171.0
- AWS Session Manager CLI 1.2.896.0
- Azure CLI 2.91.0
- Azure DevOps CLI extension 1.0.10
- GitHub CLI 2.103.3

### Rust Tools
- Cargo 1.99.1
- Rust 1.99.1
- Rustdoc 1.99.1
- Rustup 1.29.2

#### Packages
- Clippy 0.1.99
- Rustfmt 1.10.0

### Browsers and Drivers
- Google Chrome 156.0.8078.80
- Chrome Driver 156.0.8078.80
- Microsoft Edge 156.0.4314.56
- Microsoft Edge Driver 156.0.4314.50
- Mozilla Firefox 159.0
- Gecko Driver 0.37.1
- IE Driver 4.14.0.0
- Selenium server 4.52.0

#### Environment variables
| Name              | Value                              |
| ----------------- | ---------------------------------- |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver  |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server.jar    |

### Java
| Version               | Environment Variable |
| --------------------- | -------------------- |
| 8.0.504+1             | JAVA_HOME_8_X64      |
| 11.0.32+101           | JAVA_HOME_11_X64     |
| 17.0.20+101 (default) | JAVA_HOME_17_X64     |
| 21.0.13+9.0           | JAVA_HOME_21_X64     |
| 25.0.5+8.0            | JAVA_HOME_25_X64     |

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
- 24.22.2

#### Python
- 3.11.9
- 3.12.10
- 3.13.17
- 3.14.10
- 3.15.2

#### PyPy
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.2.11
- 3.3.13
- 3.4.12
- 4.0.9

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| ServiceName          | postgresql-x64-17                                                                                                      |
| Version              | 17.11                                                                                                                  |
| ServiceStatus        | Stopped                                                                                                                |
| ServiceStartType     | Disabled                                                                                                               |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\17\bin <br> PGDATA=C:\PostgreSQL\17\data <br> PGROOT=C:\Program Files\PostgreSQL\17  |
| Path                 | C:\Program Files\PostgreSQL\17                                                                                         |
| UserName             | postgres                                                                                                               |
| Password             | root                                                                                                                   |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 7.0.45.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.28.0
- DacFx 170.4.83.3
- MySQL 8.4.13.0
- SQL OLEDB Driver 18 18.7.5.0
- SQL OLEDB Driver 19 19.4.1.0
- SQLPS 1.0
- MongoDB Shell (mongosh) 2.14.1

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.31.8  | C:\tools\nginx-1.31.8\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2026
| Name                          | Version         | Path                                                   |
| ----------------------------- | --------------- | ------------------------------------------------------ |
| Visual Studio Enterprise 2026 | 18.11.12328.437 | C:\Program Files\Microsoft Visual Studio\18\Enterprise |

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
| Component.UnityEngine.x64                                                 | 18.11.12301.404 |
| Component.Unreal.Debugger                                                 | 18.11.12301.404 |
| Component.Unreal.Ide                                                      | 18.11.12301.404 |
| Component.VisualStudio.GitHub.Copilot                                     | 18.11.12301.404 |
| Component.VSInstallerProjects2022                                         | 3.0.0           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| ComponentGroup.Copilot.Azure.Skills                                       | 18.11.12301.404 |
| ComponentGroup.Copilot.DotNet.Skills                                      | 18.11.12301.404 |
| ComponentGroup.Microsoft.NET.AppModernization                             | 18.11.12301.404 |
| ios                                                                       | 26.5.10315      |
| maccatalyst                                                               | 26.5.10315      |
| maui.blazor                                                               | 10.0.110.9434   |
| maui.core                                                                 | 10.0.110.9434   |
| maui.windows                                                              | 10.0.110.9434   |
| Microsoft.Component.Azure.DataLake.Tools                                  | 18.11.12301.404 |
| Microsoft.Component.ClickOnce                                             | 18.11.12301.404 |
| Microsoft.Component.CodeAnalysis.SDK                                      | 18.11.12301.404 |
| Microsoft.Component.MSBuild                                               | 18.11.12301.404 |
| Microsoft.Component.NetFX.Native                                          | 18.11.12301.404 |
| Microsoft.Component.PythonTools                                           | 18.11.12301.404 |
| Microsoft.Component.PythonTools.Web                                       | 18.11.12301.404 |
| Microsoft.ComponentGroup.Blend                                            | 18.11.12301.404 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 18.11.12301.404 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.1.SDK                                         | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.SDK                                           | 18.11.12301.404 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 18.11.12301.404 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 18.11.12301.404 |
| microsoft.net.runtime.android                                             | 10.1.1426.52326 |
| microsoft.net.runtime.android.aot                                         | 10.1.1426.52326 |
| microsoft.net.runtime.android.aot.net9                                    | 10.1.1426.52326 |
| microsoft.net.runtime.android.net9                                        | 10.1.1426.52326 |
| microsoft.net.runtime.ios                                                 | 10.1.1426.52326 |
| microsoft.net.runtime.ios.net9                                            | 10.1.1426.52326 |
| microsoft.net.runtime.maccatalyst                                         | 10.1.1426.52326 |
| microsoft.net.runtime.maccatalyst.net9                                    | 10.1.1426.52326 |
| microsoft.net.runtime.mono.tooling                                        | 10.1.1426.52326 |
| microsoft.net.runtime.mono.tooling.net9                                   | 10.1.1426.52326 |
| microsoft.net.sdk.emscripten                                              | 10.1.1426.52326 |
| Microsoft.NetCore.Component.DevelopmentTools                              | 18.11.12301.404 |
| Microsoft.NetCore.Component.Runtime.10.0                                  | 18.11.12324.64  |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 18.11.12324.64  |
| Microsoft.NetCore.Component.SDK                                           | 18.11.12324.64  |
| Microsoft.NetCore.Component.Web                                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.AspNet                                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.CodeMap                                  | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DockerTools                              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.DslTools                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.FSharp                                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Graphics                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.HLSL                                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.IISExpress                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 18.11.12301.404 |
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
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Unity                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.VC.14.44.17.14.x86.x64                   | 18.11.12301.404 |
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
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Web                                      | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 18.11.12315.133 |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.Workflow                                 | 18.11.12301.404 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 18.11.12301.404 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 18.11.12301.404 |
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
| Microsoft.VisualStudio.Workload.Azure                                     | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.Data                                      | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.DataScience                               | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 18.11.12301.404 |
| Microsoft.VisualStudio.Workload.Node                                      | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.Office                                    | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.Python                                    | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.Universal                                 | 18.9.11915.232  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 18.9.11915.232  |
| runtimes.ios                                                              | 10.1.1426.52326 |
| runtimes.ios.net9                                                         | 10.1.1426.52326 |
| runtimes.maccatalyst                                                      | 10.1.1426.52326 |
| runtimes.maccatalyst.net9                                                 | 10.1.1426.52326 |
| wasm.tools                                                                | 10.1.1426.52326 |
| ms-azuretools.MicrosoftVisualStudioAzureFabricVsix                        | 18.0.20260523.1 |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 4.0.0           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 4.0.0           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 2.2             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 3.0.0           |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26586.0    |
| Windows Software Development Kit                                          | 10.1.26100.9457 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.51.36247 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.51.36247 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.51.36247 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.51.36247 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.51.36247 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.51.36247 |

#### Installed Windows SDKs
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 8.0.133, 8.0.206, 8.0.319, 8.0.427, 9.0.123, 9.0.205, 9.0.320, 10.0.114, 10.0.204, 10.0.303, 10.0.403
- .NET Framework: 4.8, 4.8.1
- Microsoft.AspNetCore.App: 8.0.6, 8.0.22, 8.0.33, 9.0.6, 9.0.22, 10.0.8, 10.0.11, 10.0.14
- Microsoft.NETCore.App: 8.0.6, 8.0.22, 8.0.33, 9.0.6, 9.0.22, 10.0.8, 10.0.11, 10.0.14
- Microsoft.WindowsDesktop.App: 8.0.6, 8.0.22, 8.0.33, 9.0.6, 9.0.22, 10.0.8, 10.0.11, 10.0.14
- nbgv 3.10.94+dea9a6c17c

### PowerShell Tools
- PowerShell 7.6.9

#### Powershell Modules
- Az: 15.6.1
- AWSPowershell: 5.0.326
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.41.2
- Pester: 3.4.0, 5.9.0
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.25.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.4.5.1
- VSSetup: 2.2.16

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 19.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Android Emulator           | 37.2.13                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Android SDK Platforms      | android-37.2-beta3 (rev 3)<br>android-37.2-beta2 (rev 2)<br>android-37.2-beta1 (rev 1)<br>android-37.2 (rev 2)<br>android-37.1 (rev 1)<br>android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android SDK Platform-Tools | 37.0.1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| CMake                      | 3.30.5<br>3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| NDK                        | 27.3.13750724<br>29.0.14206865<br>30.0.16248370                                                                                                                                                                                                                                                                                                                                                                                                                                         |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\30.0.16248370 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

