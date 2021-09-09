| Announcements |
|-|
| [(Public Beta) Windows Server 2022 with Visual Studio 2022 is now available](https://github.com/actions/virtual-environments/issues/3949) |
| [[macOS, Windows] .NET SDK pre-installation policy will be changed on September, 6](https://github.com/actions/virtual-environments/issues/3809) |
***
# Microsoft Windows Server 2022 Datacenter
- OS Version: 10.0.20348 Build 169
- Image Version: 20210901.3

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.16.7
- Julia 1.6.2
- Kotlin 1.5.20
- Node 14.17.6
- PHP 8.0.10
- Python 3.9.6
- Ruby 3.0.2p107

### Package Management
- Chocolatey 0.10.15
- Composer 2.1.6
- Helm 3.6.3
- NPM 6.14.15
- NuGet 5.11.0.10
- pip 21.2.4 (python 3.9)
- Pipx 0.16.4
- RubyGems 3.2.22
- Vcpkg  (build from master \<5bc27e8>)
- Yarn 1.22.11

#### Environment variables
| Name                    | Value    |
| ----------------------- | -------- |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg |

### Project Management
- Ant 1.10.11
- Gradle 7.2
- Maven 3.8.2

### Tools
- 7zip 19.00
- aria2 1.36.0
- azcopy 10.12.0
- Bazel 4.2.1
- Bazelisk 1.10.1
- Bicep 0.4.613
- Cabal 3.4.0.0
- CMake 3.21.2
- CodeQL Action Bundle 2.6.0
- Docker 20.10.6
- Docker-compose 1.29.2
- ghc 9.0.1
- Git 2.33.0
- Git LFS 2.13.3
- GVFS 1.0.21085.9
- jq 1.6
- Kind 0.11.1
- Kubectl 1.22.1
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.2.4
- OpenSSL 1.1.1
- Packer 1.7.4
- Pulumi v3.11.0
- R 4.1.1
- Stack 2.7.3
- Subversion (SVN) 1.14.1
- Swig 4.0.2
- VSWhere 2.8.4
- WinAppDriver 1.2.2009.02003
- yamllint 1.26.3
- zstd 1.5.0

### CLI Tools
- Alibaba Cloud CLI 3.0.90
- AWS CLI 2.2.33
- AWS SAM CLI 1.29.0
- AWS Session Manager CLI 1.2.245.0
- Azure CLI 2.27.2
- Azure DevOps CLI extension 0.20.0
- GitHub CLI 2.0.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.54.0
- Rust 1.54.0
- Rustdoc 1.54.0
- Rustup 1.24.3

#### Packages
- bindgen 0.59.1
- cargo-audit 0.14.1
- cargo-outdated v0.9.17
- cbindgen 0.20.0
- Clippy 0.1.54
- Rustfmt 1.4.37

### Browsers and webdrivers
- Google Chrome 93.0.4577.63
- Chrome Driver 93.0.4577.15
- Microsoft Edge 92.0.902.84
- Microsoft Edge Driver 92.0.902.84
- Mozilla Firefox 91.0.2
- Gecko Driver 0.29.1
- IE Driver 3.150.1.1

#### Environment variables
| Name            | Value                              |
| --------------- | ---------------------------------- |
| CHROMEWEBDRIVER | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER   | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER  | C:\SeleniumWebDrivers\GeckoDriver  |

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.302+8 (default) | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 11.0.12+7           | Adopt OpenJDK | JAVA_HOME_11_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### MSYS2
- Pacman 6.0.0
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
| 1.16.7 (Default) | x64          | GOROOT_1_16_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 10.24.1 | x64          |
| 12.22.6 | x64          |
| 14.17.6 | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 3.7.9   | x64          |
| 3.8.10  | x64          |
| 3.9.6 (Default) | x64          |


#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.7.4   | x64          |
| 3.0.2 (Default) | x64          |


#### PyPy
| Python Version | PyPy Version |
| -------------- | ------------ |
| 2.7.18         | PyPy 7.3.5 with MSC v.1927 64 bit (AMD64) |
| 3.7.10         | PyPy 7.3.5 with MSC v.1927 64 bit (AMD64) |



### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-13                                                                                                                    |
| Version              | 13.4                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\13\bin <br> PGDATA=C:\Program Files\PostgreSQL\13\data <br> PGROOT=C:\Program Files\PostgreSQL\13  |
| Path                 | C:\Program Files\PostgreSQL\13                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |


#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 5.0.2.0 | MongoDB     | Running       | Automatic        |



### Database tools
- Azure CosmosDb Emulator 2.14.2.0
- DacFx 15.0.5164.1
- MySQL 5.7.21.0
- SQLPS 1.0


### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.48  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.21.2  | C:\tools\nginx-1.21.2\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version        | Path                                                  |
| ----------------------------- | -------------- | ----------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.0.31612.314 | C:\Program Files\Microsoft Visual Studio\2022\Preview |

#### Workloads, components and extensions:

| Package                                                                   | Version        |
| ------------------------------------------------------------------------- | -------------- |
| Component.Android.NDK.R21E                                                | 17.0.31530.272 |
| Component.Android.SDK25.Private                                           | 17.0.31530.272 |
| Component.Android.SDK30                                                   | 17.0.31530.272 |
| Component.Ant                                                             | 1.9.3.8        |
| Component.Linux.CMake                                                     | 17.0.31530.272 |
| Component.MDD.Android                                                     | 17.0.31530.272 |
| Component.MDD.Linux                                                       | 17.0.31530.272 |
| Component.Microsoft.VisualStudio.LiveShare                                | 1.0.4583       |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.0.31530.272 |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.0.31530.272 |
| Component.Microsoft.Web.LibraryManager                                    | 17.0.31530.272 |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 0.9.8.45772    |
| Component.OpenJDK                                                         | 17.0.31530.272 |
| Component.UnityEngine.x64                                                 | 17.0.31530.272 |
| Component.Unreal                                                          | 17.0.31530.272 |
| Component.Unreal.Android                                                  | 17.0.31530.272 |
| Component.Xamarin                                                         | 17.0.31530.272 |
| Component.Xamarin.RemotedSimulator                                        | 17.0.31530.272 |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.0.31530.272 |
| Microsoft.Component.MSBuild                                               | 17.0.31530.272 |
| Microsoft.Component.NetFX.Native                                          | 17.0.31530.272 |
| Microsoft.Component.PythonTools                                           | 17.0.31530.272 |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.0.31530.272 |
| Microsoft.ComponentGroup.Blend                                            | 17.0.31530.272 |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.0.31530.272 |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.0.31530.272 |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.0.31530.272 |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.0.31530.272 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.0.31530.272 |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.0.31530.272 |
| Microsoft.Net.Component.4.8.SDK                                           | 17.0.31530.272 |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.0.31530.272 |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.0.31530.272 |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.0.31530.272 |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.0.31530.272 |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.0.31530.272 |
| Microsoft.NetCore.Component.Runtime.6.0                                   | 17.0.31604.169 |
| Microsoft.NetCore.Component.SDK                                           | 17.0.31604.169 |
| Microsoft.NetCore.Component.Web                                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Merq                                     | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Unity                                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Web                                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.0.31530.272 |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.0.31530.272 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.Data                                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.Node                                      | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.Office                                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.Python                                    | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.0.31530.272 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.0.31530.272 |

#### Microsoft Visual C++:

| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.30.30423 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.30.30423 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.30.30423 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.30.30423 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.30.30423 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.30.30423 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 3.1.118 3.1.202 3.1.302 3.1.412 5.0.104 5.0.206 5.0.303 5.0.400 6.0.100-preview.7.21379.14

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 3.1.4 3.1.6 3.1.18 5.0.4 5.0.9 6.0.0-preview.7.21378.6

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 3.1.4 3.1.6 3.1.18 5.0.4 5.0.9 6.0.0-preview.7.21377.19

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.18 5.0.4 5.0.9 6.0.0-preview.7.21378.9

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.8

### PowerShell Tools
- PowerShell 7.1.4

#### Azure Powershell Modules
| Module  | Version                                                                         | Path                           |
| ------- | ------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 6.1.0                                                                           | C:\Modules\az_\<version\>      |
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
| Pester             | 3.4.0<br>5.3.0   |
| PowerShellGet      | 1.0.0.1<br>2.2.5 |
| PSScriptAnalyzer   | 1.20.0           |
| PSWindowsUpdate    | 2.2.0.2          |
| SqlServer          | 21.1.18256       |
| VSSetup            | 2.2.16           |

### Android
| Package Name               | Version                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                |
| Android Emulator           | 30.8.4                                                                                                                             |
| Android SDK Build-tools    | 31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)                         |
| Android SDK Platform-Tools | 31.0.3                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                             |
| CMake                      | 3.18.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                 |
| Google Repository          | 58                                                                                                                                 |
| NDK                        | a<br>a<br>21.4.7075529<br>22.1.7171670                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                  |

#### Environment variables
| Name                    | Value                                                                        |
| ----------------------- | ---------------------------------------------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                                                       |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\22.1.7171670                                      |
| ANDROID_NDK_PATH        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                                                       |



