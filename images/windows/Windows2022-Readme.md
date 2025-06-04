| Announcements |
|-|
| [[Windows & Ubuntu] .NET 6 will be removed from the images on  2025-08-01.](https://github.com/actions/runner-images/issues/12241) |
| [[Ubuntu 22.04 and Windows 2022] Default Nodejs version will be set to 20 on 2025-06-02](https://github.com/actions/runner-images/issues/12143) |
| [The Windows 2019 Actions runner image will begin deprecation on 2025-06-01 and will be fully unsupported by 2025-06-30](https://github.com/actions/runner-images/issues/12045) |
| [[Windows, Ubuntu] Python 3.8.x will be removed from 2025-06-06](https://github.com/actions/runner-images/issues/12034) |
| [[Windows 19 and 22] Ruby version 3.0 will be removed from Windows images on 2025-06-06](https://github.com/actions/runner-images/issues/12033) |
| [[Windows-2025] LLVM will be updated to version 20 on 2025-06-06](https://github.com/actions/runner-images/issues/12001) |
| [Windows Server 2025 is now available](https://github.com/actions/runner-images/issues/11228) |
***
# Windows Server 2022
- OS Version: 10.0.20348 Build 3692
- Image Version: 20250527.1.0

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.2.37(1)-release
- Go 1.24.3
- Julia 1.11.5
- Kotlin 2.1.10
- LLVM 18.1.8
- Node 18.20.8
- Perl 5.32.1
- PHP 8.4.7
- Python 3.9.13
- Ruby 3.0.7p220

### Package Management
- Chocolatey 2.4.3
- Composer 2.8.9
- Helm 3.17.3
- Miniconda 25.3.1 (pre-installed on the image but not added to PATH)
- NPM 10.8.2
- NuGet 6.14.0.116
- pip 25.1.1 (python 3.9)
- Pipx 1.7.1
- RubyGems 3.2.33
- Vcpkg (build from commit 46a8b3026c)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.15
- Gradle 8.14
- Maven 3.9.9
- sbt 1.11.0

### Tools
- 7zip 24.09
- aria2 1.37.0
- azcopy 10.29.1
- Bazel 8.2.1
- Bazelisk 1.26.0
- Bicep 0.35.1
- Cabal 3.14.2.0
- CMake 3.31.6
- CodeQL Action Bundle 2.21.3
- Docker 27.5.1
- Docker Compose v2 2.32.2
- Docker-wincred 0.9.3
- ghc 9.12.2
- Git 2.49.0.windows.1
- Git LFS 3.6.1
- ImageMagick 7.1.1-47
- InnoSetup 6.4.0
- jq 1.7.1
- Kind 0.29.0
- Kubectl 1.33.1
- Mercurial 5.0
- gcc 12.2.0
- gdb 11.2
- GNU Binutils 2.39
- Newman 6.2.1
- NSIS 3.10
- OpenSSL 1.1.1w
- Packer 1.12.0
- Pulumi 3.167.0
- R 4.4.2
- Service Fabric SDK 10.1.2493.9590
- Stack 3.5.1
- Subversion (SVN) 1.14.5
- Swig 4.1.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.37.1
- zstd 1.5.7
- Ninja 1.12.1

### CLI Tools
- Alibaba Cloud CLI 3.0.278
- AWS CLI 2.27.22
- AWS SAM CLI 1.139.0
- AWS Session Manager CLI 1.2.707.0
- Azure CLI 2.73.0
- Azure DevOps CLI extension 1.0.1
- GitHub CLI 2.73.0

### Rust Tools
- Cargo 1.87.0
- Rust 1.87.0
- Rustdoc 1.87.0
- Rustup 1.28.2

#### Packages
- bindgen 0.71.1
- cargo-audit 0.21.2
- cargo-outdated 0.17.0
- cbindgen 0.29.0
- Clippy 0.1.87
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 137.0.7151.56
- Chrome Driver 137.0.7151.55
- Microsoft Edge 136.0.3240.92
- Microsoft Edge Driver 136.0.3240.92
- Mozilla Firefox 139.0
- Gecko Driver 0.36.0
- IE Driver 4.14.0.0
- Selenium server 4.33.0

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
| 8.0.452+9 (default) | JAVA_HOME_8_X64      |
| 11.0.27+6           | JAVA_HOME_11_X64     |
| 17.0.15+6           | JAVA_HOME_17_X64     |
| 21.0.7+6.0          | JAVA_HOME_21_X64     |

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
- 1.23.9
- 1.24.3

#### Node.js
- 18.20.8
- 20.19.2
- 22.16.0

#### Python
- 3.8.10
- 3.9.13
- 3.10.11
- 3.11.9
- 3.12.10
- 3.13.3

#### PyPy
- 2.7.18 [PyPy 7.3.19]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.0.7
- 3.1.7
- 3.2.8
- 3.3.8

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.18                                                                                                                                |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 5.0.31.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.23.0
- DacFx 170.0.94.3
- MySQL 8.0.42.0
- SQL OLEDB Driver 18.7.4.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.27.5  | C:\tools\nginx-1.27.5\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version         | Path                                                     |
| ----------------------------- | --------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.13.35825.156 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 35.0.39.0       |
| Component.Android.NDK.R23C                                                | 17.13.35710.127 |
| Component.Android.SDK.MAUI                                                | 17.13.35710.127 |
| Component.Dotfuscator                                                     | 17.13.35710.127 |
| Component.Linux.CMake                                                     | 17.13.35710.127 |
| Component.Linux.RemoteFileExplorer                                        | 17.13.35710.127 |
| Component.MDD.Android                                                     | 17.13.35710.127 |
| Component.MDD.Linux                                                       | 17.13.35710.127 |
| Component.MDD.Linux.GCC.arm                                               | 17.13.35710.127 |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5949        |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.13.35710.127 |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.0.33617.0    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.13.35710.127 |
| Component.Microsoft.Web.LibraryManager                                    | 17.13.35710.127 |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.13.10.44860  |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.12   |
| Component.OpenJDK                                                         | 17.13.35710.127 |
| Component.UnityEngine.x64                                                 | 17.13.35710.127 |
| Component.Unreal                                                          | 17.13.35710.127 |
| Component.Unreal.Android                                                  | 17.13.35710.127 |
| Component.Unreal.Ide                                                      | 17.13.35710.127 |
| Component.VisualStudio.GitHub.Copilot                                     | 17.13.35820.181 |
| Component.VSInstallerProjects2022                                         | 2.0.1           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| Component.Xamarin                                                         | 17.13.35710.127 |
| Component.Xamarin.RemotedSimulator                                        | 17.13.35710.127 |
| ios                                                                       | 18.2.9180.0     |
| maccatalyst                                                               | 18.2.9180.0     |
| maui.blazor                                                               | 9.0.14.12048    |
| maui.core                                                                 | 9.0.14.12048    |
| maui.windows                                                              | 9.0.14.12048    |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.13.35710.127 |
| Microsoft.Component.ClickOnce                                             | 17.13.35710.127 |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.13.35710.127 |
| Microsoft.Component.MSBuild                                               | 17.13.35710.127 |
| Microsoft.Component.NetFX.Native                                          | 17.13.35710.127 |
| Microsoft.Component.PythonTools                                           | 17.13.35710.127 |
| Microsoft.Component.PythonTools.Web                                       | 17.13.35710.127 |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.13.35710.127 |
| Microsoft.ComponentGroup.Blend                                            | 17.13.35710.127 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.13.35710.127 |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.13.35710.127 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.13.35710.127 |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.13.35710.127 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.13.35710.127 |
| Microsoft.Net.Component.4.7.2.SDK                                         | 17.13.35710.127 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.13.35710.127 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.13.35710.127 |
| Microsoft.Net.Component.4.8.1.SDK                                         | 17.13.35710.127 |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 17.13.35710.127 |
| Microsoft.Net.Component.4.8.SDK                                           | 17.13.35710.127 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.13.35710.127 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.13.35710.127 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.13.35710.127 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.13.35710.127 |
| microsoft.net.runtime.android                                             | 9.0.225.6610    |
| microsoft.net.runtime.android.aot                                         | 9.0.225.6610    |
| microsoft.net.runtime.android.aot.net8                                    | 9.0.225.6610    |
| microsoft.net.runtime.android.net8                                        | 9.0.225.6610    |
| microsoft.net.runtime.ios                                                 | 9.0.225.6610    |
| microsoft.net.runtime.ios.net8                                            | 9.0.225.6610    |
| microsoft.net.runtime.maccatalyst                                         | 9.0.225.6610    |
| microsoft.net.runtime.maccatalyst.net8                                    | 9.0.225.6610    |
| microsoft.net.runtime.mono.tooling                                        | 9.0.225.6610    |
| microsoft.net.runtime.mono.tooling.net8                                   | 9.0.225.6610    |
| microsoft.net.sdk.emscripten                                              | 9.0.12.6102     |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.13.35710.127 |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 17.13.35806.99  |
| Microsoft.NetCore.Component.Runtime.9.0                                   | 17.13.35806.99  |
| Microsoft.NetCore.Component.SDK                                           | 17.13.35806.99  |
| Microsoft.NetCore.Component.Web                                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.HLSL                                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Unity                                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Web                                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 17.13.35710.127 |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.Data                                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.13.35818.55  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.13.35730.67  |
| Microsoft.VisualStudio.Workload.Node                                      | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.Office                                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.Python                                    | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.13.35710.127 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.13.35710.127 |
| runtimes.ios                                                              | 9.0.225.6610    |
| runtimes.ios.net8                                                         | 9.0.225.6610    |
| runtimes.maccatalyst                                                      | 9.0.225.6610    |
| runtimes.maccatalyst.net8                                                 | 9.0.225.6610    |
| wasm.tools                                                                | 9.0.225.6610    |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 3.0.4           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 3.0.1           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 1.5             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.1           |
| Windows Driver Kit                                                        | 10.1.26100.2161 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26100.12   |
| Windows Software Development Kit                                          | 10.1.26100.2454 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.44.35112 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.42.34438 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.44.35112 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.44.35112 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.42.34438 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.44.35112 |

#### Installed Windows SDKs
- 10.0.17763.0
- 10.0.19041.0
- 10.0.20348.0
- 10.0.22000.0
- 10.0.22621.0
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 6.0.136, 6.0.203, 6.0.321, 6.0.428, 8.0.116, 8.0.206, 8.0.313, 8.0.410, 9.0.106, 9.0.200, 9.0.204, 9.0.300
- .NET Framework: 4.7.2, 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.5, 6.0.26, 6.0.36, 6.0.38, 8.0.6, 8.0.13, 8.0.16, 9.0.2, 9.0.5
- Microsoft.NETCore.App: 6.0.5, 6.0.26, 6.0.36, 6.0.38, 8.0.6, 8.0.13, 8.0.16, 9.0.2, 9.0.5
- Microsoft.WindowsDesktop.App: 6.0.5, 6.0.26, 6.0.36, 8.0.6, 8.0.13, 8.0.16, 9.0.2, 9.0.5
- nbgv 3.7.115+d31f50f4d1

### PowerShell Tools
- PowerShell 7.4.10

#### Powershell Modules
- Az: 12.4.0
- AWSPowershell: 4.1.828
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.28.0
- Pester: 3.4.0, 5.7.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.24.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.3.0
- VSSetup: 2.2.16

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                                                                                                           |
| Android Emulator           | 35.5.10                                                                                                                                                                                                                                                                                                                                                       |
| Android SDK Build-tools    | 36.0.0<br>35.0.0 35.0.1<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                                                          |
| Android SDK Platforms      | android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                        |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                            |
| NDK                        | 26.3.11579264<br>27.2.12479018<br>28.1.13356709                                                                                                                                                                                                                                                                                                               |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\28.1.13356709 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:e5eebb018821e03125ba26ece2f1f79d9a935124d1a9e6ea9ef969aec5c79162  | 2025-05-13 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:2ceebeeb08b828c3ed61449939894857ee5b20e78dfbb56a8926222994ad7ac1  | 2025-05-13 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:e3f950b82719ebcd38eaf9fc4623c1022c5632f4ee6550cd9c949ac2658e3e27  | 2025-05-13 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:73c8ef1336c6d577fa7beb0dcdbb8b690ee84e2eb5251f98b5234c8c1cc1df60  | 2025-05-09 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:a9e475f9925792421937e65bd191d79f97578e3013865b0b71f4fadee0d16d09  | 2025-05-09 |

