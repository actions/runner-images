# Microsoft Windows Server 2019 Datacenter
- OS Version: 10.0.17763 Build 1339
- Image Version: 20200726.1

## Enabled windows optional features
- Windows Subsystem for Linux

## Installed Software
### Language and Runtime
- Java 1.7.0_232 
- Java 1.8.0_262 (default)
- Java 11.0.8 
- Java 13.0.2 
- Python 3.7.8
- Ruby 2.5.8p224
- Go 1.14.6
- PHP 7.4.7
- Julia 1.4.2
- Perl 5.30.2
- Node 12.18.3

### Package Management
- Chocolatey 0.10.15
- Vcpkg 2020.06.15
- NPM 6.14.6
- Yarn 1.22.4
- pip 20.1.1 (python 3.7)
- Miniconda 4.6.14
- RubyGems 3.1.4
- Helm 3.2.4
- Composer 1.10.9
- NuGet 5.6.0.6591

### Project Management
- Ant 1.10.5
- Maven 3.6.3
- Gradle 6.5
- sbt 1.3.13

### Tools
- Azure CosmosDb Emulator 2.11.2.0
- Bazel 3.4.1
- Bazelisk 1.5.0
- CMake 3.18.0
- Docker 19.03.11
- Docker-compose 1.26.0
- Git 2.27.0
- Git LFS 2.11.0
- InnoSetup 6.0.5
- jq 1.6
- Kubectl 1.18.6
- Kind 0.8.1
- Mingw-w64 8.1.0
- MySQL 5.7.21.0
- Mercurial 5.0
- NSIS 3.5.0.20200106
- Newman 5.1.2
- OpenSSL 1.1.1
- Packer 1.6.0
- SQLPS 1.0
- SQLServer PS 21.1.18226
- Subversion (SVN) 1.8.17
- ghc 8.10.1
- Cabal 3.2.0.0
- Stack 2.3.1
- WinAppDriver 1.1.1809.18001
- zstd 1.4.0
- VSWhere 2.8.4
- 7zip 19.00

### CLI Tools
- Azure CLI 2.9.1
- azcopy 10.5.1
- Azure DevOps CLI extension 0.18.0
- AWS CLI 2.0.34
- AWS SAM CLI 1.0.0
- AWS Session Manager CLI 1.1.61.0
- Alibaba Cloud CLI 3.0.26
- Cloud Foundry CLI 6.51.0
- Hub CLI 2.14.2
- Google Cloud SDK 302.0.0

### Rust Tools
- Rust 1.45.0

#### Packages
- bindgen 0.54.1
- cbindgen 0.14.3
- cargo-audit 0.12.0
- cargo-outdated v0.9.11

### Browsers and webdrivers
- Google Chrome 84.0.4147.89
- Chrome Driver 84.0.4147.30
- Microsoft Edge 84.0.522.44
- Microsoft Edge Driver 84.0.522.44
- Mozilla Firefox 78.0.2
- Gecko Driver 0.26.0
- IE Driver 3.150.1.0

### MSYS2
- Pacman 5.2.2
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
### Cached Tools
#### Boost
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.69.0  | x64, x86     | BOOST_ROOT_1_69_0    |
| 1.72.0  | x64, x86     | BOOST_ROOT_1_72_0    |
##### Notes:
```
1. Environment variable "BOOST_ROOT" is not set by default.
   Please make sure you set this variable value to proper value
   from table above depending on the Boost version you are using.
2. If Boost was built using the boost-cmake project or from Boost 1.70.0
   on it provides a package configuration file for use with find_package's config mode.
   This module looks for the package configuration file called BoostConfig.cmake or boost-config.cmake
   and stores the result in CACHE entry "Boost_DIR". If found, the package configuration file
   is loaded and this module returns with no further action.
   See documentation of the Boost CMake package configuration for details on what it provides.
   Set Boost_NO_BOOST_CMAKE to ON, to disable the search for boost-cmake.
   Link: https://cmake.org/cmake/help/latest/module/FindBoost.html
```

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.9.7   | x64          | GOROOT_1_9_X64       |
| 1.10.8  | x64          | GOROOT_1_10_X64      |
| 1.11.13 | x64          | GOROOT_1_11_X64      |
| 1.12.17 | x64          | GOROOT_1_12_X64      |
| 1.13.14 | x64          | GOROOT_1_13_X64      |
| 1.14.6 (Default) | x64          | GOROOT_1_14_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 8.17.0  | x64          |
| 10.22.0 | x64          |
| 12.18.3 | x64          |
| 14.6.0  | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 2.7.18  | x64, x86     |
| 3.5.4   | x64, x86     |
| 3.6.8   | x64, x86     |
| 3.7.8 (Default) | x64, x86     |
| 3.8.5   | x64, x86     |


#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.4.10  | x64          |
| 2.5.8 (Default) | x64          |
| 2.6.6   | x64          |
| 2.7.1   | x64          |


#### PyPy
| Python Version | Architecture | PyPy Version |
| -------------- | ------------ | ------------ |
| 2.7.13         | x86          | PyPy 7.3.1 with MSC v.1912 32 bit |
| 3.6.9          | x86          | PyPy 7.3.1 with MSC v.1912 32 bit |



### Databases
#### PostgreSQL
| Version | UserName | Password | EnvironmentVariables                                                                                                                  | Path                           | ServiceName       | ServiceStatus | ServiceStartType |
| ------- | -------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ | ----------------- | ------------- | ---------------- |
| 12.3    | postgres | root     | PGBIN=C:\Program Files\PostgreSQL\12\bin; <br> PGDATA=C:\Program Files\PostgreSQL\12\data; <br> PGROOT=C:\Program Files\PostgreSQL\12 | C:\Program Files\PostgreSQL\12 | postgresql-x64-12 | Stopped       | Disabled         |


#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 4.2.8.0 | MongoDB     | Running       | Automatic        |



### Visual Studio Enterprise 2019
| Name                          | Version       | Path                                                           |
| ----------------------------- | ------------- | -------------------------------------------------------------- |
| Visual Studio Enterprise 2019 | 16.6.30320.27 | C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise |

#### Workloads, components and extensions:

| Package                                                                   |
| ------------------------------------------------------------------------- |
| Component.Android.NDK.R16B                                                |
| Component.Android.SDK25.Private                                           |
| Component.Android.SDK28                                                   |
| Component.Ant                                                             |
| Component.Dotfuscator                                                     |
| Component.Linux.CMake                                                     |
| Component.MDD.Android                                                     |
| Component.MDD.Linux                                                       |
| Component.MDD.Linux.GCC.arm                                               |
| Component.Microsoft.VisualStudio.LiveShare                                |
| Component.Microsoft.VisualStudio.RazorExtension                           |
| Component.Microsoft.VisualStudio.Tools.Applications                       |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       |
| Component.Microsoft.Web.LibraryManager                                    |
| Component.Microsoft.Windows.DriverKit                                     |
| Component.OpenJDK                                                         |
| Component.UnityEngine.x64                                                 |
| Component.Unreal                                                          |
| Component.Unreal.Android                                                  |
| Component.WixToolset.VisualStudioExtension.Dev16                          |
| Component.WixToolset.VisualStudioExtension.Schemas3                       |
| Component.WixToolset.VisualStudioExtension.Schemas4                       |
| Component.Xamarin                                                         |
| Component.Xamarin.RemotedSimulator                                        |
| Microsoft.Component.Azure.DataLake.Tools                                  |
| Microsoft.Component.MSBuild                                               |
| Microsoft.Component.NetFX.Native                                          |
| Microsoft.Component.PythonTools                                           |
| Microsoft.Component.PythonTools.Miniconda                                 |
| Microsoft.Component.PythonTools.Web                                       |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    |
| Microsoft.ComponentGroup.Blend                                            |
| Microsoft.Net.Component.3.5.DeveloperTools                                |
| Microsoft.Net.Component.4.5.1.TargetingPack                               |
| Microsoft.Net.Component.4.5.2.TargetingPack                               |
| Microsoft.Net.Component.4.5.TargetingPack                                 |
| Microsoft.Net.Component.4.6.1.TargetingPack                               |
| Microsoft.Net.Component.4.6.2.TargetingPack                               |
| Microsoft.Net.Component.4.6.TargetingPack                                 |
| Microsoft.Net.Component.4.7.1.TargetingPack                               |
| Microsoft.Net.Component.4.7.2.SDK                                         |
| Microsoft.Net.Component.4.7.2.TargetingPack                               |
| Microsoft.Net.Component.4.7.TargetingPack                                 |
| Microsoft.Net.Component.4.8.SDK                                           |
| Microsoft.Net.Component.4.TargetingPack                                   |
| Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools                         |
| Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools                         |
| Microsoft.Net.ComponentGroup.4.7.DeveloperTools                           |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        |
| Microsoft.Net.Core.Component.SDK.2.1                                      |
| Microsoft.NetCore.Component.DevelopmentTools                              |
| Microsoft.NetCore.Component.Runtime.3.1                                   |
| Microsoft.NetCore.Component.SDK                                           |
| Microsoft.NetCore.Component.Web                                           |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        |
| Microsoft.VisualStudio.Component.AspNet45                                 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   |
| Microsoft.VisualStudio.Component.Azure.Kubernetes.Tools                   |
| Microsoft.VisualStudio.Component.Azure.Powershell                         |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                |
| Microsoft.VisualStudio.Component.Azure.Storage.AzCopy                     |
| Microsoft.VisualStudio.Component.Azure.Storage.Emulator                   |
| Microsoft.VisualStudio.Component.Azure.Waverton                           |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                |
| Microsoft.VisualStudio.Component.ClassDesigner                            |
| Microsoft.VisualStudio.Component.CloudExplorer                            |
| Microsoft.VisualStudio.Component.CodeMap                                  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       |
| Microsoft.VisualStudio.Component.CoreEditor                               |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        |
| Microsoft.VisualStudio.Component.Debugger.TimeTravel                      |
| Microsoft.VisualStudio.Component.DiagnosticTools                          |
| Microsoft.VisualStudio.Component.DockerTools                              |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       |
| Microsoft.VisualStudio.Component.DslTools                                 |
| Microsoft.VisualStudio.Component.EntityFramework                          |
| Microsoft.VisualStudio.Component.FSharp                                   |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      |
| Microsoft.VisualStudio.Component.GraphDocument                            |
| Microsoft.VisualStudio.Component.Graphics                                 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           |
| Microsoft.VisualStudio.Component.IISExpress                               |
| Microsoft.VisualStudio.Component.IntelliCode                              |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    |
| Microsoft.VisualStudio.Component.LinqToSql                                |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             |
| Microsoft.VisualStudio.Component.Merq                                     |
| Microsoft.VisualStudio.Component.MonoDebugger                             |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         |
| Microsoft.VisualStudio.Component.Node.Tools                               |
| Microsoft.VisualStudio.Component.NuGet                                    |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         |
| Microsoft.VisualStudio.Component.PortableLibrary                          |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         |
| Microsoft.VisualStudio.Component.SQL.ADAL                                 |
| Microsoft.VisualStudio.Component.SQL.CLR                                  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 |
| Microsoft.VisualStudio.Component.TeamOffice                               |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    |
| Microsoft.VisualStudio.Component.TextTemplating                           |
| Microsoft.VisualStudio.Component.TypeScript.3.8                           |
| Microsoft.VisualStudio.Component.Unity                                    |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             |
| Microsoft.VisualStudio.Component.VC.14.25.x86.x64                         |
| Microsoft.VisualStudio.Component.VC.140                                   |
| Microsoft.VisualStudio.Component.VC.ASAN                                  |
| Microsoft.VisualStudio.Component.VC.ATL                                   |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         |
| Microsoft.VisualStudio.Component.VC.CoreIde                               |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM.Spectre                  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM64.Spectre                |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM.Spectre                  |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM64.Spectre                |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  |
| Microsoft.VisualStudio.Component.VSSDK                                    |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              |
| Microsoft.VisualStudio.Component.Web                                      |
| Microsoft.VisualStudio.Component.WebDeploy                                |
| Microsoft.VisualStudio.Component.Windows10SDK                             |
| Microsoft.VisualStudio.Component.Windows10SDK.16299                       |
| Microsoft.VisualStudio.Component.Windows10SDK.17134                       |
| Microsoft.VisualStudio.Component.Windows10SDK.17763                       |
| Microsoft.VisualStudio.Component.Windows10SDK.18362                       |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       |
| Microsoft.VisualStudio.Component.WinXP                                    |
| Microsoft.VisualStudio.Component.Workflow                                 |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites |
| Microsoft.VisualStudio.ComponentGroup.Web                                 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   |
| Microsoft.VisualStudio.Workload.Azure                                     |
| Microsoft.VisualStudio.Workload.CoreEditor                                |
| Microsoft.VisualStudio.Workload.Data                                      |
| Microsoft.VisualStudio.Workload.DataScience                               |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            |
| Microsoft.VisualStudio.Workload.ManagedGame                               |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           |
| Microsoft.VisualStudio.Workload.NativeDesktop                             |
| Microsoft.VisualStudio.Workload.NativeGame                                |
| Microsoft.VisualStudio.Workload.NativeMobile                              |
| Microsoft.VisualStudio.Workload.NetCoreTools                              |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              |
| Microsoft.VisualStudio.Workload.NetWeb                                    |
| Microsoft.VisualStudio.Workload.Node                                      |
| Microsoft.VisualStudio.Workload.Office                                    |
| Microsoft.VisualStudio.Workload.Python                                    |
| Microsoft.VisualStudio.Workload.Universal                                 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     |
| SSDT Microsoft Analysis Services Projects                                 |
| SSDT SQL Server Integration Services Projects                             |
| SSDT Microsoft Reporting Services Projects                                |
| Windows Driver Kit                                                        |
| Windows Driver Kit Visual Studio Extension                                |
| WIX Toolset                                                               |
| WIX Toolset Studio 2019 Extension                                         |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.All`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20

`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.7.2 4.8

### PowerShell Tools
- PowerShell 7.0.3

#### Azure Powershell Modules
| Module  | Version                                                                       | Path                           |
| ------- | ----------------------------------------------------------------------------- | ------------------------------ |
| Az      | 1.0.0<br>1.6.0<br>2.3.2<br>2.6.0<br>3.1.0<br>3.5.0<br>3.8.0<br>4.3.0<br>4.4.0 | C:\Modules\az_\<version\>      |
| Azure   | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>5.3.0                         | C:\Modules\azure_\<version\>   |
| AzureRM | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>6.7.0<br>6.13.1               | C:\Modules\azurerm_\<version\> |
```
Azure PowerShell module 2.1.0 and AzureRM PowerShell module 2.1.0 are installed
and are available via 'Get-Module -ListAvailable'.
All other versions are saved but not installed.
```
#### Powershell Modules
| Module             | Version            |
| ------------------ | ------------------ |
| DockerMsftProvider | 1.0.0.8            |
| MarkdownPS         | 1.9                |
| Pester             | 3.4.0<br>5.0.2     |
| PowerShellGet      | 1.0.0.1<br>2.2.4.1 |
| PSWindowsUpdate    | 2.2.0.2            |
| SqlServer          | 21.1.18226         |

### Android SDK Tools
| Package Name   | Description                                 |
| -------------- | ------------------------------------------- |
| platform-tools | Android SDK Platform-Tools, Revision 30.0.3 |
| tools          | Android SDK Tools 26.1.1, Revision 26.1.1   |

### Android SDK Platforms
`Location C:\Program Files (x86)\Android\android-sdk\platforms`
| Package Name | Description                                |
| ------------ | ------------------------------------------ |
| android-19   | Android SDK Platform 19, Revision 4        |
| android-21   | Android SDK Platform 21, Revision 2        |
| android-22   | Android SDK Platform 22, Revision 2        |
| android-23   | Android SDK Platform 23, Revision 3        |
| android-24   | Android SDK Platform 24, Revision 2        |
| android-25   | Android SDK Platform 25, Revision 3        |
| android-26   | Android SDK Platform 26, Revision 2        |
| android-27   | Android SDK Platform 27, Revision 3        |
| android-28   | Android SDK Platform 28, rev 6, Revision 6 |
| android-29   | Android SDK Platform 29, Revision 4        |
| android-30   | Android SDK Platform 30, Revision 2        |

### Android SDK Build-Tools
`Location C:\Program Files (x86)\Android\android-sdk\build-tools`
| Package Name       | Description                              |
| ------------------ | ---------------------------------------- |
| build-tools-19.1.0 | Android SDK Build-Tools, Revision 19.1.0 |
| build-tools-20.0.0 | Android SDK Build-Tools, Revision 20.0.0 |
| build-tools-21.1.2 | Android SDK Build-Tools, Revision 21.1.2 |
| build-tools-22.0.1 | Android SDK Build-Tools, Revision 22.0.1 |
| build-tools-23.0.1 | Android SDK Build-Tools, Revision 23.0.1 |
| build-tools-23.0.2 | Android SDK Build-Tools, Revision 23.0.2 |
| build-tools-23.0.3 | Android SDK Build-Tools, Revision 23.0.3 |
| build-tools-24.0.0 | Android SDK Build-Tools, Revision 24.0.0 |
| build-tools-24.0.1 | Android SDK Build-Tools, Revision 24.0.1 |
| build-tools-24.0.2 | Android SDK Build-Tools, Revision 24.0.2 |
| build-tools-24.0.3 | Android SDK Build-Tools, Revision 24.0.3 |
| build-tools-25.0.0 | Android SDK Build-Tools, Revision 25.0.0 |
| build-tools-25.0.1 | Android SDK Build-Tools, Revision 25.0.1 |
| build-tools-25.0.2 | Android SDK Build-Tools, Revision 25.0.2 |
| build-tools-25.0.3 | Android SDK Build-Tools, Revision 25.0.3 |
| build-tools-26.0.0 | Android SDK Build-Tools, Revision 26.0.0 |
| build-tools-26.0.1 | Android SDK Build-Tools, Revision 26.0.1 |
| build-tools-26.0.2 | Android SDK Build-Tools, Revision 26.0.2 |
| build-tools-26.0.3 | Android SDK Build-Tools, Revision 26.0.3 |
| build-tools-27.0.0 | Android SDK Build-Tools, Revision 27.0.0 |
| build-tools-27.0.1 | Android SDK Build-Tools, Revision 27.0.1 |
| build-tools-27.0.2 | Android SDK Build-Tools, Revision 27.0.2 |
| build-tools-27.0.3 | Android SDK Build-Tools, Revision 27.0.3 |
| build-tools-28.0.0 | Android SDK Build-Tools, Revision 28.0.0 |
| build-tools-28.0.1 | Android SDK Build-Tools, Revision 28.0.1 |
| build-tools-28.0.2 | Android SDK Build-Tools, Revision 28.0.2 |
| build-tools-28.0.3 | Android SDK Build-Tools, Revision 28.0.3 |
| build-tools-29.0.0 | Android SDK Build-Tools, Revision 29.0.0 |
| build-tools-29.0.1 | Android SDK Build-Tools, Revision 29.0.1 |
| build-tools-29.0.2 | Android SDK Build-Tools, Revision 29.0.2 |
| build-tools-29.0.3 | Android SDK Build-Tools, Revision 29.0.3 |
| build-tools-30.0.0 | Android SDK Build-Tools, Revision 30.0.0 |

### Android Extra Packages
| Package Name               | Version      |
| -------------------------- | ------------ |
| Android Support Repository | 47.0.0       |
| Google Play services       | 49           |
| Google Repository          | 58           |
| NDK                        | 21.3.6528147 |

### Cached Docker images
-  mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
-  mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019
-  mcr.microsoft.com/windows/servercore:ltsc2019
-  mcr.microsoft.com/windows/nanoserver:1809
-  microsoft/aspnetcore-build:1.0-2.0


