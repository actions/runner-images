| Announcements |
|-|
| [[All OSs] Python version 3.5 will be removed from the images on January 24, 2022](https://github.com/actions/virtual-environments/issues/4744) |
| [Windows-2016 environment will be removed on March 15, 2022](https://github.com/actions/virtual-environments/issues/4312) |
***
# Microsoft Windows Server 2022 Datacenter
- OS Version: 10.0.20348 Build 405
- Image Version: 20211219.1

## Enabled windows optional features
- Windows Subsystem for Linux [WSLv1]

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.16.12
- Julia 1.7.0
- Kotlin 1.6.10
- LLVM 13.0.0
- Node 16.13.1
- PHP 8.1.1
- Python 3.9.9
- Ruby 3.0.3p157

### Package Management
- Chocolatey 0.11.3
- Composer 2.1.14
- Helm 3.7.1
- Miniconda 4.10.3 (pre-installed on the image but not added to PATH)
- NPM 8.1.2
- NuGet 6.0.0.280
- pip 21.3.1 (python 3.9)
- Pipx 0.16.4
- RubyGems 3.2.32
- Vcpkg  (build from master \<50fd3d995>)
- Yarn 1.22.17

#### Environment variables
| Name                    | Value    |
| ----------------------- | -------- |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg |

### Project Management
- Ant 1.10.12
- Gradle 7.3
- Maven 3.8.4
- sbt 1.5.7

### Tools
- 7zip 21.06
- aria2 1.36.0
- azcopy 10.13.0
- Bazel 4.2.2
- Bazelisk 1.11.0
- Bicep 0.4.1124
- Cabal 3.6.2.0
- CMake 3.22.1
- CodeQL Action Bundle 2.7.3
- Docker 20.10.7
- Docker-compose 1.29.2
- Docker-wincred 0.6.4
- ghc 9.2.1
- Git 2.34.1
- Git LFS 3.0.2
- jq 1.6
- Kind 0.11.1
- Kubectl 1.23.1
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.3.0
- NSIS v3.08
- OpenSSL 1.1.1
- Packer 1.7.8
- Pulumi v3.20.0
- R 4.1.2
- Stack 2.7.3
- Subversion (SVN) 1.14.1
- Swig 4.0.2
- VSWhere 2.8.4
- WinAppDriver 1.2.2009.02003
- WiX Toolset v3.11.2.4516
- yamllint 1.26.3
- zstd 1.5.0

### CLI Tools
- Alibaba Cloud CLI 3.0.102
- AWS CLI 2.4.6
- AWS SAM CLI 1.36.0
- AWS Session Manager CLI 1.2.279.0
- Azure CLI 2.31.0
- Azure DevOps CLI extension 0.22.0
- GitHub CLI 2.3.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 
- Rust 
- Rustdoc 
- Rustup 1.24.3

#### Packages
- bindgen 0.59.2

### Browsers and webdrivers
- Google Chrome 96.0.4664.110
- Chrome Driver 96.0.4664.45
- Microsoft Edge 96.0.1054.62
- Microsoft Edge Driver 96.0.1054.62
- Mozilla Firefox 95.0.2
- Gecko Driver 0.30.0
- IE Driver 3.150.1.1
- Selenium server 4.1.0

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
| 8.0.312+7 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.13+8           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.1+12           | Eclipse Temurin | JAVA_HOME_17_X64     |

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
| 1.15.15 | x64          | GOROOT_1_15_X64      |
| 1.16.12 (Default) | x64          | GOROOT_1_16_X64      |
| 1.17.5  | x64          | GOROOT_1_17_X64      |

#### Node
| Version | Architecture |
| ------- | ------------ |
| 12.22.8 | x64          |
| 14.18.2 | x64          |
| 16.13.1 | x64          |

#### Python
| Version | Architecture |
| ------- | ------------ |
| 3.7.9   | x64, x86     |
| 3.8.10  | x64, x86     |
| 3.9.9 (Default) | x64, x86     |
| 3.10.1  | x64, x86     |

#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.7.5   | x64          |
| 3.0.3 (Default) | x64          |

#### PyPy
| Python Version | PyPy Version |
| -------------- | ------------ |
| 2.7.18         | PyPy 7.3.6 with MSC v.1929 64 bit (AMD64) |
| 3.7.12         | PyPy 7.3.7 with MSC v.1929 64 bit (AMD64) |
| 3.8.12         | PyPy 7.3.7 with MSC v.1929 64 bit (AMD64) |

### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.1                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 5.0.5.0 | MongoDB     | Running       | Automatic        |

### Database tools
- Azure CosmosDb Emulator 2.14.4.0
- DacFx 15.0.5282.3
- MySQL 8.0.26.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.51  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.21.4  | C:\tools\nginx-1.21.4\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version        | Path                                                     |
| ----------------------------- | -------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.0.32014.148 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions:
| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| Component.Android.NDK.R21E                                                | 17.0.31804.368 |
| Component.Android.SDK.MAUI                                                | 17.0.31804.368 |
| Component.Android.SDK25.Private                                           | 17.0.31804.368 |
| Component.Ant                                                             | 1.9.3.8        |
| Component.Linux.CMake                                                     | 17.0.31804.368 |
| Component.MDD.Android                                                     | 17.0.31804.368 |
| Component.MDD.Linux                                                       | 17.0.31804.368 |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.4647       |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.0.31804.368 |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.0.31804.368 |
| Component.Microsoft.Web.LibraryManager                                    | 17.0.31804.368 |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.0.31.12604  |
| Component.OpenJDK                                                         | 17.0.31804.368 |
| Component.UnityEngine.x64                                                 | 17.0.31804.368 |
| Component.Unreal                                                          | 17.0.31804.368 |
| Component.Unreal.Android                                                  | 17.0.31804.368 |
| Component.VSInstallerProjects2022                                         | 0.1.0          |
| Component.Xamarin                                                         | 17.0.31804.368 |
| Component.Xamarin.RemotedSimulator                                        | 17.0.31807.282 |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.0.31805.14  |
| Microsoft.Component.ClickOnce                                             | 17.0.31804.368 |
| Microsoft.Component.MSBuild                                               | 17.0.31804.368 |
| Microsoft.Component.NetFX.Native                                          | 17.0.31804.368 |
| Microsoft.Component.PythonTools                                           | 17.0.31804.368 |
| Microsoft.Component.PythonTools.Web                                       | 17.0.31804.368 |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.0.31804.368 |
| Microsoft.ComponentGroup.Blend                                            | 17.0.31804.368 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.0.31804.368 |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.0.31804.368 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.0.31804.368 |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.0.31804.368 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.0.31804.368 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.0.31804.368 |
| Microsoft.Net.Component.4.8.SDK                                           | 17.0.31804.368 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.0.31804.368 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.0.31804.368 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.0.31804.368 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.0.31804.368 |
| microsoft.net.runtime.mono.tooling                                        | 6.0.121.56705  |
| microsoft.net.sdk.emscripten                                              | 6.0.5.2003     |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.0.31804.368 |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.0.32002.159 |
| Microsoft.NetCore.Component.SDK                                           | 17.0.32002.159 |
| Microsoft.NetCore.Component.Web                                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.0.31821.396 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.0.32001.416 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Merq                                     | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.0.32001.416 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Unity                                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM.Spectre               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64.Spectre             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64                   | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.x86.x64.Spectre           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64EC                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64EC                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Web                                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 17.0.31821.396 |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.0.31804.368 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.0.31806.525 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.0.31804.368 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.Data                                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.0.31821.396 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.0.31902.203 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.Node                                      | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.Office                                    | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.Python                                    | 17.0.31919.74  |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.0.31804.368 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.0.31804.368 |
| wasm.tools                                                                | 6.0.121.56705  |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 0.1.0          |

#### Microsoft Visual C++:
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.30.30704 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.30.30704 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.30.30704 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.30.30704 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.30.30704 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.30.30704 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 3.1.120 3.1.202 3.1.302 3.1.416 5.0.104 5.0.210 5.0.303 5.0.404 6.0.101

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.21 3.1.22 5.0.4 5.0.9 5.0.12 5.0.13 6.0.1

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 3.1.4 3.1.6 3.1.20 3.1.21 3.1.22 5.0.4 5.0.9 5.0.12 5.0.13 6.0.1

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.20 3.1.22 5.0.4 5.0.9 5.0.13 6.0.1

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.8

### PowerShell Tools
- PowerShell 7.2.1

#### Azure Powershell Modules
| Module  | Version                                                                         | Path                           |
| ------- | ------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 6.5.0                                                                           | C:\Modules\az_\<version\>      |
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
| DockerMsftProvider | 1.0.0.8          |
| MarkdownPS         | 1.9              |
| Microsoft.Graph    | 1.9.0            |
| Pester             | 3.4.0<br>5.3.1   |
| PowerShellGet      | 1.0.0.1<br>2.2.5 |
| PSScriptAnalyzer   | 1.20.0           |
| PSWindowsUpdate    | 2.2.0.2          |
| SqlServer          | 21.1.18256       |
| VSSetup            | 2.2.16           |

### Android
| Package Name               | Version                                                                                                                                      |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                          |
| Android Emulator           | 31.1.4                                                                                                                                       |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)             |
| Android SDK Platform-Tools | 31.0.3                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                       |
| CMake                      | 3.18.1                                                                                                                                       |
| Google Play services       | 49                                                                                                                                           |
| Google Repository          | 58                                                                                                                                           |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.1.7779620                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                            |

#### Environment variables
| Name                    | Value                                                                        |
| ----------------------- | ---------------------------------------------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                                                       |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\23.1.7779620                                      |
| ANDROID_NDK_PATH        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                                                       |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:f361f9071edda48d05910f4e77f17f7bdb83f75e3f5504c70b31eb3efa784d09  | 2021-12-14 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:6e9e92babd4d6ea9b1b79bb4c39b8eebff794923368b7602fdecc2fda7811855  | 2021-12-14 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:26d0f5d9c0287dd89900e8d82a59cef31d8e62dcd624227d286654ac618cc4c2  | 2021-12-14 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:802c38698f46f154711a18c4ac31b224e05159dd287e662d2a16a1ffc4be7d15  | 2021-12-08 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:1f8965b9b4e2097ac78590ba652f069eafd5b6a0a4e9e603a415d362bfb7638c  | 2021-12-08 |


