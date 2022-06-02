| Announcements |
|-|
| [[all OSs] Android NDK 22 will be replaced in favor of 24, version 23 will be set as the default one on June, 6](https://github.com/actions/virtual-environments/issues/5595) |
| [[Azure DevOps] Windows-2016 environment removal postponed until June 30, 2022](https://github.com/actions/virtual-environments/issues/5403) |
***
# Microsoft Windows Server 2022 Datacenter
- OS Version: 10.0.20348 Build 707
- Image Version: 20220529.1

## Enabled windows optional features
- Windows Subsystem for Linux [WSLv1]

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.17.10
- Julia 1.7.3
- Kotlin 1.6.21
- LLVM 13.0.1
- Node 16.14.2
- Perl 5.32.1
- PHP 8.1.6
- Python 3.9.13
- Ruby 3.0.4p208

### Package Management
- Chocolatey 1.1.0
- Composer 2.3.5
- Helm 3.8.2
- Miniconda 4.12.0 (pre-installed on the image but not added to PATH)
- NPM 8.5.0
- NuGet 6.2.0.146
- pip 22.1.1 (python 3.9)
- Pipx 1.1.0
- RubyGems 3.2.33
- Vcpkg (build from master \<d953973cf>)
- Yarn 1.22.18

#### Environment variables
| Name                    | Value    |
| ----------------------- | -------- |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg |

### Project Management
- Ant 1.10.12
- Gradle 7.4
- Maven 3.8.5
- sbt 1.6.2

### Tools
- 7zip 21.07
- aria2 1.36.0
- azcopy 10.15.0
- Bazel 5.1.1
- Bazelisk 1.11.0
- Bicep 0.6.18
- Cabal 3.6.2.0
- CMake 3.23.2
- CodeQL Action Bundle 2.9.2
- Docker 20.10.7
- Docker Compose v1 1.29.2
- Docker Compose v2 2.5.1
- Docker-wincred 0.6.4
- ghc 9.2.3
- Git 2.36.0.windows.1
- Git LFS 3.1.4
- InnoSetup 6.2.1
- jq 1.6
- Kind 0.14.0
- Kubectl 1.24.1
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.3.2
- NSIS v3.08
- OpenSSL 1.1.1
- Packer 1.8.0
- Pulumi v3.33.2
- R 4.2.0
- Service Fabric SDK 9.0.1017.9590
- Stack 2.7.5
- Subversion (SVN) 1.14.2
- Swig 4.0.2
- VSWhere 3.0.2
- WinAppDriver 1.2.2009.02003
- WiX Toolset v3.11.2.4516
- yamllint 1.26.3
- zstd 1.5.2

### CLI Tools
- Alibaba Cloud CLI 3.0.121
- AWS CLI 2.7.4
- AWS SAM CLI 1.50.0
- AWS Session Manager CLI 1.2.331.0
- Azure CLI 2.37.0
- Azure DevOps CLI extension 0.25.0
- GitHub CLI 2.11.3
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.61.0
- Rust 1.61.0
- Rustdoc 1.61.0
- Rustup 1.24.3

#### Packages
- bindgen 0.59.2
- cargo-audit 0.17.0
- cargo-outdated 0.11.1
- cbindgen 0.23.0
- Clippy 0.1.61
- Rustfmt 1.4.38

### Browsers and webdrivers
- Google Chrome 102.0.5005.63
- Chrome Driver 102.0.5005.61
- Microsoft Edge 101.0.1210.53
- Microsoft Edge Driver 101.0.1210.53
- Mozilla Firefox 100.0.2
- Gecko Driver 0.31.0
- IE Driver 3.150.1.1
- Selenium server 4.2.0

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
| 11.0.15+10          | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.3+7            | Eclipse Temurin | JAVA_HOME_17_X64     |

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
| 1.17.10 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.2  | x64          | GOROOT_1_18_X64      |

#### Node
| Version | Architecture |
| ------- | ------------ |
| 12.22.12 | x64          |
| 14.19.3 | x64          |
| 16.15.0 | x64          |

#### Python
| Version | Architecture |
| ------- | ------------ |
| 3.7.9   | x64, x86     |
| 3.8.10  | x64, x86     |
| 3.9.13 (Default) | x64, x86     |
| 3.10.4  | x64, x86     |

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
| Version              | 14.3                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 5.0.8.0 | MongoDB     | Running       | Automatic        |

### Database tools
- Azure CosmosDb Emulator 2.14.7.0
- DacFx 16.0.6161.0
- MySQL 8.0.29.0
- SQL OLEDB Driver 18.6.3.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.53  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.21.6  | C:\tools\nginx-1.21.6\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version        | Path                                                     |
| ----------------------------- | -------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.2.32519.379 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions:
| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| Component.Android.NDK.R21E                                                | 17.2.32408.312 |
| Component.Android.SDK.MAUI                                                | 17.2.32408.312 |
| Component.Android.SDK25.Private                                           | 17.2.32408.312 |
| Component.Ant                                                             | 1.9.3.8        |
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
| microsoft.net.runtime.mono.tooling                                        | 6.0.422.16404  |
| microsoft.net.sdk.emscripten                                              | 6.0.6.16102    |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.2.32408.312 |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.2.32503.368 |
| Microsoft.NetCore.Component.SDK                                           | 17.2.32503.368 |
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
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.2.32427.441 |
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
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.2.32427.441 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.Unity                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.2.32408.312 |
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
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.2.32408.312 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64EC                           | 17.2.32408.312 |
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
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.2.32503.295 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Node                                      | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Office                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Python                                    | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.2.32408.312 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.2.32408.312 |
| wasm.tools                                                                | 6.0.422.16404  |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.0          |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.18       |

#### Microsoft Visual C++:
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2012 Additional Runtime | x64          | 11.0.61030  |
| Microsoft Visual C++ 2012 Minimum Runtime    | x64          | 11.0.61030  |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.32.31326 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.32.31326 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.32.31326 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.32.31326 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.32.31326 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.32.31326 |

#### Installed Windows SDKs
`Location C:\Program Files (x86)\Windows Kits\10\Extension SDKs\WindowsDesktop`
- 10.0.17763.0
- 10.0.19041.0
- 10.0.20348.0
- 10.0.22000.0

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 3.1.120 3.1.202 3.1.302 3.1.419 5.0.104 5.0.214 5.0.303 5.0.408 6.0.300

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.25 5.0.4 5.0.9 5.0.17 6.0.5

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.25 5.0.4 5.0.9 5.0.17 6.0.5

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.20 3.1.25 5.0.4 5.0.9 5.0.17 6.0.5

### .NET Framework
`Type: Developer Pack`
`Location: C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.8

### .NET tools
- nbgv 3.5.107+6463ef6068

### PowerShell Tools
- PowerShell 7.2.4

#### Azure Powershell Modules
| Module  | Version                                                                         | Path                           |
| ------- | ------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 6.6.0.zip<br>7.3.2                                                              | C:\Modules\az_\<version\>      |
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
| AWSPowerShell      | 4.1.95           |
| DockerMsftProvider | 1.0.0.8          |
| MarkdownPS         | 1.9              |
| Microsoft.Graph    | 1.9.6            |
| Pester             | 3.4.0<br>5.3.3   |
| PowerShellGet      | 1.0.0.1<br>2.2.5 |
| PSScriptAnalyzer   | 1.20.0           |
| PSWindowsUpdate    | 2.2.0.3          |
| SqlServer          | 21.1.18256       |
| VSSetup            | 2.2.16           |

### Android
| Package Name               | Version                                                                                                                                      |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                          |
| Android Emulator           | 31.2.10                                                                                                                                      |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)             |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                       |
| CMake                      | 3.18.1                                                                                                                                       |
| Google Play services       | 49                                                                                                                                           |
| Google Repository          | 58                                                                                                                                           |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.2.8568313                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                            |

#### Environment variables
| Name                    | Value                                                                        |
| ----------------------- | ---------------------------------------------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                                                       |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\23.2.8568313                                      |
| ANDROID_NDK_PATH        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                                                       |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:1182bfe22daba321fccb5caf93bfedc912c817a91d4c9aa5b45ea3823cb7a5c0  | 2022-05-11 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:9bba2824988fa141d187315336055c068dadae6b84e86fb5d13291fd2245a8dd  | 2022-05-11 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:f3dcc7d94e1631213f2349851f3415d8850d45ebd411e4ca68a0a5fa73ebffe8  | 2022-05-11 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:f677b64d44434c6850f075630c3a7b3f9be284d32003c2cc6ea93130f619152f  | 2022-05-05 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:93373be6f6c576ef3f778b9d5e7b54231975bb6876a07d90c4e4599a29a65d54  | 2022-05-05 |


