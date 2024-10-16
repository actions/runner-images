# Windows Server 2022
- OS Version: 10.0.20348 Build 2700
- Image Version: 20241006.1.0

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.2.37(1)-release
- Go 1.21.13
- Julia 1.10.5
- Kotlin 2.0.20
- LLVM 18.1.8
- Node 18.20.3
- Perl 5.32.1
- PHP 8.3.12
- Python 3.9.13
- Ruby 3.0.7p220

### Package Management
- Chocolatey 2.3.0
- Composer 2.8.1
- Helm 3.16.0
- Miniconda 24.7.1 (pre-installed on the image but not added to PATH)
- NPM 10.7.0
- NuGet 6.11.1.2
- pip 24.2 (python 3.9)
- Pipx 1.7.1
- RubyGems 3.2.33
- Vcpkg (build from commit 7adc2e4d4)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.14
- Gradle 8.10
- Maven 3.8.7
- sbt 1.10.2

### Tools
- 7zip 24.08
- aria2 1.37.0
- azcopy 10.26.0
- Bazel 7.3.2
- Bazelisk 1.22.0
- Bicep 0.30.23
- Cabal 3.12.1.0
- CMake 3.30.4
- CodeQL Action Bundle 2.19.0
- Docker 26.1.3
- Docker Compose v2 2.27.1
- Docker-wincred 0.8.2
- ghc 9.10.1
- Git 2.46.2.windows.1
- Git LFS 3.5.1
- ImageMagick 7.1.1-38
- InnoSetup 6.3.3
- jq 1.7.1
- Kind 0.24.0
- Kubectl 1.31.1
- Mercurial 5.0
- gcc 12.2.0
- gdb 11.2
- GNU Binutils 2.39
- Newman 6.2.1
- NSIS 3.10
- OpenSSL 1.1.1w
- Packer 1.11.2
- Pulumi 3.135.1
- R 4.4.1
- Service Fabric SDK 9.1.1436.9590
- Stack 3.1.1
- Subversion (SVN) 1.14.2
- Swig 4.1.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.35.1
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.224
- AWS CLI 2.18.0
- AWS SAM CLI 1.125.0
- AWS Session Manager CLI 1.2.650.0
- Azure CLI 2.64.0
- Azure DevOps CLI extension 1.0.1
- GitHub CLI 2.58.0

### Rust Tools
- Cargo 1.81.0
- Rust 1.81.0
- Rustdoc 1.81.0
- Rustup 1.27.1

#### Packages
- bindgen 0.70.1
- cargo-audit 0.20.1
- cargo-outdated 0.15.0
- cbindgen 0.27.0
- Clippy 0.1.81
- Rustfmt 1.7.1

### Browsers and Drivers
- Google Chrome 129.0.6668.90
- Chrome Driver 129.0.6668.89
- Microsoft Edge 129.0.2792.79
- Microsoft Edge Driver 129.0.2792.79
- Mozilla Firefox 131.0
- Gecko Driver 0.35.0
- IE Driver 4.14.0.0
- Selenium server 4.25.0

#### Environment variables
| Name              | Value                              |
| ----------------- | ---------------------------------- |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver  |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server.jar    |

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.422+5 (default) | JAVA_HOME_8_X64      |
| 11.0.24+8           | JAVA_HOME_11_X64     |
| 17.0.12+7           | JAVA_HOME_17_X64     |
| 21.0.4+7.0          | JAVA_HOME_21_X64     |

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
- 1.20.14
- 1.21.13
- 1.22.8

#### Node.js
- 16.20.2
- 18.20.4
- 20.17.0

#### Python
- 3.7.9
- 3.8.10
- 3.9.13
- 3.10.11
- 3.11.9
- 3.12.7

#### PyPy
- 2.7.18 [PyPy 7.3.17]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.14 [PyPy 7.3.17]

#### Ruby
- 3.0.7
- 3.1.6
- 3.2.5

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.12                                                                                                                                |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 5.0.29.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.20.0
- DacFx 162.4.92.3
- MySQL 8.0.39.0
- SQL OLEDB Driver 18.7.4.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.27.2  | C:\tools\nginx-1.27.2\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version         | Path                                                     |
| ----------------------------- | --------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.11.35312.102 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 34.0.113.0      |
| aspire                                                                    | 8.100.24.37302  |
| Component.Android.NDK.R23C                                                | 17.11.35102.94  |
| Component.Android.SDK.MAUI                                                | 17.11.35102.94  |
| Component.Dotfuscator                                                     | 17.11.35102.94  |
| Component.Linux.CMake                                                     | 17.11.35102.94  |
| Component.Linux.RemoteFileExplorer                                        | 17.11.35102.94  |
| Component.MDD.Android                                                     | 17.11.35102.94  |
| Component.MDD.Linux                                                       | 17.11.35102.94  |
| Component.MDD.Linux.GCC.arm                                               | 17.11.35102.94  |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5919        |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.11.35102.94  |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.0.33617.0    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.11.35102.94  |
| Component.Microsoft.Web.LibraryManager                                    | 17.11.35102.94  |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.11.3.50567   |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.10   |
| Component.OpenJDK                                                         | 17.11.35102.94  |
| Component.UnityEngine.x64                                                 | 17.11.35102.94  |
| Component.Unreal                                                          | 17.11.35102.94  |
| Component.Unreal.Android                                                  | 17.11.35102.94  |
| Component.Unreal.Ide                                                      | 17.11.35102.94  |
| Component.VisualStudio.GitHub.Copilot                                     | 17.11.35312.31  |
| Component.VSInstallerProjects2022                                         | 2.0.1           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| Component.Xamarin                                                         | 17.11.35102.94  |
| Component.Xamarin.RemotedSimulator                                        | 17.11.35102.94  |
| ios                                                                       | 17.5.8030.0     |
| maccatalyst                                                               | 17.5.8030.0     |
| maui.blazor                                                               | 8.0.82.11329    |
| maui.core                                                                 | 8.0.82.11329    |
| maui.windows                                                              | 8.0.82.11329    |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.11.35102.94  |
| Microsoft.Component.ClickOnce                                             | 17.11.35102.94  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.11.35102.94  |
| Microsoft.Component.MSBuild                                               | 17.11.35102.94  |
| Microsoft.Component.NetFX.Native                                          | 17.11.35102.94  |
| Microsoft.Component.PythonTools                                           | 17.11.35102.94  |
| Microsoft.Component.PythonTools.Web                                       | 17.11.35102.94  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.11.35102.94  |
| Microsoft.ComponentGroup.Blend                                            | 17.11.35102.94  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.11.35102.94  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.11.35102.94  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.11.35102.94  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.11.35102.94  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.11.35102.94  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.11.35102.94  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.11.35102.94  |
| Microsoft.Net.Component.4.8.1.SDK                                         | 17.11.35102.94  |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 17.11.35102.94  |
| Microsoft.Net.Component.4.8.SDK                                           | 17.11.35102.94  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.11.35102.94  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.11.35102.94  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.11.35102.94  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.11.35102.94  |
| microsoft.net.runtime.android                                             | 8.0.824.36612   |
| microsoft.net.runtime.android.aot                                         | 8.0.824.36612   |
| microsoft.net.runtime.android.aot.net7                                    | 8.0.824.36612   |
| microsoft.net.runtime.android.net7                                        | 8.0.824.36612   |
| microsoft.net.runtime.ios                                                 | 8.0.824.36612   |
| microsoft.net.runtime.ios.net7                                            | 8.0.824.36612   |
| microsoft.net.runtime.maccatalyst                                         | 8.0.824.36612   |
| microsoft.net.runtime.maccatalyst.net7                                    | 8.0.824.36612   |
| microsoft.net.runtime.mono.tooling                                        | 8.0.824.36612   |
| microsoft.net.runtime.mono.tooling.net7                                   | 8.0.824.36612   |
| microsoft.net.sdk.emscripten                                              | 8.0.10.35802    |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.11.35102.94  |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.11.35303.118 |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 17.11.35303.118 |
| Microsoft.NetCore.Component.SDK                                           | 17.11.35303.118 |
| Microsoft.NetCore.Component.Web                                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.11.35118.42  |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.11.35118.42  |
| Microsoft.VisualStudio.Component.HLSL                                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Merq                                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.SecurityIssueAnalysis                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Unity                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.11.35118.42  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Web                                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 17.11.35102.94  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.Data                                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.Node                                      | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.Office                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.Python                                    | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.11.35102.94  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.11.35102.94  |
| runtimes.ios                                                              | 8.0.824.36612   |
| runtimes.ios.net7                                                         | 8.0.824.36612   |
| runtimes.maccatalyst                                                      | 8.0.824.36612   |
| runtimes.maccatalyst.net7                                                 | 8.0.824.36612   |
| wasm.tools                                                                | 8.0.824.36612   |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 3.0.4           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 3.0.1           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 1.5             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.1           |
| Windows Driver Kit                                                        | 10.1.22621.2428 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26100.10   |
| Windows Software Development Kit                                          | 10.1.22621.3233 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.40.33810 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.40.33810 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.40.33810 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.40.33810 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.40.33810 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.40.33810 |

#### Installed Windows SDKs
- 10.0.17763.0
- 10.0.19041.0
- 10.0.20348.0
- 10.0.22000.0
- 10.0.22621.0

### .NET Core Tools
- .NET Core SDK: 6.0.133, 6.0.203, 6.0.321, 6.0.425, 7.0.120, 7.0.203, 7.0.317, 7.0.410, 8.0.400
- .NET Framework: 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.5, 6.0.26, 6.0.32, 6.0.33, 7.0.5, 7.0.20, 8.0.8
- Microsoft.NETCore.App: 6.0.5, 6.0.26, 6.0.32, 6.0.33, 7.0.5, 7.0.20, 8.0.8
- Microsoft.WindowsDesktop.App: 6.0.5, 6.0.26, 6.0.33, 7.0.5, 7.0.20, 8.0.8
- nbgv 3.6.143+57d4199a9c

### PowerShell Tools
- PowerShell 7.4.5

#### Powershell Modules
- Az: 12.1.0
- Azure: 2.1.0 (Default), 5.3.0
- AzureRM: 2.1.0 (Default), 6.13.1
- Azure (Cached): 3.8.0.zip, 4.2.1.zip, 5.1.1.zip
- AzureRM (Cached): 3.8.0.zip, 4.2.1.zip, 5.1.1.zip, 6.7.0.zip
- AWSPowershell: 4.1.671
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.24.0
- Pester: 3.4.0, 5.6.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.22.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.3.0
- VSSetup: 2.2.16
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                         |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                             |
| Android Emulator           | 35.2.10                                                                                                                                                                                                                                                                         |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                             |
| Android SDK Platforms      | android-35 (rev 1)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                          |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                          |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                                                                                                                                                |
| Google Play services       | 49                                                                                                                                                                                                                                                                              |
| Google Repository          | 58                                                                                                                                                                                                                                                                              |
| NDK                        | 26.3.11579264<br>27.1.12297006                                                                                                                                                                                                                                                  |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.1.12297006 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.1.12297006 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\27.1.12297006 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.1.12297006 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:694e99af0ec996e63e6204e40e51869daf87c42d9bc628255804e32e2858b39c  | 2024-09-10 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:c9ff4d54c2a82dd154d3624fc8db44a9abe7913ab70f3aca5cb95213ed9621c5  | 2024-09-10 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:b6d6f01a449977c597a196a95f7f10e2c2b6438f7f9920744ceb11febeb61f27  | 2024-09-10 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:be3440ee2f36ed823a21df34e8e65026743d801dbc71e9311d03603775fc69c1  | 2024-09-05 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:b7b2e5b4c2414400c4eef13db747376e0f10ef8e15b8d0587ef5b953ad4e6d43  | 2024-09-06 |
