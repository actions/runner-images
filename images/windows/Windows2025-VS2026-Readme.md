| Announcements |
|-|
| [[All OS] PowerShell will be updated from 7.4 to 7.6 LTS on all runner images](https://github.com/actions/runner-images/issues/14150) |
| [[All OS] Azure PowerShell module will be updated from 12.5.0/14.6.0 to 15.6.1](https://github.com/actions/runner-images/issues/14104) |
| [[ARM] Arm64 runner images now maintained by GitHub](https://github.com/actions/runner-images/issues/14100) |
| [[Windows] `windows-latest` and `windows-2025` image-label will use Windows Server 2025 with Visual Studio 2026 image in June 2026](https://github.com/actions/runner-images/issues/14017) |
| [[Windows] The Windows Server 2025 with Visual Studio 2026 is now generally available in GitHub Actions](https://github.com/actions/runner-images/issues/14016) |
***
# Windows Server 2025
- OS Version: 10.0.26100 Build 32860
- Image Version: 20260608.135.2

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled
- Windows Subsystem for Linux (Default, WSLv2): 2.7.3.0

## Installed Software

### Language and Runtime
- Bash 5.3.9(1)-release
- Go 1.24.13
- Julia 1.12.0
- Kotlin 2.4.0
- LLVM 20.1.8
- Node 22.22.3
- Perl 5.42.0
- PHP 8.5.7
- Python 3.12.10
- Ruby 3.3.11

### Package Management
- Chocolatey 2.7.2
- Composer 2.10.1
- Helm 4.1.4
- Miniconda 26.3.2 (pre-installed on the image but not added to PATH)
- NPM 10.9.8
- NuGet 7.6.0.59
- pip 26.1.2 (python 3.12)
- Pipx 1.14.0
- RubyGems 3.5.22
- Vcpkg (build from commit 75672db6bd)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.17
- Gradle 9.5
- Maven 3.9.16
- sbt 1.12.11

### Tools
- 7zip 26.01
- aria2 1.37.0
- azcopy 10.32.4
- Bazel 9.1.1
- Bazelisk 1.28.1
- Bicep 0.43.8
- Cabal 3.16.1.0
- CMake 4.3.3
- CodeQL Action Bundle 2.25.6
- Docker 29.1.5
- Docker Compose 2.40.3
- Docker-wincred 0.9.7
- ghc 9.14.1
- Git 2.54.0.windows.1
- Git LFS 3.7.1
- ImageMagick 7.1.2-25
- InnoSetup 6.7.1
- jq 1.8.1
- Kind 0.32.0
- Kubectl 1.36.1
- gcc 15.2.0
- gdb 17.1
- GNU Binutils 2.46
- Newman 6.2.2
- OpenSSL 3.6.2
- Packer 1.15.3
- Pulumi 3.245.0
- R 4.6.0
- Service Fabric SDK 10.1.2493.9590
- Stack 3.9.3
- Swig 4.3.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.38.0
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- AWS CLI 2.34.63
- AWS SAM CLI 1.161.1
- AWS Session Manager CLI 1.2.814.0
- Azure CLI 2.87.0
- Azure DevOps CLI extension 1.0.4
- GitHub CLI 2.93.0

### Rust Tools
- Cargo 1.96.0
- Rust 1.96.0
- Rustdoc 1.96.0
- Rustup 1.29.0

#### Packages
- Clippy 0.1.96
- Rustfmt 1.9.0

### Browsers and Drivers
- Google Chrome 149.0.7827.54
- Chrome Driver 149.0.7827.54
- Microsoft Edge 149.0.4022.52
- Microsoft Edge Driver 149.0.4022.52
- Mozilla Firefox 151.0.3
- Gecko Driver 0.37.0
- IE Driver 4.14.0.0
- Selenium server 4.44.0

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
| 8.0.492+9            | JAVA_HOME_8_X64      |
| 11.0.31+11           | JAVA_HOME_11_X64     |
| 17.0.19+10 (default) | JAVA_HOME_17_X64     |
| 21.0.11+10.0         | JAVA_HOME_21_X64     |
| 25.0.3+9.0           | JAVA_HOME_25_X64     |

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
- 1.24.13
- 1.25.11

#### Node.js
- 22.22.3
- 24.16.0

#### Python
- 3.10.11
- 3.11.9
- 3.12.10
- 3.13.13
- 3.14.5

#### PyPy
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.2.11
- 3.3.11
- 3.4.9
- 4.0.5

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| ServiceName          | postgresql-x64-17                                                                                                      |
| Version              | 17.10                                                                                                                  |
| ServiceStatus        | Stopped                                                                                                                |
| ServiceStartType     | Disabled                                                                                                               |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\17\bin <br> PGDATA=C:\PostgreSQL\17\data <br> PGROOT=C:\Program Files\PostgreSQL\17  |
| Path                 | C:\Program Files\PostgreSQL\17                                                                                         |
| UserName             | postgres                                                                                                               |
| Password             | root                                                                                                                   |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 7.0.34.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.27.0
- DacFx 170.4.83.3
- MySQL 8.0.46.0
- SQL OLEDB Driver 18 18.7.5.0
- SQL OLEDB Driver 19 19.4.1.0
- SQLPS 1.0
- MongoDB Shell (mongosh) 2.8.3

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.31.1  | C:\tools\nginx-1.31.1\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2026
| Name                          | Version        | Path                                                   |
| ----------------------------- | -------------- | ------------------------------------------------------ |
| Visual Studio Enterprise 2026 | 18.6.11822.322 | C:\Program Files\Microsoft Visual Studio\18\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 36.1.43.0       |
| Component.Android.NDK.R27C                                                | 18.6.11706.339  |
| Component.Android.SDK.MAUI                                                | 18.6.11706.339  |
| Component.Linux.CMake                                                     | 18.6.11706.339  |
| Component.Linux.RemoteFileExplorer                                        | 18.6.11706.339  |
| Component.MDD.Linux                                                       | 18.6.11706.339  |
| Component.Microsoft.NET.AppModernization                                  | 18.6.11820.303  |
| Component.Microsoft.VisualStudio.RazorExtension                           | 18.6.11706.339  |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.1.37110.1    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 18.6.11706.339  |
| Component.Microsoft.Web.LibraryManager                                    | 18.6.11706.339  |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.16   |
| Component.OpenJDK                                                         | 18.6.11706.339  |
| Component.UnityEngine.x64                                                 | 18.6.11706.339  |
| Component.Unreal.Debugger                                                 | 18.6.11706.339  |
| Component.Unreal.Ide                                                      | 18.6.11706.339  |
| Component.VisualStudio.GitHub.Copilot                                     | 18.6.11706.339  |
| Component.VSInstallerProjects2022                                         | 3.0.0           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| ComponentGroup.Microsoft.NET.AppModernization                             | 18.6.11706.339  |
| ios                                                                       | 26.2.10233      |
| maccatalyst                                                               | 26.2.10233      |
| maui.blazor                                                               | 10.0.20.7528    |
| maui.core                                                                 | 10.0.20.7528    |
| maui.windows                                                              | 10.0.20.7528    |
| Microsoft.Component.Azure.DataLake.Tools                                  | 18.6.11706.339  |
| Microsoft.Component.ClickOnce                                             | 18.6.11706.339  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 18.6.11706.339  |
| Microsoft.Component.MSBuild                                               | 18.6.11706.339  |
| Microsoft.Component.NetFX.Native                                          | 18.6.11706.339  |
| Microsoft.Component.PythonTools                                           | 18.6.11706.339  |
| Microsoft.Component.PythonTools.Web                                       | 18.6.11706.339  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 18.6.11706.339  |
| Microsoft.ComponentGroup.Blend                                            | 18.6.11706.339  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 18.6.11706.339  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 18.6.11706.339  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 18.6.11706.339  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 18.6.11706.339  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 18.6.11706.339  |
| Microsoft.Net.Component.4.8.1.SDK                                         | 18.6.11706.339  |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 18.6.11706.339  |
| Microsoft.Net.Component.4.8.SDK                                           | 18.6.11706.339  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 18.6.11706.339  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 18.6.11706.339  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 18.6.11706.339  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 18.6.11706.339  |
| microsoft.net.runtime.android                                             | 10.1.826.23019  |
| microsoft.net.runtime.android.aot                                         | 10.1.826.23019  |
| microsoft.net.runtime.android.aot.net9                                    | 10.1.826.23019  |
| microsoft.net.runtime.android.net9                                        | 10.1.826.23019  |
| microsoft.net.runtime.ios                                                 | 10.1.826.23019  |
| microsoft.net.runtime.ios.net9                                            | 10.1.826.23019  |
| microsoft.net.runtime.maccatalyst                                         | 10.1.826.23019  |
| microsoft.net.runtime.maccatalyst.net9                                    | 10.1.826.23019  |
| microsoft.net.runtime.mono.tooling                                        | 10.1.826.23019  |
| microsoft.net.runtime.mono.tooling.net9                                   | 10.1.826.23019  |
| microsoft.net.sdk.emscripten                                              | 10.1.826.23019  |
| Microsoft.NetCore.Component.DevelopmentTools                              | 18.6.11706.339  |
| Microsoft.NetCore.Component.Runtime.10.0                                  | 18.6.11806.211  |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 18.6.11806.211  |
| Microsoft.NetCore.Component.SDK                                           | 18.6.11806.211  |
| Microsoft.NetCore.Component.Web                                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.AspNet                                   | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.DockerTools                              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.DslTools                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.FSharp                                   | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Graphics                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.HLSL                                     | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.IISExpress                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.LinqToSql                                | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.NuGet                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Unity                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.14.44.17.14.x86.x64                   | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Web                                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 18.6.11806.211  |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.Workflow                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 18.6.11706.339  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.Azure                                     | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.Data                                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.DataScience                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.Node                                      | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.Office                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.Python                                    | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.Universal                                 | 18.6.11706.339  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 18.6.11706.339  |
| runtimes.ios                                                              | 10.1.826.23019  |
| runtimes.ios.net9                                                         | 10.1.826.23019  |
| runtimes.maccatalyst                                                      | 10.1.826.23019  |
| runtimes.maccatalyst.net9                                                 | 10.1.826.23019  |
| wasm.tools                                                                | 10.1.826.23019  |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 4.0.0           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 4.0.0           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 2.2             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 3.0.0           |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26586.0    |
| Windows Software Development Kit                                          | 10.1.26100.8249 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.51.36231 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.51.36231 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.51.36231 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.51.36231 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.51.36231 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.51.36231 |

#### Installed Windows SDKs
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 8.0.127, 8.0.206, 8.0.319, 8.0.421, 9.0.117, 9.0.205, 9.0.314, 10.0.108, 10.0.204, 10.0.300
- .NET Framework: 4.8, 4.8.1
- Microsoft.AspNetCore.App: 8.0.6, 8.0.22, 8.0.27, 9.0.6, 9.0.16, 10.0.8
- Microsoft.NETCore.App: 8.0.6, 8.0.22, 8.0.27, 9.0.6, 9.0.16, 10.0.8
- Microsoft.WindowsDesktop.App: 8.0.6, 8.0.22, 8.0.27, 9.0.6, 9.0.16, 10.0.8
- nbgv 3.9.50+6feeb89450

### PowerShell Tools
- PowerShell 7.4.16

#### Powershell Modules
- Az: 15.6.1
- AWSPowershell: 5.0.228
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.37.0
- Pester: 3.4.0, 5.7.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.25.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.3.0
- VSSetup: 2.2.16

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 19.0                                                                                                                                                                                                                                                                                                                                          |
| Android Emulator           | 36.6.11                                                                                                                                                                                                                                                                                                                                       |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                                            |
| Android SDK Platforms      | android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android SDK Platform-Tools | 37.0.0                                                                                                                                                                                                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                        |
| CMake                      | 3.30.5<br>3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                                     |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                            |
| NDK                        | 27.3.13750724<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                                                               |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\29.0.14206865 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

