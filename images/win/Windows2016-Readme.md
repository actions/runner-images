| Announcements |
|-|
| [[Windows, Ubuntu] Boost 1.72.0 will be removed from images on March, 8](https://github.com/actions/virtual-environments/issues/2667) |
| [[ubuntu, windows] Default Go version will be set to 1.15 on February, 8](https://github.com/actions/virtual-environments/issues/2447) |
| [[all OSs] Java 7 will be removed from images on February, 8.](https://github.com/actions/virtual-environments/issues/2446) |
| [[Windows] Default PHP is set to 8.0](https://github.com/actions/virtual-environments/issues/2416) |
***
# Microsoft Windows Server 2016 Datacenter
- OS Version: 10.0.14393 Build 4169
- Image Version: 20210209.1

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.15.8
- Julia 1.5.3
- Node 14.15.4
- Perl 5.32.1
- PHP 8.0.1
- Python 3.7.9
- Ruby 2.5.8p224

### Package Management
- Chocolatey 0.10.15
- Composer 2.0.9
- Helm 3.5.2
- Miniconda 4.9.2
- NPM 6.14.10
- NuGet 5.8.1.7021
- pip 21.0.1 (python 3.7)
- Pipx 0.16.0.0
- RubyGems 2.7.6.2
- Vcpkg  (build from master \<ea11604>)
- Yarn 1.22.10

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| CONDA                   | C:\Miniconda |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |

### Project Management
- Ant 1.10.9
- Gradle 6.8
- Maven 3.6.3
- sbt 1.4.7

### Tools
- 7zip 19.00
- azcopy 10.8.0
- Bazel 4.0.0
- Bazelisk 1.7.3
- Cabal 3.2.0.0
- CMake 3.19.4
- CodeQL Action Bundle 2.4.2
- Docker 19.03.14
- Docker-compose 1.27.4
- ghc 8.10.4
- Git 2.30.0
- Git LFS 2.13.2
- Google Cloud SDK 326.0.0
- InnoSetup 6.1.2
- jq 1.6
- Kind 0.10.0
- Kubectl 1.20.2
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.2.2
- NSIS v3.06.1
- OpenSSL 1.1.1
- Packer 1.6.6
- Pulumi v2.20.0
- R 4.0.3
- Stack 2.5.1
- Subversion (SVN) 1.14.0
- VSWhere 2.8.4
- WinAppDriver 1.2.2009.02003
- yamllint 1.26.0
- zstd 1.4.5

### CLI Tools
- Alibaba Cloud CLI 3.0.71
- AWS CLI 2.1.24
- AWS SAM CLI 1.17.0
- AWS Session Manager CLI 1.2.54.0
- Azure CLI 2.18.0
- Azure Dev Spaces CLI 1.0.20201219.2
- Azure DevOps CLI extension 0.18.0
- Cloud Foundry CLI 6.53.0
- GitHub CLI 1.5.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.49.0
- Rust 1.49.0
- Rustdoc 1.49.0
- Rustup 1.23.1

#### Packages
- bindgen 0.57.0
- cargo-audit 0.13.1
- cargo-outdated v0.9.14
- cbindgen 0.17.0
- Clippy 0.0.212
- Rustfmt 1.4.25

### Browsers and webdrivers
- Google Chrome 88.0.4324.150
- Chrome Driver 88.0.4324.96
- Microsoft Edge 88.0.705.63
- Microsoft Edge Driver 88.0.705.63
- Mozilla Firefox 85.0.1
- Gecko Driver 0.29.0
- IE Driver 3.150.1.0

#### Environment variables
| Name            | Value                              |
| --------------- | ---------------------------------- |
| CHROMEWEBDRIVER | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER   | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER  | C:\SeleniumWebDrivers\GeckoDriver  |

### Java
| Version             | Vendor       | Environment Variable |
| ------------------- | ------------ | -------------------- |
| 1.8.0_282 (default) | AdoptOpenJDK | JAVA_HOME_8_X64      |
| 11.0.10             | AdoptOpenJDK | JAVA_HOME_11_X64     |
| 13.0.2              | AdoptOpenJDK | JAVA_HOME_13_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |

### MSYS2
- Pacman 5.2.2
##### Notes:
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```
### Cached Tools
#### Boost
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
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
| 1.13.15 | x64          | GOROOT_1_13_X64      |
| 1.14.15 | x64          | GOROOT_1_14_X64      |
| 1.15.8 (Default) | x64          | GOROOT_1_15_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 10.23.2 | x64          |
| 12.20.1 | x64          |
| 14.15.4 | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 2.7.18  | x64, x86     |
| 3.5.4   | x64, x86     |
| 3.6.8   | x64, x86     |
| 3.7.9 (Default) | x64, x86     |
| 3.8.7   | x64, x86     |
| 3.9.1   | x64, x86     |


#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.4.10  | x64          |
| 2.5.8 (Default) | x64          |
| 2.6.6   | x64          |
| 2.7.2   | x64          |
| 3.0.0   | x64          |


#### PyPy
| Python Version | Architecture | PyPy Version |
| -------------- | ------------ | ------------ |
| 2.7.18         | x86          | PyPy 7.3.3 with MSC v.1927 32 bit |
| 3.6.12         | x86          | PyPy 7.3.3 with MSC v.1927 32 bit |



### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-13                                                                                                                    |
| Version              | 13.1                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\13\bin <br> PGDATA=C:\Program Files\PostgreSQL\13\data <br> PGROOT=C:\Program Files\PostgreSQL\13  |
| Path                 | C:\Program Files\PostgreSQL\13                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |


#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 4.4.3.0 | MongoDB     | Running       | Automatic        |



### Database tools
- Azure CosmosDb Emulator 2.11.10.0
- DacFx 15.0.4897.1
- MySQL 5.7.21.0
- SQLPS 1.0


### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.46  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.19.6  | C:\tools\nginx-1.19.6\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2017
| Name                          | Version         | Path                                                           |
| ----------------------------- | --------------- | -------------------------------------------------------------- |
| Visual Studio Enterprise 2017 | 15.9.28307.1342 | C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise |

#### Workloads, components and extensions:

| Package                                                                   | Version          |
| ------------------------------------------------------------------------- | ---------------- |
| Component.Anaconda3.x64                                                   | 5.2.0            |
| Component.Android.NDK.R12B                                                | 12.1.10          |
| Component.Android.NDK.R15C                                                | 15.2.1           |
| Component.Android.SDK19.Private                                           | 15.9.28107.0     |
| Component.Android.SDK21.Private                                           | 15.9.28016.0     |
| Component.Android.SDK22.Private                                           | 15.9.28016.0     |
| Component.Android.SDK23                                                   | 15.9.28107.0     |
| Component.Android.SDK23.Private                                           | 15.9.28016.0     |
| Component.Android.SDK25.Private                                           | 15.9.28016.0     |
| Component.Android.SDK27                                                   | 15.9.28016.0     |
| Component.Ant                                                             | 1.9.3.8          |
| Component.CordovaToolset.6.3.1                                            | 15.7.27625.0     |
| Component.Dotfuscator                                                     | 15.0.26208.0     |
| Component.Google.Android.Emulator.API27                                   | 15.9.28307.421   |
| Component.HAXM                                                            | 15.9.28307.421   |
| Component.Linux.CMake                                                     | 15.9.28307.102   |
| Component.MDD.Android                                                     | 15.0.26606.0     |
| Component.MDD.Linux                                                       | 15.6.27406.0     |
| Component.Microsoft.VisualStudio.RazorExtension                           | 15.0.26720.2     |
| Component.Microsoft.VisualStudio.Tools.Applications                       | 15.0.27520.3     |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 15.7.27617.1     |
| Component.Microsoft.Web.LibraryManager                                    | 15.8.27705.0     |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.17740.0     |
| Component.OpenJDK                                                         | 15.9.28307.443   |
| Component.Redgate.ReadyRoll                                               | 1.17.18155.10346 |
| Component.Redgate.SQLPrompt.VsPackage                                     | 9.2.0.5601       |
| Component.Redgate.SQLSearch.VSExtension                                   | 3.1.7.2062       |
| Component.UnityEngine.x64                                                 | 15.9.28307.616   |
| Component.Unreal                                                          | 15.8.27729.1     |
| Component.Unreal.Android                                                  | 15.9.28307.341   |
| Component.WixToolset.VisualStudioExtension.Dev15                          | 0.9.21.62588     |
| Component.Xamarin                                                         | 15.9.28307.1177  |
| Component.Xamarin.Profiler                                                | 15.0.27005.2     |
| Component.Xamarin.RemotedSimulator                                        | 15.6.27323.2     |
| Microsoft.Component.Azure.DataLake.Tools                                  | 15.9.28107.0     |
| Microsoft.Component.Blend.SDK.WPF                                         | 15.6.27406.0     |
| Microsoft.Component.ClickOnce                                             | 15.8.27825.0     |
| Microsoft.Component.CookiecutterTools                                     | 15.0.26621.2     |
| Microsoft.Component.MSBuild                                               | 15.7.27520.0     |
| Microsoft.Component.NetFX.Core.Runtime                                    | 15.0.26208.0     |
| Microsoft.Component.NetFX.Native                                          | 15.0.26208.0     |
| Microsoft.Component.PythonTools                                           | 15.0.26823.1     |
| Microsoft.Component.PythonTools.UWP                                       | 15.0.26606.0     |
| Microsoft.Component.PythonTools.Web                                       | 15.9.28107.0     |
| Microsoft.Component.VC.Runtime.OSSupport                                  | 15.6.27406.0     |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 15.6.27309.0     |
| Microsoft.ComponentGroup.Blend                                            | 15.6.27406.0     |
| Microsoft.Net.Component.3.5.DeveloperTools                                | 15.6.27406.0     |
| Microsoft.Net.Component.4.5.1.TargetingPack                               | 15.6.27406.0     |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 15.6.27406.0     |
| Microsoft.Net.Component.4.5.TargetingPack                                 | 15.6.27406.0     |
| Microsoft.Net.Component.4.6.1.SDK                                         | 15.6.27406.0     |
| Microsoft.Net.Component.4.6.1.TargetingPack                               | 15.6.27406.0     |
| Microsoft.Net.Component.4.6.2.SDK                                         | 15.6.27406.0     |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 15.6.27406.0     |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 15.6.27406.0     |
| Microsoft.Net.Component.4.7.1.SDK                                         | 15.6.27406.0     |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 15.6.27406.0     |
| Microsoft.Net.Component.4.7.2.SDK                                         | 15.8.27825.0     |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 15.8.27825.0     |
| Microsoft.Net.Component.4.7.SDK                                           | 15.6.27406.0     |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 15.6.27406.0     |
| Microsoft.Net.Component.4.TargetingPack                                   | 15.6.27406.0     |
| Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools                         | 15.6.27406.0     |
| Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools                         | 15.6.27406.0     |
| Microsoft.Net.ComponentGroup.4.7.2.DeveloperTools                         | 15.8.27825.0     |
| Microsoft.Net.ComponentGroup.4.7.DeveloperTools                           | 15.6.27406.0     |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 15.8.27825.0     |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 15.6.27406.0     |
| Microsoft.Net.Core.Component.SDK.1x                                       | 15.9.28307.1259  |
| Microsoft.Net.Core.Component.SDK.2.1                                      | 15.8.27924.0     |
| Microsoft.NetCore.1x.ComponentGroup.Web                                   | 15.9.28307.1259  |
| Microsoft.NetCore.ComponentGroup.DevelopmentTools.2.1                     | 15.8.27924.0     |
| Microsoft.NetCore.ComponentGroup.Web.2.1                                  | 15.8.27924.0     |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.AspNet45                                 | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 15.9.28307.421   |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 15.9.28307.421   |
| Microsoft.VisualStudio.Component.Azure.MobileAppsSdk                      | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 15.9.28107.0     |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.Azure.Storage.AzCopy                     | 15.0.26906.1     |
| Microsoft.VisualStudio.Component.Azure.Storage.Emulator                   | 15.9.28125.51    |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 15.9.28107.0     |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 15.7.27617.1     |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.CloudExplorer                            | 15.9.28230.55    |
| Microsoft.VisualStudio.Component.CodeClone                                | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.CodeMap                                  | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 15.9.28107.0     |
| Microsoft.VisualStudio.Component.Cordova                                  | 15.0.26606.0     |
| Microsoft.VisualStudio.Component.CoreEditor                               | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 15.0.27005.2     |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 15.8.28010.0     |
| Microsoft.VisualStudio.Component.DependencyValidation.Enterprise          | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.DockerTools                              | 15.8.27906.1     |
| Microsoft.VisualStudio.Component.DockerTools.BuildTools                   | 15.7.27617.1     |
| Microsoft.VisualStudio.Component.DslTools                                 | 15.0.27005.2     |
| Microsoft.VisualStudio.Component.EntityFramework                          | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.FSharp                                   | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 15.9.28307.421   |
| Microsoft.VisualStudio.Component.GraphDocument                            | 15.0.27005.2     |
| Microsoft.VisualStudio.Component.Graphics                                 | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Graphics.Win81                           | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.IISExpress                               | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.JavaScript.ProjectSystem                 | 15.0.26606.0     |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 15.9.28125.51    |
| Microsoft.VisualStudio.Component.LinqToSql                                | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 15.0.26720.2     |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.Merq                                     | 15.8.27924.0     |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 15.0.26720.2     |
| Microsoft.VisualStudio.Component.Node.Build                               | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.Node.Tools                               | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.NuGet                                    | 15.9.28016.0     |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 15.9.28016.0     |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 15.6.27309.0     |
| Microsoft.VisualStudio.Component.R.Open                                   | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.RHost                                    | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 15.6.27309.0     |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.RTools                                   | 15.0.26919.1     |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 15.8.27924.0     |
| Microsoft.VisualStudio.Component.SQL.ADAL                                 | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.SQL.CMDUtils                             | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 15.0.26621.2     |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 15.7.27617.1     |
| Microsoft.VisualStudio.Component.SQL.NCLI                                 | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 15.9.28107.0     |
| Microsoft.VisualStudio.Component.Static.Analysis.Tools                    | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.TeamOffice                               | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 15.0.26606.0     |
| Microsoft.VisualStudio.Component.TestTools.Core                           | 15.7.27520.0     |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.TextTemplating                           | 15.0.26208.0     |
| Microsoft.VisualStudio.Component.TypeScript.2.0                           | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.TypeScript.2.1                           | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.TypeScript.2.2                           | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.TypeScript.2.3                           | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.TypeScript.3.1                           | 15.0.28218.60    |
| Microsoft.VisualStudio.Component.Unity                                    | 15.7.27617.1     |
| Microsoft.VisualStudio.Component.UWP.Support                              | 15.9.28119.51    |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 15.0.28125.51    |
| Microsoft.VisualStudio.Component.VC.140                                   | 15.7.27617.1     |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 15.7.27625.0     |
| Microsoft.VisualStudio.Component.VC.ClangC2                               | 15.7.27520.0     |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 15.6.27309.0     |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 15.9.28307.102   |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 15.0.26823.1     |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 15.6.27309.0     |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 15.9.28230.55    |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 15.9.28230.55    |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 15.9.28230.55    |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 15.9.28307.616   |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 15.8.27906.1     |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 15.9.28230.55    |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 15.9.28230.55    |
| Microsoft.VisualStudio.Component.VisualStudioData                         | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.VSSDK                                    | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 15.8.27924.0     |
| Microsoft.VisualStudio.Component.Web                                      | 15.8.27825.0     |
| Microsoft.VisualStudio.Component.WebDeploy                                | 15.8.27729.1     |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.10240                       | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.10586                       | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.14393                       | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.15063.Desktop               | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.15063.UWP                   | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.15063.UWP.Native            | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop               | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop.arm           | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.16299.UWP                   | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.16299.UWP.Native            | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.Windows10SDK.17134                       | 15.9.28307.102   |
| Microsoft.VisualStudio.Component.Windows10SDK.17763                       | 15.9.28307.102   |
| Microsoft.VisualStudio.Component.Windows81SDK                             | 15.6.27406.0     |
| Microsoft.VisualStudio.Component.WinXP                                    | 15.8.27924.0     |
| Microsoft.VisualStudio.Component.Workflow                                 | 15.8.27825.0     |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Managed           | 15.0.26208.0     |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 15.0.26208.0     |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 15.0.26504.0     |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 15.9.28107.0     |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 15.0.27005.2     |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 15.7.27617.1     |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 15.8.27729.1     |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Win81                 | 15.6.27406.0     |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.WinXP                 | 15.8.27705.0     |
| Microsoft.VisualStudio.ComponentGroup.UWP.Cordova                         | 15.9.28307.102   |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 15.8.27906.1     |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC                              | 15.9.28307.102   |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 15.9.28307.102   |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 15.7.27625.0     |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 15.9.28219.51    |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 15.8.27729.1     |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 15.8.27825.0     |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 15.8.27729.1     |
| Microsoft.VisualStudio.Web.Mvc4.ComponentGroup                            | 15.6.27406.0     |
| Microsoft.VisualStudio.Workload.Azure                                     | 15.8.27906.1     |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 15.0.27205.0     |
| Microsoft.VisualStudio.Workload.Data                                      | 15.6.27309.0     |
| Microsoft.VisualStudio.Workload.DataScience                               | 15.9.28307.421   |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 15.9.28307.1062  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 15.0.27005.2     |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 15.0.27205.0     |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 15.9.28307.102   |
| Microsoft.VisualStudio.Workload.NativeGame                                | 15.9.28307.102   |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 15.9.28107.0     |
| Microsoft.VisualStudio.Workload.NetCoreTools                              | 15.8.27906.1     |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 15.9.28107.0     |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 15.8.27906.1     |
| Microsoft.VisualStudio.Workload.Node                                      | 15.9.28107.0     |
| Microsoft.VisualStudio.Workload.Office                                    | 15.8.27924.0     |
| Microsoft.VisualStudio.Workload.Python                                    | 15.8.27825.0     |
| Microsoft.VisualStudio.Workload.Universal                                 | 15.9.28307.102   |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 15.7.27625.0     |
| Microsoft.VisualStudio.Workload.WebCrossPlat                              | 15.9.28307.341   |
| SSDT Microsoft Analysis Services Projects                                 | 2.9.6            |
| SSDT SQL Server Integration Services Projects                             | 2.6              |
| SSDT Microsoft Reporting Services Projects                                | 2.6.3            |
| Windows Driver Kit                                                        | 3.11.4516        |
| Windows Driver Kit Visual Studio Extension                                | 10.1.17763.1     |
| WIX Toolset                                                               | 3.11.4516        |
| WIX Toolset Studio 2017 Extension                                         | 0.9.21.62588     |

#### Microsoft Visual C++:

| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2010 Redistributable    | x64          | 10.0.30319  |
| Microsoft Visual C++ 2010 Redistributable    | x86          | 10.0.40219  |
| Microsoft Visual C++ 2012 Additional Runtime | x64          | 11.0.61030  |
| Microsoft Visual C++ 2012 Minimum Runtime    | x64          | 11.0.61030  |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Additional Runtime | x86          | 12.0.21005  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x86          | 12.0.21005  |
| Microsoft Visual C++ 2017 Debug Runtime      | x64          | 14.16.27033 |
| Microsoft Visual C++ 2017 Debug Runtime      | x86          | 14.16.27033 |
| Microsoft Visual C++ 2019 Additional Runtime | x64          | 14.28.29325 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x64          | 14.28.29325 |
| Microsoft Visual C++ 2019 Additional Runtime | x86          | 14.28.29325 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x86          | 14.28.29325 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 1.1.14 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 5.0.100 5.0.101 5.0.102

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.All`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 2.1.22 2.1.23 2.1.24

`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 2.1.22 2.1.23 2.1.24 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 5.0.0 5.0.1 5.0.2

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 1.0.16 1.1.13 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9 2.1.10 2.1.11 2.1.12 2.1.13 2.1.14 2.1.15 2.1.16 2.1.17 2.1.18 2.1.19 2.1.20 2.1.21 2.1.22 2.1.23 2.1.24 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 5.0.0 5.0.1 5.0.2

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.0 3.1.1 3.1.2 3.1.3 3.1.4 3.1.5 3.1.6 3.1.7 3.1.8 3.1.9 3.1.10 3.1.11 5.0.0 5.0.1 5.0.2

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.6.1 4.6.2 4.7 4.7.1 4.7.2 4.8

### PowerShell Tools
- PowerShell 7.1.1

#### Azure Powershell Modules
| Module  | Version                                                                                         | Path                           |
| ------- | ----------------------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 1.0.0<br>1.6.0<br>2.3.2<br>2.6.0<br>3.1.0<br>3.5.0<br>3.8.0<br>4.3.0<br>4.4.0<br>4.6.0<br>4.7.0 | C:\Modules\az_\<version\>      |
| Azure   | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>5.3.0                                           | C:\Modules\azure_\<version\>   |
| AzureRM | 2.1.0 [Installed]<br>3.8.0<br>4.2.1<br>5.1.1<br>6.7.0<br>6.13.1                                 | C:\Modules\azurerm_\<version\> |
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
| Pester             | 3.4.0<br>5.1.1   |
| PowerShellGet      | 1.0.0.1<br>2.2.5 |
| PSWindowsUpdate    | 2.2.0.2          |
| SqlServer          | 21.1.18235       |
| VSSetup            | 2.2.16           |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 3.0                                                                                                                                                                                                                                                                                   |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3<br>22.0.1<br>21.1.2<br>20.0.0<br>19.1.0 |
| Android SDK Platforms      | android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)<br>android-22 (rev 2)<br>android-21 (rev 2)<br>android-20 (rev 2)<br>android-19 (rev 4)                  |
| Android SDK Platform-Tools | 30.0.5                                                                                                                                                                                                                                                                                |
| Android SDK Tools          | 25.2.5                                                                                                                                                                                                                                                                                |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                |
| CMake                      | 3.10.2<br>3.6.4111459                                                                                                                                                                                                                                                                 |
| Google APIs                | addon-g..._apis-google-21<br>addon-g..._apis-google-22<br>addon-g..._apis-google-23<br>addon-g..._apis-google-24<br>a...google_apis                                                                                                                                                   |
| Google Play services       | 49                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                    |
| NDK                        | 21.4.7075529<br>22.0.7026061                                                                                                                                                                                                                                                          |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                     |

#### Environment variables
| Name                    | Value                                                                        |
| ----------------------- | ---------------------------------------------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                                                       |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\22.0.7026061                                      |
| ANDROID_NDK_PATH        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                                                       |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2016  | sha256:a9788334a8de8d1f3c099252e7894e7606dcc70101674bd89324fa434fbdf002  | 2021-01-12 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2016 | sha256:07a9ff94ca6ebe868a7b39d65ab6a14ac8bb362cb7b0699db4c92a7f7b01b081  | 2021-01-12 |
| mcr.microsoft.com/windows/servercore:ltsc2016                             | sha256:dba071bba037bd9f04e3d2c8f1412b78f7578b81aab4791f7a3efdbda5a7b667  | 2021-01-07 |
| microsoft/aspnetcore-build:1.0-2.0                                        | sha256:9ecc7c5a8a7a11dca5f08c860165646cb30d084606360a3a72b9cbe447241c0c  | 2018-08-15 |
| mcr.microsoft.com/windows/nanoserver:10.0.14393.953                       | sha256:fc60bd5ae0e61b334ce1cf1bcbf20c10c36b4c5482a01da319c9c989f9e6e268  | 2017-03-08 |



