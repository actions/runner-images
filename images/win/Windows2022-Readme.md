| Announcements |
|-|
| [[Windows] mongo service will be disabled by default on August, 8th](https://github.com/actions/virtual-environments/issues/5949) |
| [[all OSs] Android NDK 21 will be replaced in favor of 25 on August, 1st](https://github.com/actions/virtual-environments/issues/5930) |
| [[all OSs] Android ndk-bundle along with old NDK versions will be deprecated on July, 24](https://github.com/actions/virtual-environments/issues/5879) |
| [[Azure DevOps] Windows-2016 environment removal postponed until July 31, 2022](https://github.com/actions/virtual-environments/issues/5403) |
***
# Microsoft Windows Server 2022 Datacenter
- OS Version: 10.0.20348 Build 825
- Image Version: 20220724.1

## Enabled windows optional features
- Windows Subsystem for Linux [WSLv1]

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.17.12
- Julia 1.7.3
- Kotlin 1.7.10
- LLVM 14.0.6
- Node 16.16.0
- Perl 5.32.1
- PHP 8.1.8
- Python 3.9.13
- Ruby 3.0.4p208

### Package Management
- Chocolatey 1.1.0
- Composer 2.3.10
- Helm 3.9.1
- Miniconda 4.12.0 (pre-installed on the image but not added to PATH)
- NPM 8.11.0
- NuGet 6.2.1.2
- pip 22.2 (python 3.9)
- Pipx 1.1.0
- RubyGems 3.2.33
- Vcpkg (build from master \<f93ba152d>)
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
- Bazelisk 1.12.0
- Bicep 0.8.9
- Cabal 3.6.2.0
- CMake 3.23.2
- CodeQL Action Bundle 2.10.0
- Docker 20.10.7
- Docker Compose v1 1.29.2
- Docker Compose v2 2.7.0
- Docker-wincred 0.6.4
- ghc 9.2.3
- Git 2.37.1.windows.1
- Git LFS 3.2.0
- InnoSetup 6.2.1
- jq 1.6
- Kind 0.14.0
- Kubectl 1.24.1
- Mercurial 5.0
- Mingw-w64 11.2.0
- Newman 5.3.2
- NSIS v3.08
- OpenSSL 1.1.1
- Packer 1.8.2
- Pulumi v3.36.0
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
- AWS CLI 2.7.18
- AWS SAM CLI 1.53.0
- AWS Session Manager CLI 1.2.339.0
- Azure CLI 2.38.0
- Azure DevOps CLI extension 0.25.0
- GitHub CLI 2.14.2
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.62.1
- Rust 1.62.1
- Rustdoc 1.62.1
- Rustup 1.25.1

#### Packages
- bindgen 0.60.1
- cargo-audit 0.17.0
- cargo-outdated 0.11.1
- cbindgen 0.24.3
- Clippy 0.1.62
- Rustfmt 1.4.38

### Browsers and webdrivers
- Google Chrome 103.0.5060.134
- Chrome Driver 103.0.5060.134
- Microsoft Edge 103.0.1264.71
- Microsoft Edge Driver 103.0.1264.71
- Mozilla Firefox 102.0.1
- Gecko Driver 0.31.0
- IE Driver 3.150.1.1
- Selenium server 4.3.0

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
| 8.0.332+9 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
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
| 1.16.15 | x64          | GOROOT_1_16_X64      |
| 1.17.12 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.4  | x64          | GOROOT_1_18_X64      |

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
| 3.10.5  | x64, x86     |

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
| Version              | 14.4                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 5.0.9.0 | MongoDB     | Running       | Automatic        |

### Database tools
- Azure CosmosDb Emulator 2.14.9.0
- DacFx 16.0.6161.0
- MySQL 8.0.29.0
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
| Visual Studio Enterprise 2022 | 17.2.32630.192 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions:
| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| Component.Android.NDK.R21E                                                | 17.2.32408.312 |
| Component.Android.SDK.MAUI                                                | 17.2.32408.312 |
| Component.Android.SDK25.Private                                           | 17.2.32408.312 |
| Component.Ant                                                             | 1.9.3.8        |
| Component.Dotfuscator                                                     | 17.2.32408.312 |
| Component.Linux.CMake                                                     | 17.2.32408.312 |
| Component.MDD.Android                                                     | 17.2.32408.312 |
| Component.MDD.Linux                                                       | 17.2.32408.312 |
| Component.MDD.Linux.GCC.arm                                               | 17.2.32408.312 |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5545       |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.2.32408.312 |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.2.32408.312 |
| Component.Microsoft.Web.LibraryManager                                    | 17.2.32408.312 |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.2.91.23537  |
| Component.Microsoft.Windows.CppWinRT                                      | 2.0.210806.1   |
| Component.OpenJDK                                                         | 17.2.32408.312 |
| Component.UnityEngine.x64                                                 | 17.2.32408.312 |
| Component.Unreal                                                          | 17.2.32408.312 |
| Component.Unreal.Android                                                  | 17.2.32408.312 |
| Component.VSInstallerProjects2022                                         | 2.0.0          |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.18       |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.18       |
| Component.WixToolset.VisualStudioExtension.Schemas4                       | 1.0.0.18       |
| Component.Xamarin                                                         | 17.2.32408.312 |
| Component.Xamarin.RemotedSimulator                                        | 17.2.32408.312 |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.2.32408.312 |
| Microsoft.Component.ClickOnce                                             | 17.2.32408.312 |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.2.32408.312 |
| Microsoft.Component.MSBuild                                               | 17.2.32408.312 |
| Microsoft.Component.NetFX.Native                                          | 17.2.32408.312 |
| Microsoft.Component.PythonTools                                           | 17.2.32408.312 |
| Microsoft.Component.PythonTools.Web                                       | 17.2.32408.312 |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.2.32408.312 |
| Microsoft.ComponentGroup.Blend                                            | 17.2.32408.312 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.2.32408.312 |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.2.32408.312 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.2.32408.312 |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.2.32408.312 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.2.32408.312 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.2.32408.312 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.2.32408.312 |
| Microsoft.Net.Component.4.8.SDK                                           | 17.2.32408.312 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.2.32408.312 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.2.32408.312 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.2.32408.312 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.2.32408.312 |
| microsoft.net.runtime.mono.tooling                                        | 6.0.722.32202  |
| microsoft.net.sdk.emscripten                                              | 6.0.6.16102    |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.2.32408.312 |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.2.32630.192 |
| Microsoft.NetCore.Component.SDK                                           | 17.2.32630.192 |
| Microsoft.NetCore.Component.Web                                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.2.32414.121 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.2.32602.177 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Merq                                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.2.32602.177 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Unity                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM.Spectre               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64.Spectre             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ATL.Spectre               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.MFC.Spectre               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64.Spectre           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM.Spectre                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM64                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ARM64.Spectre              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM.Spectre            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM64                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.ARM64.Spectre          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.ATL.Spectre                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM.Spectre            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM64                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.ARM64.Spectre          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.MFC.Spectre                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.x86.x64                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.14.32.17.2.x86.x64.Spectre            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64EC                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64EC.Spectre                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.CoreBuildTools                        | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.2.32422.2   |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64EC                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64EC.Spectre                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Web                                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.2.32526.322 |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.2.32422.2   |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.2.32408.312 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Data                                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.2.32526.322 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.2.32526.322 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.2.32503.295 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Node                                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Office                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Python                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.2.32526.322 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.2.32408.312 |
| wasm.tools                                                                | 6.0.722.32202  |
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
- 3.1.120 3.1.202 3.1.302 3.1.421 5.0.104 5.0.214 5.0.303 5.0.408 6.0.302

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.26 3.1.27 5.0.4 5.0.9 5.0.17 6.0.6 6.0.7

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.26 3.1.27 5.0.4 5.0.9 5.0.17 6.0.6 6.0.7

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.20 3.1.27 5.0.4 5.0.9 5.0.17 6.0.7

### .NET Framework
`Type: Developer Pack`
`Location: C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.8

### .NET tools
- nbgv 3.5.108+6e793d63d3

### PowerShell Tools
- PowerShell 7.2.5

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
| AWSPowerShell      | 4.1.132          |
| DockerMsftProvider | 1.0.0.8          |
| MarkdownPS         | 1.9              |
| Microsoft.Graph    | 1.10.0           |
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
| Android Emulator           | 31.2.10                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.18.1                                                                                                                                                 |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 21.4.7075529<br>23.2.8568313<br>24.0.8215888                                                                                                           |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                   |
| ----------------------- | --------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                  |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\24.0.8215888 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                  |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:0ea7d5c616349fdb77a6cf13c6392277081fd6816ca922bed69083f395f7130b  | 2022-07-12 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:ec79d74665ee8812e3f2bf29e352975a938f670b6ddf968df5b1becf9e6283ed  | 2022-07-12 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:8180531d4ac52f7c5bb8dc2864639ebb053081335d3c0558abb021a237770895  | 2022-07-12 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:81f3d891826a99e3a5742df69dcb4e6e44e177f817a0527c2b8dd5ef3c9eeaa8  | 2022-07-04 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:ffa814c9dbae448ee8a4dd5415952b3124adf0964b8c7c761b82d1e95f6f0acf  | 2022-07-04 |


