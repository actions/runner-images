| Announcements |
|-|
| [[All OS] hub utility will be removed on October 2](https://github.com/actions/runner-images/issues/8362) |
***
# Windows Server 2022
- OS Version: 10.0.20348 Build 1970
- Image Version: 20230924.1.0

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.2.15(1)-release
- Go 1.20.8
- Julia 1.9.3
- Kotlin 1.9.10
- LLVM 16.0.6
- Node 18.18.0
- Perl 5.32.1
- PHP 8.2.10
- Python 3.9.13
- Ruby 3.0.6p216

### Package Management
- Chocolatey 2.2.2
- Composer 2.6.3
- Helm 3.12.3
- Miniconda 23.5.2 (pre-installed on the image but not added to PATH)
- NPM 9.8.1
- NuGet 6.7.0.127
- pip 23.2.1 (python 3.9)
- Pipx 1.2.0
- RubyGems 3.2.33
- Vcpkg (build from commit 5a38b5ec0)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.14
- Gradle 8.3
- Maven 3.8.7
- sbt 1.9.6

### Tools
- 7zip 23.01
- aria2 1.36.0
- azcopy 10.20.1
- Bazel 6.3.2
- Bazelisk 1.18.0
- Bicep 0.21.1
- Cabal 3.10.1.0
- CMake 3.27.6
- CodeQL Action Bundles 2.14.4 2.14.5
- Docker 24.0.6
- Docker Compose v1 1.29.2
- Docker Compose v2 2.22.0
- Docker-wincred 0.8.0
- ghc 9.6.2
- Git 2.42.0.windows.2
- Git LFS 3.4.0
- ImageMagick 7.1.1-18
- InnoSetup 6.2.2
- jq 1.7-dirty
- Kind 0.20.0
- Kubectl 1.28.2
- Mercurial 5.0
- Mingw-w64 12.2.0
- Newman 6.0.0
- NSIS 3.08
- OpenSSL 1.1.1v
- Packer 1.9.4
- Pulumi 3.85.0
- R 4.3.1
- Service Fabric SDK 9.1.1436.9590
- Stack 2.11.1
- Subversion (SVN) 1.14.2
- Swig 4.1.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.11.2.4516
- yamllint 1.32.0
- zstd 1.5.5

### CLI Tools
- Alibaba Cloud CLI 3.0.181
- AWS CLI 2.13.20
- AWS SAM CLI 1.97.0
- AWS Session Manager CLI 1.2.497.0
- Azure CLI 2.52.0
- Azure DevOps CLI extension 0.26.0
- GitHub CLI 2.35.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.72.1
- Rust 1.72.1
- Rustdoc 1.72.1
- Rustup 1.26.0

#### Packages
- bindgen 0.68.1
- cargo-audit 0.18.1
- cargo-outdated 0.13.1
- cbindgen 0.26.0
- Clippy 0.1.72
- Rustfmt 1.6.0

### Browsers and Drivers
- Google Chrome 117.0.5938.92
- Chrome Driver 117.0.5938.92
- Microsoft Edge 117.0.2045.36
- Microsoft Edge Driver 117.0.2045.41
- Mozilla Firefox 117.0.1
- Gecko Driver 0.33.0
- IE Driver 4.11.0.0
- Selenium server 4.12.0

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
| 8.0.382+5 (default) | JAVA_HOME_8_X64      |
| 11.0.20+101         | JAVA_HOME_11_X64     |
| 17.0.8+101          | JAVA_HOME_17_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### MSYS2
- Pacman 6.0.2

#### Notes
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```

### Cached Tools

#### Go
- 1.19.13
- 1.20.8
- 1.21.1

#### Node.js
- 14.21.3
- 16.20.2
- 18.18.0

#### Python
- 3.7.9
- 3.8.10
- 3.9.13
- 3.10.11
- 3.11.5

#### PyPy
- 2.7.18 [PyPy 7.3.12]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.17 [PyPy 7.3.12]
- 3.10.12 [PyPy 7.3.12]

#### Ruby
- 2.7.8
- 3.0.6
- 3.1.4

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.9                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 5.0.21.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.12.0
- DacFx 162.0.52.1
- MySQL 8.0.34.0
- SQL OLEDB Driver 18.6.4.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.25.2  | C:\tools\nginx-1.25.2\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version        | Path                                                     |
| ----------------------------- | -------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.7.34031.279 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 33.0.68.0       |
| Component.Android.Emulator.MDD                                            | 17.7.33905.399  |
| Component.Android.NDK.R23C                                                | 17.7.33905.399  |
| Component.Android.SDK.MAUI                                                | 17.7.33905.399  |
| Component.CPython39.x64                                                   | 3.9.13          |
| Component.Dotfuscator                                                     | 17.7.33905.399  |
| Component.HAXM.Private                                                    | 17.7.33905.399  |
| Component.Linux.CMake                                                     | 17.7.33905.399  |
| Component.Linux.RemoteFileExplorer                                        | 17.7.33905.399  |
| Component.MDD.Android                                                     | 17.7.33905.399  |
| Component.MDD.Linux                                                       | 17.7.33905.399  |
| Component.MDD.Linux.GCC.arm                                               | 17.7.33905.399  |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5875        |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.7.33905.399  |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.0.33617.0    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.7.33905.399  |
| Component.Microsoft.Web.LibraryManager                                    | 17.7.33905.399  |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.7.70.21405   |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.22621.0    |
| Component.OpenJDK                                                         | 17.7.33905.399  |
| Component.UnityEngine.x64                                                 | 17.7.33905.399  |
| Component.Unreal                                                          | 17.7.33905.399  |
| Component.Unreal.Android                                                  | 17.7.33905.399  |
| Component.Unreal.Ide                                                      | 17.7.33913.275  |
| Component.VSInstallerProjects2022                                         | 2.0.0           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| Component.Xamarin                                                         | 17.7.33905.399  |
| Component.Xamarin.RemotedSimulator                                        | 17.7.33905.399  |
| ios                                                                       | 16.4.7098.0     |
| maccatalyst                                                               | 16.4.7098.0     |
| maui.android                                                              | 7.0.92.0        |
| maui.blazor                                                               | 7.0.92.0        |
| maui.core                                                                 | 7.0.92.0        |
| maui.ios                                                                  | 7.0.92.0        |
| maui.maccatalyst                                                          | 7.0.92.0        |
| maui.windows                                                              | 7.0.92.0        |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.7.33905.399  |
| Microsoft.Component.ClickOnce                                             | 17.7.33905.399  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.7.33905.399  |
| Microsoft.Component.MSBuild                                               | 17.7.33905.399  |
| Microsoft.Component.NetFX.Native                                          | 17.7.33913.275  |
| Microsoft.Component.PythonTools                                           | 17.7.33905.399  |
| Microsoft.Component.PythonTools.Web                                       | 17.7.33905.399  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.7.33905.399  |
| Microsoft.ComponentGroup.Blend                                            | 17.7.33905.399  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.7.33905.399  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.7.33905.399  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.7.33905.399  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.7.33905.399  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.7.33905.399  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.7.33905.399  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.7.33905.399  |
| Microsoft.Net.Component.4.8.1.SDK                                         | 17.7.33905.399  |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 17.7.33905.399  |
| Microsoft.Net.Component.4.8.SDK                                           | 17.7.33905.399  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.7.33905.399  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.7.33905.399  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.7.33905.399  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.7.33905.399  |
| microsoft.net.runtime.android                                             | 7.0.1123.42427  |
| microsoft.net.runtime.android.aot                                         | 7.0.1123.42427  |
| microsoft.net.runtime.android.aot.net6                                    | 7.0.1123.42427  |
| microsoft.net.runtime.android.net6                                        | 7.0.1123.42427  |
| microsoft.net.runtime.ios                                                 | 7.0.1123.42427  |
| microsoft.net.runtime.ios.net6                                            | 7.0.1123.42427  |
| microsoft.net.runtime.maccatalyst                                         | 7.0.1123.42427  |
| microsoft.net.runtime.maccatalyst.net6                                    | 7.0.1123.42427  |
| microsoft.net.runtime.mono.tooling                                        | 7.0.1123.42427  |
| microsoft.net.runtime.mono.tooling.net6                                   | 7.0.1123.42427  |
| microsoft.net.sdk.emscripten.net7                                         | 7.0.8.42402     |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.7.33905.399  |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.7.34031.279  |
| Microsoft.NetCore.Component.Runtime.7.0                                   | 17.7.34031.279  |
| Microsoft.NetCore.Component.SDK                                           | 17.7.34031.279  |
| Microsoft.NetCore.Component.Web                                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.HLSL                                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.7.34024.25   |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Merq                                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.SecurityIssueAnalysis                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Unity                                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM.Spectre               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64.Spectre             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM.Spectre           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM64                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM64.Spectre         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.Spectre               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM.Spectre           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM64                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM64.Spectre         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.Spectre               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64.Spectre           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ARM                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ARM.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ARM64                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ARM64.Spectre              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ATL                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ATL.ARM                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ATL.ARM.Spectre            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ATL.ARM64                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ATL.ARM64.Spectre          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.ATL.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.MFC                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.MFC.ARM                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.MFC.ARM.Spectre            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.MFC.ARM64                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.MFC.ARM64.Spectre          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.MFC.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.x86.x64                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.35.17.5.x86.x64.Spectre            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ARM                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ARM.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ARM64                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ARM64.Spectre              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ATL                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ATL.ARM                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ATL.ARM.Spectre            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ATL.ARM64                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ATL.ARM64.Spectre          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.ATL.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.MFC                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.MFC.ARM                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.MFC.ARM.Spectre            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.MFC.ARM64                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.MFC.ARM64.Spectre          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.MFC.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.x86.x64                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.14.37.17.7.x86.x64.Spectre            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 17.7.33913.275  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 17.7.33913.275  |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 17.7.33913.275  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 17.7.33913.275  |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Web                                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 17.7.34002.345  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.7.33905.399  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.Data                                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.7.34002.345  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.7.34009.333  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.7.34002.345  |
| Microsoft.VisualStudio.Workload.Node                                      | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.Office                                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.Python                                    | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.7.33905.399  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.7.33905.399  |
| runtimes.ios                                                              | 7.0.1123.42427  |
| runtimes.ios.net6                                                         | 7.0.1123.42427  |
| runtimes.maccatalyst                                                      | 7.0.1123.42427  |
| runtimes.maccatalyst.net6                                                 | 7.0.1123.42427  |
| wasm.tools                                                                | 7.0.1123.42427  |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 3.0.4           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 3.0.1           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 1.2             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.0           |
| Windows Driver Kit                                                        | 10.1.22621.382  |
| Windows Driver Kit Visual Studio Extension                                | 10.0.22621.0    |
| Windows Software Development Kit                                          | 10.1.22621.1778 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.36.32532 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.36.32532 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.36.32532 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.36.32532 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.36.32532 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.36.32532 |

#### Installed Windows SDKs
- 10.0.17763.0
- 10.0.19041.0
- 10.0.20348.0
- 10.0.22000.0
- 10.0.22621.0

### .NET Core Tools
- .NET Core SDK: 6.0.122, 6.0.203, 6.0.317, 6.0.414, 7.0.401
- .NET Framework: 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.5, 6.0.22, 7.0.11
- Microsoft.NETCore.App: 6.0.5, 6.0.22, 7.0.11
- Microsoft.WindowsDesktop.App: 6.0.5, 6.0.22, 7.0.11
- nbgv 3.6.133+2d32d93cb1

### PowerShell Tools
- PowerShell 7.2.14

#### Powershell Modules
- Az: 9.3.0
- Azure: 2.1.0 (Default), 5.3.0
- AzureRM: 2.1.0 (Default), 6.13.1
- Az (Cached): 7.5.0.zip
- Azure (Cached): 3.8.0.zip, 4.2.1.zip, 5.1.1.zip
- AzureRM (Cached): 3.8.0.zip, 4.2.1.zip, 5.1.1.zip, 6.7.0.zip
- AWSPowershell: 4.1.420
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.9
- Microsoft.Graph: 2.6.1
- Pester: 3.4.0, 5.5.0
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.21.0
- PSWindowsUpdate: 2.2.0.3
- SqlServer: 22.1.1
- VSSetup: 2.2.16
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```

### Android
| Package Name               | Version                                                                                                                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                |
| Android Emulator           | 31.2.9                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                     |
| Android SDK Platforms      | android-34 (rev 2)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 34.0.4                                                                                                                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                             |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                                                                                                   |
| Google Play services       | 49                                                                                                                                                                                                                                 |
| Google Repository          | 58                                                                                                                                                                                                                                 |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653<br>26.0.10792818                                                                                                                                                                      |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                  |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\25.2.9519653  |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\25.2.9519653  |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\26.0.10792818 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\25.2.9519653  |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:5aa61257ffbd2dbc534f2591d70dbc56fad6e8ca363d48f5aa4f2c2b2ab64821  | 2023-09-12 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:49bb37677c8d61281f15a49d3291baff4f5583e6cf5846fc4cee7527e59ff1c5  | 2023-09-12 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:1477b5cc53a36a8a5e8b865a5e11a32e836ba6061c120e4e5b0a1eea1fdf6c98  | 2023-09-12 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:6562c9a2580260e4f2e3a081cc2cf1d960899cbce7c4568fb851e4848ca50e07  | 2023-09-01 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:d227d7ab11f4aa0da7779adc31616924cf0b15846a10313d83a644541208f80b  | 2023-09-01 |

