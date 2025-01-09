| Announcements |
|-|
| [[Windows ] Breaking change : PHP 8.3.* version will be updated to PHP 8.4.* from January 31,2025](https://github.com/actions/runner-images/issues/11256) |
| [Windows Server 2025 is now available](https://github.com/actions/runner-images/issues/11228) |
| [[Windows] Breaking change : Docker Engine Version 26.* will be updated  to Docker Engine Version 27.*   from January 17,2025](https://github.com/actions/runner-images/issues/11104) |
| [[Windows & Ubuntu] Breaking change : Maven 3.8.* version will be updated to  Maven 3.9.*  from January 17,2025](https://github.com/actions/runner-images/issues/11093) |
| [[Windows & Ubuntu] .NET 7.x will be removed from the images on January 17,2025](https://github.com/actions/runner-images/issues/10894) |
| [[Windows & Ubuntu] Python 3.7.x will be removed from  January 10 ,2025](https://github.com/actions/runner-images/issues/10893) |
***
# Windows Server 2022
- OS Version: 10.0.20348 Build 2966
- Image Version: 20250105.1.0

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.2.37(1)-release
- Go 1.21.13
- Julia 1.10.5
- Kotlin 2.1.0
- LLVM 18.1.8
- Node 18.20.5
- Perl 5.32.1
- PHP 8.3.15
- Python 3.9.13
- Ruby 3.0.7p220

### Package Management
- Chocolatey 2.4.1
- Composer 2.8.4
- Helm 3.16.3
- Miniconda 24.11.1 (pre-installed on the image but not added to PATH)
- NPM 10.8.2
- NuGet 6.12.1.1
- pip 24.3.1 (python 3.9)
- Pipx 1.7.1
- RubyGems 3.2.33
- Vcpkg (build from commit 65be70199)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.14
- Gradle 8.12
- Maven 3.8.7
- sbt 1.10.7

### Tools
- 7zip 24.09
- aria2 1.37.0
- azcopy 10.27.1
- Bazel 8.0.0
- Bazelisk 1.25.0
- Bicep 0.32.4
- Cabal 3.14.1.1
- CMake 3.31.3
- CodeQL Action Bundle 2.20.0
- Docker 26.1.3
- Docker Compose v2 2.27.1
- Docker-wincred 0.8.2
- ghc 9.12.1
- Git 2.47.1.windows.1
- Git LFS 3.6.0
- ImageMagick 7.1.1-43
- InnoSetup 6.3.3
- jq 1.7.1
- Kind 0.26.0
- Kubectl 1.32.0
- Mercurial 5.0
- gcc 12.2.0
- gdb 11.2
- GNU Binutils 2.39
- Newman 6.2.1
- NSIS 3.10
- OpenSSL 1.1.1w
- Packer 1.11.2
- Pulumi 3.144.1
- R 4.4.2
- Service Fabric SDK 9.1.1436.9590
- Stack 3.3.1
- Subversion (SVN) 1.14.5
- Swig 4.1.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.35.1
- zstd 1.5.6

### CLI Tools
- Alibaba Cloud CLI 3.0.244
- AWS CLI 2.22.28
- AWS SAM CLI 1.132.0
- AWS Session Manager CLI 1.2.694.0
- Azure CLI 2.67.0
- Azure DevOps CLI extension 1.0.1
- GitHub CLI 2.64.0

### Rust Tools
- Cargo 1.83.0
- Rust 1.83.0
- Rustdoc 1.83.0
- Rustup 1.27.1

#### Packages
- bindgen 0.71.1
- cargo-audit 0.21.0
- cargo-outdated 0.16.0
- cbindgen 0.27.0
- Clippy 0.1.83
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 131.0.6778.205
- Chrome Driver 131.0.6778.204
- Microsoft Edge 131.0.2903.112
- Microsoft Edge Driver 131.0.2903.112
- Mozilla Firefox 133.0.3
- Gecko Driver 0.35.0
- IE Driver 4.14.0.0
- Selenium server 4.27.0

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
| 8.0.432+6 (default) | JAVA_HOME_8_X64      |
| 11.0.25+9           | JAVA_HOME_11_X64     |
| 17.0.13+11          | JAVA_HOME_17_X64     |
| 21.0.5+11.0         | JAVA_HOME_21_X64     |

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
- 1.22.10
- 1.23.4

#### Node.js
- 16.20.2
- 18.20.5
- 20.18.1
- 22.12.0

#### Python
- 3.8.10
- 3.9.13
- 3.10.11
- 3.11.9
- 3.12.8

#### PyPy
- 2.7.18 [PyPy 7.3.17]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.14 [PyPy 7.3.17]

#### Ruby
- 3.0.7
- 3.1.6
- 3.2.6

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
| 5.0.30.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.21.0
- DacFx 162.5.57.1
- MySQL 8.0.40.0
- SQL OLEDB Driver 18.7.4.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.27.3  | C:\tools\nginx-1.27.3\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version         | Path                                                     |
| ----------------------------- | --------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.12.35527.113 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 35.0.7.0        |
| Component.Android.NDK.R23C                                                | 17.12.35410.122 |
| Component.Android.SDK.MAUI                                                | 17.12.35410.122 |
| Component.Dotfuscator                                                     | 17.12.35410.122 |
| Component.Linux.CMake                                                     | 17.12.35410.122 |
| Component.Linux.RemoteFileExplorer                                        | 17.12.35410.122 |
| Component.MDD.Android                                                     | 17.12.35410.122 |
| Component.MDD.Linux                                                       | 17.12.35410.122 |
| Component.MDD.Linux.GCC.arm                                               | 17.12.35410.122 |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5940        |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.12.35410.122 |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.0.33617.0    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.12.35410.122 |
| Component.Microsoft.Web.LibraryManager                                    | 17.12.35410.122 |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.12.8.55161   |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.10   |
| Component.OpenJDK                                                         | 17.12.35410.122 |
| Component.UnityEngine.x64                                                 | 17.12.35410.122 |
| Component.Unreal                                                          | 17.12.35410.122 |
| Component.Unreal.Android                                                  | 17.12.35410.122 |
| Component.Unreal.Ide                                                      | 17.12.35410.122 |
| Component.VisualStudio.GitHub.Copilot                                     | 17.12.35527.66  |
| Component.VSInstallerProjects2022                                         | 2.0.1           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| Component.Xamarin                                                         | 17.12.35410.122 |
| Component.Xamarin.RemotedSimulator                                        | 17.12.35410.122 |
| ios                                                                       | 18.1.9163.0     |
| maccatalyst                                                               | 18.1.9163.0     |
| maui.blazor                                                               | 9.0.0.11787     |
| maui.core                                                                 | 9.0.0.11787     |
| maui.windows                                                              | 9.0.0.11787     |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.12.35410.122 |
| Microsoft.Component.ClickOnce                                             | 17.12.35410.122 |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.12.35410.122 |
| Microsoft.Component.MSBuild                                               | 17.12.35410.122 |
| Microsoft.Component.NetFX.Native                                          | 17.12.35410.122 |
| Microsoft.Component.PythonTools                                           | 17.12.35410.122 |
| Microsoft.Component.PythonTools.Web                                       | 17.12.35410.122 |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.12.35410.122 |
| Microsoft.ComponentGroup.Blend                                            | 17.12.35410.122 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.12.35410.122 |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.12.35410.122 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.12.35410.122 |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.12.35410.122 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.12.35410.122 |
| Microsoft.Net.Component.4.7.2.SDK                                         | 17.12.35410.122 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.12.35410.122 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.12.35410.122 |
| Microsoft.Net.Component.4.8.1.SDK                                         | 17.12.35410.122 |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 17.12.35410.122 |
| Microsoft.Net.Component.4.8.SDK                                           | 17.12.35410.122 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.12.35410.122 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.12.35410.122 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.12.35410.122 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.12.35410.122 |
| microsoft.net.runtime.android                                             | 9.0.24.52809    |
| microsoft.net.runtime.android.aot                                         | 9.0.24.52809    |
| microsoft.net.runtime.android.aot.net8                                    | 9.0.24.52809    |
| microsoft.net.runtime.android.net8                                        | 9.0.24.52809    |
| microsoft.net.runtime.ios                                                 | 9.0.24.52809    |
| microsoft.net.runtime.ios.net8                                            | 9.0.24.52809    |
| microsoft.net.runtime.maccatalyst                                         | 9.0.24.52809    |
| microsoft.net.runtime.maccatalyst.net8                                    | 9.0.24.52809    |
| microsoft.net.runtime.mono.tooling                                        | 9.0.24.52809    |
| microsoft.net.runtime.mono.tooling.net8                                   | 9.0.24.52809    |
| microsoft.net.sdk.emscripten                                              | 9.0.11.2802     |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.12.35410.122 |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.12.35504.99  |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 17.12.35504.99  |
| Microsoft.NetCore.Component.Runtime.9.0                                   | 17.12.35527.66  |
| Microsoft.NetCore.Component.SDK                                           | 17.12.35527.66  |
| Microsoft.NetCore.Component.Web                                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.HLSL                                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.12.35527.102 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Merq                                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Unity                                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.12.35527.67  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Web                                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 17.12.35410.122 |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.Data                                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.12.35504.99  |
| Microsoft.VisualStudio.Workload.Node                                      | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.Office                                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.Python                                    | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.12.35410.122 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.12.35410.122 |
| runtimes.ios                                                              | 9.0.24.52809    |
| runtimes.ios.net8                                                         | 9.0.24.52809    |
| runtimes.maccatalyst                                                      | 9.0.24.52809    |
| runtimes.maccatalyst.net8                                                 | 9.0.24.52809    |
| wasm.tools                                                                | 9.0.24.52809    |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 3.0.4           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 3.0.1           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 1.5             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.1           |
| Windows Driver Kit                                                        | 10.1.26100.2161 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26100.10   |
| Windows Software Development Kit                                          | 10.1.26100.1742 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.42.34433 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.42.34433 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.42.34433 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.42.34433 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.42.34433 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.42.34433 |

#### Installed Windows SDKs
- 10.0.17763.0
- 10.0.19041.0
- 10.0.20348.0
- 10.0.22000.0
- 10.0.22621.0
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 6.0.136, 6.0.203, 6.0.321, 6.0.428, 7.0.120, 7.0.203, 7.0.317, 7.0.410, 8.0.111, 8.0.206, 8.0.307, 8.0.404, 9.0.101
- .NET Framework: 4.7.2, 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.5, 6.0.26, 6.0.35, 6.0.36, 7.0.5, 7.0.20, 8.0.6, 8.0.11, 9.0.0
- Microsoft.NETCore.App: 6.0.5, 6.0.26, 6.0.35, 6.0.36, 7.0.5, 7.0.20, 8.0.6, 8.0.11, 9.0.0
- Microsoft.WindowsDesktop.App: 6.0.5, 6.0.26, 6.0.36, 7.0.5, 7.0.20, 8.0.6, 8.0.11, 9.0.0
- nbgv 3.7.112+63bbe780b0

### PowerShell Tools
- PowerShell 7.4.6

#### Powershell Modules
- Az: 12.1.0
- Azure: 2.1.0 (Default), 5.3.0
- AzureRM: 2.1.0 (Default), 6.13.1
- Azure (Cached): 3.8.0.zip, 4.2.1.zip, 5.1.1.zip
- AzureRM (Cached): 3.8.0.zip, 4.2.1.zip, 5.1.1.zip, 6.7.0.zip
- AWSPowershell: 4.1.729
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.25.0
- Pester: 3.4.0, 5.6.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.23.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.3.0
- VSSetup: 2.2.16
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                     |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                                                         |
| Android Emulator           | 35.2.10                                                                                                                                                                                                                                                                                                     |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                         |
| Android SDK Platforms      | android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                                                      |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                      |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                                                                                                                                                                            |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                          |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                          |
| NDK                        | 26.3.11579264<br>27.2.12479018                                                                                                                                                                                                                                                                              |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.2.12479018 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:c49042631c866daf7ce7337cff2e8c881c8b15e3be6abfed03e0b22b685d4b49  | 2024-12-10 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:81845776459f460d3e50bc4e3fcb0db08f9f36722f5314c4281da3951cbb2fd4  | 2024-12-10 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:5dfdecd584d2f7c6852e4e807b6bb308da8f8350a0131ddef3cb0a0e6237523c  | 2024-12-10 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:eb59dfa1056e41b65cb12b679280e29f10d64e2b569b877710e227a77fef223f  | 2024-12-05 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:cd409960f9b87fcc02e1c236fea3852e1323ffb16d9522bf693330ebf878f5c0  | 2024-12-05 |

