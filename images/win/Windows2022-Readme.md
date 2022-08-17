# Microsoft Windows Server 2022 Datacenter
- OS Version: 10.0.20348 Build 887
- Image Version: 20220816.1

## Enabled windows optional features
- Windows Subsystem for Linux [WSLv1]

## Installed Software
### Language and Runtime
- Bash 5.1.16(1)-release
- Go 1.17.13
- Julia 1.7.3
- Kotlin 1.7.10
- LLVM 14.0.6
- Node 16.17.0
- Perl 5.32.1
- PHP 8.1.9
- Python 3.9.13
- Ruby 3.0.4p208

### Package Management
- Chocolatey 1.1.0
- Composer 2.4.0
- Helm 3.9.2
- Miniconda 4.12.0 (pre-installed on the image but not added to PATH)
- NPM 8.15.0
- NuGet 6.3.0.131
- pip 22.2.2 (python 3.9)
- Pipx 1.1.0
- RubyGems 3.2.33
- Vcpkg (build from master \<23cc58477>)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value    |
| ----------------------- | -------- |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg |

### Project Management
- Ant 1.10.12
- Gradle 7.4
- Maven 3.8.6
- sbt 1.7.1

### Tools
- 7zip 22.01
- aria2 1.36.0
- azcopy 10.16.0
- Bazel 5.2.0
- Bazelisk 1.12.1
- Bicep 0.9.1
- Cabal 3.8.1.0
- CMake 3.24.0
- CodeQL Action Bundle 2.10.2
- Docker 20.10.7
- Docker Compose v1 1.29.2
- Docker Compose v2 2.9.0
- Docker-wincred 0.6.4
- ghc 9.4.1
- Git 2.37.2.windows.2
- Git LFS 3.2.0
- InnoSetup 6.2.1
- jq 1.6
- Kind 0.14.0
- Kubectl 1.24.3
- Mercurial 5.0
- Mingw-w64 11.2.0
- Newman 5.3.2
- NSIS v3.08
- OpenSSL 1.1.1
- Packer 1.8.2
- Pulumi v3.37.2
- R 4.2.1
- Service Fabric SDK 9.0.1028.9590
- Stack 2.7.5
- Subversion (SVN) 1.14.2
- Swig 4.0.2
- VSWhere 3.0.3
- WinAppDriver 1.2.2009.02003
- WiX Toolset v3.11.2.4516
- yamllint 1.27.1
- zstd 1.5.2

### CLI Tools
- Alibaba Cloud CLI 3.0.124
- AWS CLI 2.7.22
- AWS SAM CLI 1.54.0
- AWS Session Manager CLI 1.2.339.0
- Azure CLI 2.39.0
- Azure DevOps CLI extension 0.25.0
- GitHub CLI 2.14.4
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.63.0
- Rust 1.63.0
- Rustdoc 1.63.0
- Rustup 1.25.1

#### Packages
- bindgen 0.60.1
- cargo-audit 0.17.0
- cargo-outdated 0.11.1
- cbindgen 0.24.3
- Clippy 0.1.63
- Rustfmt 1.5.1

### Browsers and webdrivers
- Google Chrome 104.0.5112.102
- Chrome Driver 104.0.5112.79
- Microsoft Edge 104.0.1293.54
- Microsoft Edge Driver 104.0.1293.54
- Mozilla Firefox 103.0.2
- Gecko Driver 0.31.0
- IE Driver 3.150.1.1
- Selenium server 4.4.0

#### Environment variables
| Name              | Value                              |
| ----------------- | ---------------------------------- |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver  |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server.jar    |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.345+1 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.16+8           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.4+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### MSYS2
- Pacman 6.0.1

##### Notes:
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```

### Cached Tools
#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.17.13 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.5  | x64          | GOROOT_1_18_X64      |
| 1.19.0  | x64          | GOROOT_1_19_X64      |

#### Node
| Version | Architecture |
| ------- | ------------ |
| 12.22.12 | x64          |
| 14.20.0 | x64          |
| 16.16.0 | x64          |

#### Python
| Version | Architecture |
| ------- | ------------ |
| 3.7.9   | x64, x86     |
| 3.8.10  | x64, x86     |
| 3.9.13 (Default) | x64, x86     |
| 3.10.6  | x64, x86     |

#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.7.6   | x64          |
| 3.0.4 (Default) | x64          |
| 3.1.2   | x64          |

#### PyPy
| Python Version | PyPy Version |
| -------------- | ------------ |
| 2.7.18         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |
| 3.7.13         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |
| 3.8.12         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |
| 3.9.10         | PyPy 7.3.9 with MSC v.1929 64 bit (AMD64) |

### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.5                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 5.0.10.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.9.0
- DacFx 16.0.6161.0
- MySQL 8.0.30.0
- SQL OLEDB Driver 18.6.3.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.54  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.23.1  | C:\tools\nginx-1.23.1\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version        | Path                                                     |
| ----------------------------- | -------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.3.32811.315 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions:
| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| android                                                                   | 32.0.448.0     |
| Component.Android.NDK.R21E                                                | 17.3.32708.82  |
| Component.Android.SDK.MAUI                                                | 17.3.32708.82  |
| Component.Android.SDK25.Private                                           | 17.3.32708.82  |
| Component.Ant                                                             | 1.9.3.8        |
| Component.Dotfuscator                                                     | 17.3.32708.82  |
| Component.Linux.CMake                                                     | 17.3.32708.82  |
| Component.MDD.Android                                                     | 17.3.32708.82  |
| Component.MDD.Linux                                                       | 17.3.32708.82  |
| Component.MDD.Linux.GCC.arm                                               | 17.3.32708.82  |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5545       |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.3.32708.82  |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.3.32708.82  |
| Component.Microsoft.Web.LibraryManager                                    | 17.3.32708.82  |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.3.58.47684  |
| Component.OpenJDK                                                         | 17.3.32708.82  |
| Component.UnityEngine.x64                                                 | 17.3.32708.82  |
| Component.Unreal                                                          | 17.3.32708.82  |
| Component.Unreal.Android                                                  | 17.3.32708.82  |
| Component.Unreal.Ide                                                      | 17.3.32708.82  |
| Component.VSInstallerProjects2022                                         | 2.0.0          |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.18       |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.18       |
| Component.WixToolset.VisualStudioExtension.Schemas4                       | 1.0.0.18       |
| Component.Xamarin                                                         | 17.3.32708.82  |
| Component.Xamarin.RemotedSimulator                                        | 17.3.32708.82  |
| ios                                                                       | 15.4.446.446   |
| maccatalyst                                                               | 15.4.446.446   |
| maui.android                                                              | 6.0.486.0      |
| maui.blazor                                                               | 6.0.486.0      |
| maui.core                                                                 | 6.0.486.0      |
| maui.ios                                                                  | 6.0.486.0      |
| maui.maccatalyst                                                          | 6.0.486.0      |
| maui.windows                                                              | 6.0.486.0      |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.3.32708.82  |
| Microsoft.Component.ClickOnce                                             | 17.3.32708.82  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.3.32708.82  |
| Microsoft.Component.MSBuild                                               | 17.3.32708.82  |
| Microsoft.Component.NetFX.Native                                          | 17.3.32708.82  |
| Microsoft.Component.PythonTools                                           | 17.3.32708.82  |
| Microsoft.Component.PythonTools.Web                                       | 17.3.32708.82  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.3.32708.82  |
| Microsoft.ComponentGroup.Blend                                            | 17.3.32708.82  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.3.32708.82  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.3.32708.82  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.3.32708.82  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.3.32708.82  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.3.32708.82  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.3.32708.82  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.3.32708.82  |
| Microsoft.Net.Component.4.8.SDK                                           | 17.3.32708.82  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.3.32708.82  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.3.32708.82  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.3.32708.82  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.3.32708.82  |
| microsoft.net.runtime.android                                             | 6.0.822.36306  |
| microsoft.net.runtime.android.aot                                         | 6.0.822.36306  |
| microsoft.net.runtime.ios                                                 | 6.0.822.36306  |
| microsoft.net.runtime.maccatalyst                                         | 6.0.822.36306  |
| microsoft.net.runtime.mono.tooling                                        | 6.0.822.36306  |
| microsoft.net.sdk.emscripten                                              | 6.0.6.16102    |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.3.32708.82  |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.3.32803.143 |
| Microsoft.NetCore.Component.SDK                                           | 17.3.32803.143 |
| Microsoft.NetCore.Component.Web                                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.3.32804.24  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Merq                                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Unity                                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM.Spectre               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64.Spectre             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM.Spectre           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM64                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.ARM64.Spectre         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.Spectre               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM.Spectre           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM64                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.ARM64.Spectre         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.Spectre               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64.Spectre           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM                        | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM.Spectre                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM64                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM64.Spectre              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL                        | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM.Spectre            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM64                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM64.Spectre          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.Spectre                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC                        | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM.Spectre            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM64                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM64.Spectre          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.Spectre                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.x86.x64                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.x86.x64.Spectre            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64EC                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64EC.Spectre                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.3.32714.208 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64EC                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64EC.Spectre                   | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Web                                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.3.32720.241 |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.3.32714.208 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.3.32708.82  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.Data                                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.3.32728.75  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.3.32728.75  |
| Microsoft.VisualStudio.Workload.Node                                      | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.Office                                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.Python                                    | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.3.32708.82  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.3.32708.82  |
| runtimes.ios                                                              | 6.0.822.36306  |
| runtimes.maccatalyst                                                      | 6.0.822.36306  |
| wasm.tools                                                                | 6.0.822.36306  |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 3.0.4          |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 3.0.1          |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.0          |
| Windows Driver Kit                                                        | 10.1.22621.1   |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.18       |

#### Microsoft Visual C++:
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2012 Additional Runtime | x64          | 11.0.61030  |
| Microsoft Visual C++ 2012 Minimum Runtime    | x64          | 11.0.61030  |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.32.31332 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.32.31332 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.32.31332 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.32.31332 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.32.31332 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.32.31332 |

#### Installed Windows SDKs
`Location C:\Program Files (x86)\Windows Kits\10\Extension SDKs\WindowsDesktop`
- 10.0.17763.0
- 10.0.19041.0
- 10.0.20348.0
- 10.0.22000.0
- 10.0.22621.0

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 3.1.120 3.1.202 3.1.302 3.1.422 5.0.104 5.0.214 5.0.303 5.0.408 6.0.400

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.28 5.0.4 5.0.9 5.0.17 6.0.8

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.28 5.0.4 5.0.9 5.0.17 6.0.8

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.20 3.1.28 5.0.4 5.0.9 5.0.17 6.0.8

### .NET Framework
`Type: Developer Pack`
`Location: C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.8

### .NET tools
- nbgv 3.5.109+bdfbd7dea6

### PowerShell Tools
- PowerShell 7.2.6

#### Azure Powershell Modules
| Module  | Version                                                                         | Path                           |
| ------- | ------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 6.6.0.zip<br>7.5.0                                                              | C:\Modules\az_\<version\>      |
| Azure   | 2.1.0 [Installed]<br>3.8.0.zip<br>4.2.1.zip<br>5.1.1.zip<br>5.3.0               | C:\Modules\azure_\<version\>   |
| AzureRM | 2.1.0 [Installed]<br>3.8.0.zip<br>4.2.1.zip<br>5.1.1.zip<br>6.7.0.zip<br>6.13.1 | C:\Modules\azurerm_\<version\> |
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```

#### Powershell Modules
| Module             | Version          |
| ------------------ | ---------------- |
| AWSPowerShell      | 4.1.147          |
| DockerMsftProvider | 1.0.0.8          |
| MarkdownPS         | 1.9              |
| Microsoft.Graph    | 1.11.0           |
| Pester             | 3.4.0<br>5.3.3   |
| PowerShellGet      | 1.0.0.1<br>2.2.5 |
| PSScriptAnalyzer   | 1.20.0           |
| PSWindowsUpdate    | 2.2.0.3          |
| SqlServer          | 21.1.18256       |
| VSSetup            | 2.2.16           |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.3.10                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                       |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.0.8775105                                                                                                           |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                   |
| ----------------------- | --------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                  |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\25.0.8775105 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\25.0.8775105 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\25.0.8775105 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\25.0.8775105 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                  |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:22486118e240e0f107ada5fac9f0fbdacb02e8b18f65b48552a0c0b0960a9002  | 2022-08-09 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:2117f997785dbd6e3a42b22261434dc8b0d082ed634a4edda9d1acd71b174187  | 2022-08-09 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:edc6558e8cd6f306854517048ef11a05129d3097f1e9f61b48c906ddc0d478cc  | 2022-08-09 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:5f57ddc9a47d079398506a7613c8a3cb8b5bf3f97040f590871b61a15bd5a36a  | 2022-08-06 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:35c3cb29ef2c9f05e36070d04c79d7fc861c035fa5df2df64ae607a276db42c6  | 2022-08-06 |

