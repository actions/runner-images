| Announcements |
|-|
| [(Public Beta) Windows Server 2022 with Visual Studio 2022 is now available](https://github.com/actions/virtual-environments/issues/3949) |
***
# Microsoft Windows Server 2016 Datacenter
- OS Version: 10.0.14393 Build 4583
- Image Version: 20210914.2

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.15.15
- Julia 1.6.2
- Kotlin 1.5.20
- Node 14.17.6
- Perl 5.32.1
- PHP 8.0.10
- Python 3.7.9
- Ruby 2.5.9p229

### Package Management
- Chocolatey 0.11.1
- Composer 2.1.7
- Helm 3.6.3
- Miniconda 4.10.3 (pre-installed on the image but not added to PATH)
- NPM 6.14.15
- NuGet 5.11.0.10
- pip 21.2.4 (python 3.7)
- Pipx 0.16.4
- RubyGems 2.7.6.3
- Vcpkg  (build from master \<e201002>)
- Yarn 1.22.11

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.11
- Gradle 7.2
- Maven 3.8.2
- sbt 1.5.5

### Tools
- 7zip 19.00
- aria2 1.36.0
- azcopy 10.12.1
- Bazel 4.2.1
- Bazelisk 1.10.1
- Bicep 0.4.613
- Cabal 3.4.0.0
- CMake 3.21.2
- CodeQL Action Bundle 2.6.1
- Docker 20.10.7
- Docker-compose 1.29.2
- ghc 9.0.1
- Git 2.33.0
- Git LFS 2.13.3
- Google Cloud SDK 357.0.0
- GVFS 1.0.21085.9
- InnoSetup 6.2.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.22.1
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.3.0
- NSIS v3.06.1
- OpenSSL 1.1.1
- Packer 1.7.4
- Pulumi v3.12.0
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
- AWS CLI 2.2.37
- AWS SAM CLI 1.31.0
- AWS Session Manager CLI 1.2.245.0
- Azure CLI 2.28.0
- Azure DevOps CLI extension 0.20.0
- Cloud Foundry CLI 6.53.0
- GitHub CLI 2.0.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.55.0
- Rust 1.55.0
- Rustdoc 1.55.0
- Rustup 1.24.3

#### Packages
- bindgen 0.59.1
- cargo-audit 0.15.2
- cargo-outdated v0.9.17
- cbindgen 0.20.0
- Clippy 0.1.55
- Rustfmt 1.4.37

### Browsers and webdrivers
- Google Chrome 93.0.4577.82
- Chrome Driver 93.0.4577.63
- Microsoft Edge 93.0.961.47
- Microsoft Edge Driver 93.0.961.47
- Mozilla Firefox 92.0
- Gecko Driver 0.29.1
- IE Driver 3.150.1.1

#### Environment variables
| Name            | Value                              |
| --------------- | ---------------------------------- |
| CHROMEWEBDRIVER | C:\SeleniumWebDrivers\ChromeDriver |
| EDGEWEBDRIVER   | C:\SeleniumWebDrivers\EdgeDriver   |
| GECKOWEBDRIVER  | C:\SeleniumWebDrivers\GeckoDriver  |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.302+8 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.12+7           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 13.0.2+8.1          | Adopt OpenJDK   | JAVA_HOME_13_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |

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
| 1.13.15 | x64          | GOROOT_1_13_X64      |
| 1.14.15 | x64          | GOROOT_1_14_X64      |
| 1.15.15 (Default) | x64          | GOROOT_1_15_X64      |
| 1.16.8  | x64          | GOROOT_1_16_X64      |
| 1.17.1  | x64          | GOROOT_1_17_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 10.24.1 | x64          |
| 12.22.6 | x64          |
| 14.17.6 | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 2.7.18  | x64, x86     |
| 3.5.4   | x64, x86     |
| 3.6.8   | x64, x86     |
| 3.7.9 (Default) | x64, x86     |
| 3.8.10  | x64, x86     |
| 3.9.7   | x64, x86     |


#### Ruby
| Version | Architecture |
| ------- | ------------ |
| 2.4.10  | x64          |
| 2.5.9 (Default) | x64          |
| 2.6.8   | x64          |
| 2.7.4   | x64          |
| 3.0.2   | x64          |


#### PyPy
| Python Version | PyPy Version |
| -------------- | ------------ |
| 2.7.18         | PyPy 7.3.5 with MSC v.1927 64 bit (AMD64) |
| 3.6.12         | PyPy 7.3.3 with MSC v.1927 32 bit |
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
- Azure CosmosDb Emulator 2.14.3.0
- DacFx 15.0.5164.1
- MySQL 5.7.35.0
- SQLPS 1.0


### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.48  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.21.3  | C:\tools\nginx-1.21.3\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2017
| Name                          | Version         | Path                                                           |
| ----------------------------- | --------------- | -------------------------------------------------------------- |
| Visual Studio Enterprise 2017 | 15.9.28307.1622 | C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise |

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
| Microsoft.Component.CookiecutterTools                                     | 15.9.28307.1500  |
| Microsoft.Component.MSBuild                                               | 15.7.27520.0     |
| Microsoft.Component.NetFX.Core.Runtime                                    | 15.0.26208.0     |
| Microsoft.Component.NetFX.Native                                          | 15.0.26208.0     |
| Microsoft.Component.PythonTools                                           | 15.9.28307.1500  |
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
| Microsoft.Net.Core.Component.SDK.2.1                                      | 15.9.28307.1439  |
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
| Microsoft.VisualStudio.Component.DockerTools                              | 15.9.28307.1439  |
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
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 15.9.28307.1439  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC                              | 15.9.28307.102   |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 15.9.28307.102   |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 15.7.27625.0     |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 15.9.28219.51    |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 15.8.27729.1     |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 15.8.27825.0     |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 15.8.27729.1     |
| Microsoft.VisualStudio.Web.Mvc4.ComponentGroup                            | 15.6.27406.0     |
| Microsoft.VisualStudio.Workload.Azure                                     | 15.9.28307.1439  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 15.0.27205.0     |
| Microsoft.VisualStudio.Workload.Data                                      | 15.9.28307.1439  |
| Microsoft.VisualStudio.Workload.DataScience                               | 15.9.28307.421   |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 15.9.28307.1062  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 15.0.27005.2     |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 15.0.27205.0     |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 15.9.28307.102   |
| Microsoft.VisualStudio.Workload.NativeGame                                | 15.9.28307.102   |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 15.9.28107.0     |
| Microsoft.VisualStudio.Workload.NetCoreTools                              | 15.8.27906.1     |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 15.9.28107.0     |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 15.9.28307.1439  |
| Microsoft.VisualStudio.Workload.Node                                      | 15.9.28107.0     |
| Microsoft.VisualStudio.Workload.Office                                    | 15.9.28307.1439  |
| Microsoft.VisualStudio.Workload.Python                                    | 15.9.28307.1500  |
| Microsoft.VisualStudio.Workload.Universal                                 | 15.9.28307.1439  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 15.7.27625.0     |
| Microsoft.VisualStudio.Workload.WebCrossPlat                              | 15.9.28307.341   |
| SSDT Microsoft Analysis Services Projects                                 | 2.9.6            |
| SSDT Microsoft Reporting Services Projects                                | 2.6              |
| SSDT SQL Server Integration Services Projects                             | 2.6.3            |
| Windows Driver Kit                                                        | 10.0.17740.0     |
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
| Microsoft Visual C++ 2019 Additional Runtime | x64          | 14.29.30133 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x64          | 14.29.30133 |
| Microsoft Visual C++ 2019 Additional Runtime | x86          | 14.29.30133 |
| Microsoft Visual C++ 2019 Minimum Runtime    | x86          | 14.29.30133 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 1.1.14 2.1.302 2.1.403 2.1.525 2.1.526 2.1.617 2.1.701 2.1.818 3.1.118 3.1.202 3.1.302 3.1.412 5.0.104 5.0.206 5.0.303 5.0.400

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.All`
- 2.1.2 2.1.5 2.1.12 2.1.24 2.1.29 2.1.30

`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 2.1.2 2.1.5 2.1.12 2.1.24 2.1.29 2.1.30 3.1.4 3.1.6 3.1.18 5.0.4 5.0.9

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 1.0.16 1.1.13 2.1.2 2.1.5 2.1.12 2.1.24 2.1.29 2.1.30 3.1.4 3.1.6 3.1.18 5.0.4 5.0.9

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.18 5.0.4 5.0.9

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.6.1 4.6.2 4.7 4.7.1 4.7.2 4.8

### PowerShell Tools
- PowerShell 7.1.4

#### Azure Powershell Modules
| Module  | Version                                                                                                                                                           | Path                           |
| ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 1.0.0.zip<br>1.6.0.zip<br>2.3.2.zip<br>2.6.0.zip<br>3.1.0.zip<br>3.5.0.zip<br>3.8.0.zip<br>4.3.0.zip<br>4.4.0.zip<br>4.7.0.zip<br>5.5.0.zip<br>5.9.0.zip<br>6.4.0 | C:\Modules\az_\<version\>      |
| Azure   | 2.1.0 [Installed]<br>3.8.0.zip<br>4.2.1.zip<br>5.1.1.zip<br>5.3.0                                                                                                 | C:\Modules\azure_\<version\>   |
| AzureRM | 2.1.0 [Installed]<br>3.8.0.zip<br>4.2.1.zip<br>5.1.1.zip<br>6.7.0.zip<br>6.13.1                                                                                   | C:\Modules\azurerm_\<version\> |
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
| Package Name               | Version                                                                                                                                                                                                                                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3<br>22.0.1<br>21.1.2<br>20.0.0<br>19.1.0 |
| Android SDK Platforms      | android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)<br>android-22 (rev 2)<br>android-21 (rev 2)<br>android-20 (rev 2)<br>android-19 (rev 4)      |
| Android SDK Platform-Tools | 31.0.3                                                                                                                                                                                                                                                                                          |
| Android SDK Tools          | 25.2.5                                                                                                                                                                                                                                                                                          |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                          |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                                                                |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                                        |
| Google Play services       | 49                                                                                                                                                                                                                                                                                              |
| Google Repository          | 58                                                                                                                                                                                                                                                                                              |
| NDK                        | 21.4.7075529<br>22.1.7171670                                                                                                                                                                                                                                                                    |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                               |

#### Environment variables
| Name                    | Value                                                                        |
| ----------------------- | ---------------------------------------------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                                                       |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\22.1.7171670                                      |
| ANDROID_NDK_PATH        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk-bundle -> C:\Android\android-sdk\ndk\21.4.7075529 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                                                       |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2016  | sha256:1337170239cc81ea287e70fc5092e860183c7ebcbc34b01c84f5c65e98ccf89f  | 2021-08-10 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2016 | sha256:e3788091ce9cb0e75c6a880d02fdb5057da8a922cefb9516d0e437a877501edb  | 2021-08-10 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2016     | sha256:6a37ef7cd6367bf53c9f71f1b0221efb90d7f34f1d91b50ce7254e6b7de8007a  | 2021-08-10 |
| mcr.microsoft.com/windows/nanoserver:10.0.14393.953                       | sha256:fc60bd5ae0e61b334ce1cf1bcbf20c10c36b4c5482a01da319c9c989f9e6e268  | 2017-03-08 |
| mcr.microsoft.com/windows/servercore:ltsc2016                             | sha256:ac71e33f27c2a6b5db30be0419458e0c4e926214bc9c85afd4d6d6f9028d7233  | 2021-08-01 |



