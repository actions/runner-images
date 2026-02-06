| Announcements |
|-|
| [[Windows/Ubuntu] Docker Server and Client will be updated to version 29.1.*, Docker Compose will be updated to version 2.40.3 on February 9th, 2026](https://github.com/actions/runner-images/issues/13474) |
***
# Windows Server 2025
- OS Version: 10.0.26100 Build 32230
- Image Version: 20260203.4.1

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled
- Windows Subsystem for Linux (Default, WSLv2): 2.6.3.0

## Installed Software

### Language and Runtime
- Bash 5.2.37(1)-release
- Go 1.24.12
- Julia 1.12.0
- Kotlin 2.3.0
- LLVM 20.1.8
- Node 22.22.0
- Perl 5.42.0
- PHP 8.5.2
- Python 3.12.10
- Ruby 3.3.10

### Package Management
- Chocolatey 2.6.0
- Composer 2.9.5
- Helm 4.1.0
- Miniconda 25.11.1 (pre-installed on the image but not added to PATH)
- NPM 10.9.4
- NuGet 7.0.1.1
- pip 26.0 (python 3.12)
- Pipx 1.8.0
- RubyGems 3.5.22
- Vcpkg (build from commit cc73782a88)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.15
- Gradle 9.3
- Maven 3.9.12
- sbt 1.12.1

### Tools
- 7zip 25.01
- aria2 1.37.0
- azcopy 10.31.1
- Bazel 9.0.0
- Bazelisk 1.28.1
- Bicep 0.40.2
- Cabal 3.16.1.0
- CMake 4.2.3
- CodeQL Action Bundle 2.24.0
- Docker 27.5.1
- Docker Compose v2 2.32.2
- Docker-wincred 0.9.5
- ghc 9.14.1
- Git 2.53.0.windows.1
- Git LFS 3.7.1
- ImageMagick 7.1.2-13
- InnoSetup 6.7.0
- jq 1.8.1
- Kind 0.31.0
- Kubectl 1.35.0
- gcc 15.2.0
- gdb 16.3
- GNU Binutils 2.45
- Newman 6.2.2
- OpenSSL 3.6.1
- Packer 1.14.2
- Pulumi 3.218.0
- R 4.5.2
- Service Fabric SDK 10.1.2493.9590
- Stack 3.9.1
- Swig 4.3.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.38.0
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- AWS CLI 2.33.12
- AWS SAM CLI 1.153.1
- AWS Session Manager CLI 1.2.764.0
- Azure CLI 2.83.0
- Azure DevOps CLI extension 1.0.2
- GitHub CLI 2.86.0

### Rust Tools
- Cargo 1.93.0
- Rust 1.93.0
- Rustdoc 1.93.0
- Rustup 1.28.2

#### Packages
- Clippy 0.1.93
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 144.0.7559.110
- Chrome Driver 144.0.7559.109
- Microsoft Edge 144.0.3719.104
- Microsoft Edge Driver 144.0.3719.104
- Mozilla Firefox 147.0.2
- Gecko Driver 0.36.0
- IE Driver 4.14.0.0
- Selenium server 4.40.0

#### Environment variables
| Name              | Value                              |
| ----------------- | ---------------------------------- |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver  |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server.jar    |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.472+8            | JAVA_HOME_8_X64      |
| 11.0.29+7            | JAVA_HOME_11_X64     |
| 17.0.17+10 (default) | JAVA_HOME_17_X64     |
| 21.0.9+10.0          | JAVA_HOME_21_X64     |
| 25.0.2+10.0          | JAVA_HOME_25_X64     |

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
- 1.22.12
- 1.23.12
- 1.24.12
- 1.25.6

#### Node.js
- 20.20.0
- 22.22.0
- 24.13.0

#### Python
- 3.10.11
- 3.11.9
- 3.12.10
- 3.13.11
- 3.14.2

#### PyPy
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.2.10
- 3.3.10
- 3.4.8
- 4.0.1

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| ServiceName          | postgresql-x64-17                                                                                                      |
| Version              | 17.7                                                                                                                   |
| ServiceStatus        | Stopped                                                                                                                |
| ServiceStartType     | Disabled                                                                                                               |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\17\bin <br> PGDATA=C:\PostgreSQL\17\data <br> PGROOT=C:\Program Files\PostgreSQL\17  |
| Path                 | C:\Program Files\PostgreSQL\17                                                                                         |
| UserName             | postgres                                                                                                               |
| Password             | root                                                                                                                   |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 7.0.29.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.25.0
- DacFx 170.2.70.1
- MySQL 8.0.45.0
- SQL OLEDB Driver 18 18.7.5.0
- SQL OLEDB Driver 19 19.4.1.0
- SQLPS 1.0
- MongoDB Shell (mongosh) 2.6.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.29.4  | C:\tools\nginx-1.29.4\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2026
| Name                          | Version        | Path                                                   |
| ----------------------------- | -------------- | ------------------------------------------------------ |
| Visual Studio Enterprise 2026 | 18.2.11415.280 | C:\Program Files\Microsoft Visual Studio\18\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 36.1.2.0        |
| Component.Android.NDK.R27C                                                | 18.0.11101.84   |
| Component.Android.SDK.MAUI                                                | 18.0.11101.84   |
| Component.Linux.CMake                                                     | 18.0.11101.84   |
| Component.Linux.RemoteFileExplorer                                        | 18.0.11101.84   |
| Component.MDD.Android                                                     | 18.1.11302.112  |
| Component.MDD.Linux                                                       | 18.0.11101.78   |
| Component.Microsoft.VisualStudio.RazorExtension                           | 18.0.11101.84   |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.0.36522.0    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 18.0.11101.84   |
| Component.Microsoft.Web.LibraryManager                                    | 18.0.11101.84   |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.12   |
| Component.OpenJDK                                                         | 18.0.11101.84   |
| Component.UnityEngine.x64                                                 | 18.0.11101.78   |
| Component.Unreal.Debugger                                                 | 18.2.11407.205  |
| Component.Unreal.Ide                                                      | 18.0.11101.78   |
| Component.VisualStudio.GitHub.Copilot                                     | 18.2.11414.340  |
| Component.VSInstallerProjects2022                                         | 3.0.0           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| ComponentGroup.Microsoft.NET.AppModernization                             | 18.0.11217.1    |
| ios                                                                       | 26.1.10502      |
| maccatalyst                                                               | 26.1.10502      |
| maui.blazor                                                               | 10.0.1.7412     |
| maui.core                                                                 | 10.0.1.7412     |
| maui.windows                                                              | 10.0.1.7412     |
| Microsoft.Component.Azure.DataLake.Tools                                  | 18.1.11302.112  |
| Microsoft.Component.ClickOnce                                             | 18.0.11101.78   |
| Microsoft.Component.CodeAnalysis.SDK                                      | 18.0.11101.84   |
| Microsoft.Component.MSBuild                                               | 18.0.11101.78   |
| Microsoft.Component.NetFX.Native                                          | 18.0.11101.78   |
| Microsoft.Component.PythonTools                                           | 18.0.11101.78   |
| Microsoft.Component.PythonTools.Web                                       | 18.0.11101.78   |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 18.0.11101.78   |
| Microsoft.ComponentGroup.Blend                                            | 18.0.11101.84   |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 18.0.11101.84   |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 18.0.11101.78   |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 18.0.11101.84   |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 18.0.11101.78   |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 18.0.11101.84   |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 18.0.11101.84   |
| Microsoft.Net.Component.4.8.1.SDK                                         | 18.0.11101.78   |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 18.0.11101.78   |
| Microsoft.Net.Component.4.8.SDK                                           | 18.0.11101.84   |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 18.0.11101.84   |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 18.0.11101.84   |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 18.0.11101.84   |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 18.0.11101.84   |
| microsoft.net.runtime.android                                             | 10.1.225.61305  |
| microsoft.net.runtime.android.aot                                         | 10.1.225.61305  |
| microsoft.net.runtime.android.aot.net9                                    | 10.1.225.61305  |
| microsoft.net.runtime.android.net9                                        | 10.1.225.61305  |
| microsoft.net.runtime.ios                                                 | 10.1.225.61305  |
| microsoft.net.runtime.ios.net9                                            | 10.1.225.61305  |
| microsoft.net.runtime.maccatalyst                                         | 10.1.225.61305  |
| microsoft.net.runtime.maccatalyst.net9                                    | 10.1.225.61305  |
| microsoft.net.runtime.mono.tooling                                        | 10.1.225.61305  |
| microsoft.net.runtime.mono.tooling.net9                                   | 10.1.225.61305  |
| microsoft.net.sdk.emscripten                                              | 10.1.225.61305  |
| Microsoft.NetCore.Component.DevelopmentTools                              | 18.0.11101.78   |
| Microsoft.NetCore.Component.Runtime.10.0                                  | 18.2.11407.205  |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 18.2.11407.205  |
| Microsoft.NetCore.Component.SDK                                           | 18.2.11407.205  |
| Microsoft.NetCore.Component.Web                                           | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.AspNet                                   | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.AspNet45                                 | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.CodeMap                                  | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.CoreEditor                               | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.DockerTools                              | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.DslTools                                 | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.EntityFramework                          | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.FSharp                                   | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.GraphDocument                            | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Graphics                                 | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.HLSL                                     | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.IISExpress                               | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.IntelliCode                              | 18.0.11121.172  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.LinqToSql                                | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.Node.Tools                               | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.NuGet                                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.TeamOffice                               | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.TextTemplating                           | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Unity                                    | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.VC.14.44.17.14.x86.x64                   | 18.2.11414.340  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 18.0.11123.170  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 18.1.11302.112  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.VSSDK                                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Web                                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.WebDeploy                                | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 18.2.11407.205  |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 18.0.11101.84   |
| Microsoft.VisualStudio.Component.Workflow                                 | 18.0.11101.78   |
| Microsoft.VisualStudio.Component.WslDebugging                             | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 18.1.11302.112  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 18.0.11111.16   |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 18.0.11123.170  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 18.0.11101.84   |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.Azure                                     | 18.2.11406.125  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.Data                                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.DataScience                               | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 18.0.11123.170  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 18.0.11123.170  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 18.1.11302.112  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.Node                                      | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.Office                                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.Python                                    | 18.0.11101.84   |
| Microsoft.VisualStudio.Workload.Universal                                 | 18.0.11123.170  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 18.0.11101.84   |
| runtimes.ios                                                              | 10.1.225.61305  |
| runtimes.ios.net9                                                         | 10.1.225.61305  |
| runtimes.maccatalyst                                                      | 10.1.225.61305  |
| runtimes.maccatalyst.net9                                                 | 10.1.225.61305  |
| wasm.tools                                                                | 10.1.225.61305  |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 4.0.0           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 4.0.0           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 2.1.2           |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 3.0.0           |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26100.12   |
| Windows Software Development Kit                                          | 10.1.26100.7175 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.50.35719 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.50.35719 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.50.35719 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.50.35719 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.50.35719 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.50.35719 |

#### Installed Windows SDKs
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 8.0.123, 8.0.206, 8.0.319, 8.0.417, 9.0.113, 9.0.205, 9.0.310, 10.0.102
- .NET Framework: 4.8, 4.8.1
- Microsoft.AspNetCore.App: 8.0.6, 8.0.22, 8.0.23, 9.0.6, 9.0.12, 10.0.2
- Microsoft.NETCore.App: 8.0.6, 8.0.22, 8.0.23, 9.0.6, 9.0.12, 10.0.2
- Microsoft.WindowsDesktop.App: 8.0.6, 8.0.22, 8.0.23, 9.0.6, 9.0.12, 10.0.2
- nbgv 3.9.50+6feeb89450

### PowerShell Tools
- PowerShell 7.4.13

#### Powershell Modules
- Az: 14.6.0
- AWSPowershell: 5.0.146
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.35.0
- Pester: 3.4.0, 5.7.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.24.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.3.0
- VSSetup: 2.2.16

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 19.0                                                                                                                                                                                                                                                                                                                  |
| Android Emulator           | 36.3.10                                                                                                                                                                                                                                                                                                               |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                              |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android SDK Platform-Tools | 36.0.2                                                                                                                                                                                                                                                                                                                |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                |
| CMake                      | 3.30.5<br>3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                             |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                    |
| NDK                        | 27.3.13750724<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                                       |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\29.0.14206865 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |
