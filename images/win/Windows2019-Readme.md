| Announcements |
|-|
| [[all OSs] Default Nodejs version will be set to 16 on November, 29](https://github.com/actions/virtual-environments/issues/4446) |
| [[all OSs] Selenium server version will be upgraded from 3 to 4 on November, 15](https://github.com/actions/virtual-environments/issues/4376) |
| [[All OSs] Node.js version 10 will be removed from the images on November, 15](https://github.com/actions/virtual-environments/issues/4356) |
| [Windows-2016 environment will be removed on March 15, 2022](https://github.com/actions/virtual-environments/issues/4312) |
| [[All OSs] Go versions less than 1.15 will be removed on November, 8](https://github.com/actions/virtual-environments/issues/4311) |
| [(Public Beta) Windows Server 2022 with Visual Studio 2022 is now available](https://github.com/actions/virtual-environments/issues/3949) |
***
# Microsoft Windows Server 2019 Datacenter
- OS Version: 10.0.17763 Build 2300
- Image Version: 20211110.1

## Enabled windows optional features
- Windows Subsystem for Linux [WSLv1]

## Installed Software
### Language and Runtime
- Bash 4.4.23(1)-release
- Go 1.15.15
- Julia 1.6.3
- Kotlin 1.5.31
- LLVM 13.0.0
- Node 14.18.1
- Perl 5.32.1
- PHP 8.0.10
- Python 3.7.9
- Ruby 2.5.9p229

### Package Management
- Chocolatey 0.11.3
- Composer 2.1.12
- Helm 3.7.1
- Miniconda 4.10.3 (pre-installed on the image but not added to PATH)
- NPM 6.14.15
- NuGet 6.0.0.280
- pip 21.3.1 (python 3.7)
- Pipx 0.16.4
- RubyGems 2.7.6.3
- Vcpkg  (build from master \<70033db>)
- Yarn 1.22.17

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.12
- Gradle 7.2
- Maven 3.8.3
- sbt 1.5.5

### Tools
- 7zip 19.00
- aria2 1.36.0
- azcopy 10.13.0
- Bazel 4.2.1
- Bazelisk 1.10.1
- Bicep 0.4.1008
- Cabal 3.6.2.0
- CMake 3.21.4
- CodeQL Action Bundle 2.7.0
- Docker 20.10.7
- Docker-compose 1.29.2
- ghc 9.2.1
- Git 2.33.1
- Git LFS 3.0.1
- Google Cloud SDK 364.0.0
- InnoSetup 6.2.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.22.3
- Mercurial 5.0
- Mingw-w64 8.1.0
- Newman 5.3.0
- NSIS v3.06.1
- OpenSSL 1.1.1
- Packer 1.7.6
- Pulumi v3.17.1
- R 4.1.2
- Stack 2.7.3
- Subversion (SVN) 1.14.1
- Swig 4.0.2
- VSWhere 2.8.4
- WinAppDriver 1.2.2009.02003
- yamllint 1.26.3
- zstd 1.5.0

### CLI Tools
- Alibaba Cloud CLI 3.0.99
- AWS CLI 2.3.5
- AWS SAM CLI 1.35.0
- AWS Session Manager CLI 1.2.279.0
- Azure CLI 2.30.0
- Azure DevOps CLI extension 0.22.0
- Cloud Foundry CLI 6.53.0
- GitHub CLI 2.2.0
- Hub CLI 2.14.2

### Rust Tools
- Cargo 1.56.0
- Rust 1.56.1
- Rustdoc 1.56.1
- Rustup 1.24.3

#### Packages
- bindgen 0.59.1
- cargo-audit 0.15.2
- cargo-outdated v0.9.18
- cbindgen 0.20.0
- Clippy 0.1.56
- Rustfmt 1.4.37

### Browsers and webdrivers
- Google Chrome 95.0.4638.69
- Chrome Driver 95.0.4638.69
- Microsoft Edge 95.0.1020.44
- Microsoft Edge Driver 95.0.1020.44
- Mozilla Firefox 94.0.1
- Gecko Driver 0.30.0
- IE Driver 3.150.1.1
- Selenium server 3.141.59

#### Environment variables
| Name              | Value                                      |
| ----------------- | ------------------------------------------ |
| CHROMEWEBDRIVER   | C:\SeleniumWebDrivers\ChromeDriver         |
| EDGEWEBDRIVER     | C:\SeleniumWebDrivers\EdgeDriver           |
| GECKOWEBDRIVER    | C:\SeleniumWebDrivers\GeckoDriver          |
| SELENIUM_JAR_PATH | C:\selenium\selenium-server-standalone.jar |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.312+7 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.13+8           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 13.0.2+8.1          | Adopt OpenJDK   | JAVA_HOME_13_X64     |
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
### BizTalk Server
- BizTalk Server Project Build Component 3.13.765.0 
### Cached Tools
#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.15.15 (Default) | x64          | GOROOT_1_15_X64      |
| 1.16.10 | x64          | GOROOT_1_16_X64      |
| 1.17.3  | x64          | GOROOT_1_17_X64      |


#### Node
| Version | Architecture |
| ------- | ------------ |
| 10.24.1 | x64          |
| 12.22.7 | x64          |
| 14.18.1 | x64          |
| 16.13.0 | x64          |


#### Python
| Version | Architecture |
| ------- | ------------ |
| 2.7.18  | x64, x86     |
| 3.5.4   | x64, x86     |
| 3.6.8   | x64, x86     |
| 3.7.9 (Default) | x64, x86     |
| 3.8.10  | x64, x86     |
| 3.9.8   | x64, x86     |
| 3.10.0  | x64, x86     |


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
| 2.7.18         | PyPy 7.3.6 with MSC v.1929 64 bit (AMD64) |
| 3.6.12         | PyPy 7.3.3 with MSC v.1927 32 bit |
| 3.7.12         | PyPy 7.3.7 with MSC v.1929 64 bit (AMD64) |
| 3.8.12         | PyPy 7.3.7 with MSC v.1929 64 bit (AMD64) |



### Databases
#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.0                                                                                                                                 |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |


#### MongoDB
| Version | ServiceName | ServiceStatus | ServiceStartType |
| ------- | ----------- | ------------- | ---------------- |
| 5.1.0.0 | MongoDB     | Running       | Automatic        |



### Database tools
- Azure CosmosDb Emulator 2.14.4.0
- DacFx 15.0.5282.3
- MySQL 5.7.35.0
- SQLPS 1.0


### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.51  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.21.4  | C:\tools\nginx-1.21.4\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2019
| Name                          | Version         | Path                                                           |
| ----------------------------- | --------------- | -------------------------------------------------------------- |
| Visual Studio Enterprise 2019 | 16.11.31829.152 | C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise |

#### Workloads, components and extensions:

| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| Component.Android.NDK.R16B                                                | 16.11.31827.77  |
| Component.Android.SDK25.Private                                           | 16.0.28625.61   |
| Component.Android.SDK30                                                   | 16.10.31205.252 |
| Component.Ant                                                             | 1.9.3.8         |
| Component.Dotfuscator                                                     | 16.10.31205.252 |
| Component.Linux.CMake                                                     | 16.2.29003.222  |
| Component.MDD.Android                                                     | 16.0.28517.75   |
| Component.MDD.Linux                                                       | 16.5.29515.121  |
| Component.MDD.Linux.GCC.arm                                               | 16.5.29515.121  |
| Component.Microsoft.VisualStudio.LiveShare                                | 1.0.4438        |
| Component.Microsoft.VisualStudio.RazorExtension                           | 16.10.31205.252 |
| Component.Microsoft.VisualStudio.Tools.Applications                       | 16.0.31110.1    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 16.10.31205.252 |
| Component.Microsoft.Web.LibraryManager                                    | 16.10.31205.180 |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 0.7.22.39845    |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.21381.0    |
| Component.OpenJDK                                                         | 16.11.31827.77  |
| Component.UnityEngine.x64                                                 | 16.10.31205.252 |
| Component.Unreal                                                          | 16.1.28810.153  |
| Component.Unreal.Android                                                  | 16.1.28810.153  |
| Component.VSInstallerProjects                                             | 1.0.0           |
| Component.WixToolset.VisualStudioExtension.Dev16                          | 1.0.0.4         |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.4         |
| Component.WixToolset.VisualStudioExtension.Schemas4                       | 1.0.0.4         |
| Component.Xamarin                                                         | 16.10.31205.252 |
| Component.Xamarin.RemotedSimulator                                        | 16.10.31205.252 |
| Microsoft.Component.Azure.DataLake.Tools                                  | 16.10.31205.252 |
| Microsoft.Component.ClickOnce                                             | 16.11.31603.221 |
| Microsoft.Component.MSBuild                                               | 16.5.29515.121  |
| Microsoft.Component.NetFX.Native                                          | 16.5.29515.121  |
| Microsoft.Component.PythonTools                                           | 16.11.31314.313 |
| Microsoft.Component.PythonTools.Miniconda                                 | 16.11.31314.313 |
| Microsoft.Component.PythonTools.Web                                       | 16.10.31205.252 |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 16.0.28625.61   |
| Microsoft.ComponentGroup.Blend                                            | 16.0.28315.86   |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 16.11.31603.221 |
| Microsoft.Net.Component.3.5.DeveloperTools                                | 16.0.28517.75   |
| Microsoft.Net.Component.4.5.1.TargetingPack                               | 16.11.31605.320 |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 16.0.28517.75   |
| Microsoft.Net.Component.4.5.TargetingPack                                 | 16.11.31605.320 |
| Microsoft.Net.Component.4.6.1.TargetingPack                               | 16.0.28517.75   |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 16.0.28517.75   |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 16.0.28517.75   |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 16.10.31205.252 |
| Microsoft.Net.Component.4.7.2.SDK                                         | 16.4.29409.204  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 16.10.31205.252 |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 16.10.31205.252 |
| Microsoft.Net.Component.4.8.SDK                                           | 16.4.29313.120  |
| Microsoft.Net.Component.4.TargetingPack                                   | 16.11.31605.320 |
| Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools                         | 16.3.29207.166  |
| Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools                         | 16.3.29207.166  |
| Microsoft.Net.ComponentGroup.4.7.DeveloperTools                           | 16.3.29207.166  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 16.3.29207.166  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 16.0.28516.191  |
| Microsoft.NetCore.Component.DevelopmentTools                              | 16.10.31303.231 |
| Microsoft.NetCore.Component.Runtime.3.1                                   | 16.11.31828.110 |
| Microsoft.NetCore.Component.Runtime.5.0                                   | 16.11.31828.110 |
| Microsoft.NetCore.Component.SDK                                           | 16.11.31828.110 |
| Microsoft.NetCore.Component.Web                                           | 16.10.31303.231 |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 16.11.31827.77  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 16.11.31827.77  |
| Microsoft.VisualStudio.Component.Azure.Kubernetes.Tools                   | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Azure.Powershell                         | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 16.4.29409.204  |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.Azure.Storage.AzCopy                     | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.Azure.Storage.Emulator                   | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 16.0.28528.71   |
| Microsoft.VisualStudio.Component.CloudExplorer                            | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.CodeMap                                  | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 16.4.29409.204  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 16.1.28811.260  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.Debugger.Snapshot                        | 16.5.29813.82   |
| Microsoft.VisualStudio.Component.Debugger.TimeTravel                      | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.DockerTools                              | 16.4.29409.204  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.DslTools                                 | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.EntityFramework                          | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.FSharp                                   | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 16.3.29207.166  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.Graphics                                 | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.IISExpress                               | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.IntelliCode                              | 16.11.31603.221 |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 16.11.31404.150 |
| Microsoft.VisualStudio.Component.LinqToSql                                | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 16.4.29318.151  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 16.10.31205.180 |
| Microsoft.VisualStudio.Component.Merq                                     | 16.2.29012.281  |
| Microsoft.VisualStudio.Component.MonoDebugger                             | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 16.0.28707.177  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.NuGet                                    | 16.1.28829.92   |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 16.1.28829.92   |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 16.0.28714.129  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 16.4.29409.204  |
| Microsoft.VisualStudio.Component.SQL.ADAL                                 | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 16.3.29207.166  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 16.4.29409.204  |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 16.0.28327.66   |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.TextTemplating                           | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.TypeScript.4.3                           | 16.0.31506.151  |
| Microsoft.VisualStudio.Component.Unity                                    | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 16.3.29207.166  |
| Microsoft.VisualStudio.Component.VC.14.25.x86.x64                         | 16.11.31317.239 |
| Microsoft.VisualStudio.Component.VC.140                                   | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 16.5.29721.120  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 16.5.29721.120  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 16.3.29103.31   |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 16.11.31603.221 |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 16.3.29207.166  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 16.5.29721.120  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 16.4.29313.120  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 16.5.29721.120  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 16.11.31317.239 |
| Microsoft.VisualStudio.Component.VC.v141.ARM                              | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.v141.ARM.Spectre                      | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.v141.ARM64                            | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.v141.ARM64.Spectre                    | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VC.v141.ATL                              | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM.Spectre                  | 16.5.29721.120  |
| Microsoft.VisualStudio.Component.VC.v141.ATL.ARM64.Spectre                | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.ATL.Spectre                      | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.MFC                              | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM.Spectre                  | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.MFC.ARM64.Spectre                | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.MFC.Spectre                      | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64                          | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.VC.v141.x86.x64.Spectre                  | 16.5.29515.121  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 16.0.28315.86   |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 16.0.28625.61   |
| Microsoft.VisualStudio.Component.Web                                      | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.WebDeploy                                | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 16.4.29409.204  |
| Microsoft.VisualStudio.Component.Windows10SDK.16299                       | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Windows10SDK.17134                       | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Windows10SDK.17763                       | 16.0.28517.75   |
| Microsoft.VisualStudio.Component.Windows10SDK.18362                       | 16.1.28829.92   |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Windows10SDK.20348                       | 16.11.31603.221 |
| Microsoft.VisualStudio.Component.Windows11SDK.22000                       | 16.11.31727.170 |
| Microsoft.VisualStudio.Component.WinXP                                    | 16.10.31205.252 |
| Microsoft.VisualStudio.Component.Workflow                                 | 16.0.28315.86   |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 16.0.28621.142  |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 16.10.31303.231 |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 16.0.28528.71   |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 16.2.29012.281  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 16.11.31603.221 |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 16.3.29102.218  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Support                         | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC                              | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v141                         | 16.1.28810.153  |
| Microsoft.VisualStudio.ComponentGroup.UWP.Xamarin                         | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.Web.Client                          | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 16.10.31205.180 |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.Azure                                     | 16.11.31503.43  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.Data                                      | 16.0.28720.110  |
| Microsoft.VisualStudio.Workload.DataScience                               | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 16.10.31303.231 |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 16.11.31727.170 |
| Microsoft.VisualStudio.Workload.NativeGame                                | 16.11.31727.170 |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.NetCoreTools                              | 16.10.31303.231 |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 16.10.31303.231 |
| Microsoft.VisualStudio.Workload.Node                                      | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.Office                                    | 16.10.31205.180 |
| Microsoft.VisualStudio.Workload.Python                                    | 16.10.31303.231 |
| Microsoft.VisualStudio.Workload.Universal                                 | 16.11.31727.170 |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 16.10.31205.180 |
| ms-biztalk.BizTalk                                                        | 3.13.2.0        |
| ProBITools.MicrosoftAnalysisServicesModelingProjects                      | 2.9.18          |
| ProBITools.MicrosoftReportProjectsforVisualStudio                         | 2.6.11          |
| SSIS.SqlServerIntegrationServicesProjects                                 | 3.15            |
| VisualStudioClient.MicrosoftVisualStudio2017InstallerProjects             | 1.0.0           |
| Windows Driver Kit                                                        | 10.0.21381.0    |
| Windows Driver Kit Visual Studio Extension                                | 10.1.22000.1    |
| Windows Software Development Kit Extension                                | 10.1.22000.194  |
| WIX Toolset                                                               | 3.11.4516       |
| WIX Toolset Studio 2019 Extension                                         | 1.0.0.4         |

#### Microsoft Visual C++:

| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2010 Redistributable    | x64          | 10.0.40219  |
| Microsoft Visual C++ 2010 Redistributable    | x86          | 10.0.40219  |
| Microsoft Visual C++ 2012 Additional Runtime | x64          | 11.0.61030  |
| Microsoft Visual C++ 2012 Minimum Runtime    | x64          | 11.0.61030  |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Additional Runtime | x86          | 12.0.21005  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x86          | 12.0.21005  |
| Microsoft Visual C++ 2019 Debug Runtime      | x64          | 14.29.30135 |
| Microsoft Visual C++ 2019 Debug Runtime      | x86          | 14.29.30135 |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.30.30704 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.30.30704 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.30.30704 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.30.30704 |

### .NET Core SDK
`Location C:\Program Files\dotnet\sdk`
- 2.1.302 2.1.403 2.1.526 2.1.617 2.1.701 2.1.818 3.1.120 3.1.202 3.1.302 3.1.415 5.0.104 5.0.209 5.0.303 5.0.403

### .NET Core Runtime
`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.All`
- 2.1.2 2.1.5 2.1.12 2.1.24 2.1.30

`Location: C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App`
- 2.1.2 2.1.5 2.1.12 2.1.24 2.1.30 3.1.4 3.1.6 3.1.20 3.1.21 5.0.4 5.0.9 5.0.12

`Location: C:\Program Files\dotnet\shared\Microsoft.NETCore.App`
- 2.1.2 2.1.5 2.1.12 2.1.24 2.1.30 3.1.4 3.1.6 3.1.20 3.1.21 5.0.4 5.0.9 5.0.12

`Location: C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App`
- 3.1.4 3.1.6 3.1.20 3.1.21 5.0.4 5.0.9 5.0.12

### .NET Framework
`Type: Developer Pack`
`Location C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX <version> Tools`
- 4.7.2 4.8

### PowerShell Tools
- PowerShell 7.2.0

#### Azure Powershell Modules
| Module  | Version                                                                                                                                                           | Path                           |
| ------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ |
| Az      | 1.0.0.zip<br>1.6.0.zip<br>2.3.2.zip<br>2.6.0.zip<br>3.1.0.zip<br>3.5.0.zip<br>3.8.0.zip<br>4.3.0.zip<br>4.4.0.zip<br>4.7.0.zip<br>5.5.0.zip<br>5.9.0.zip<br>6.5.0 | C:\Modules\az_\<version\>      |
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
| Microsoft.Graph    | 1.8.0            |
| Pester             | 3.4.0<br>5.3.1   |
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
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                                          |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                          |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                                                                |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                                        |
| Google Play services       | 49                                                                                                                                                                                                                                                                                              |
| Google Repository          | 58                                                                                                                                                                                                                                                                                              |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.1.7779620                                                                                                                                                                                                                                          |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                               |

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
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019  | sha256:a58fa6b269980877f4c5681df79c816bbe2b220b84819224b1445d13a8b3b15e  | 2021-11-09 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019 | sha256:d7f06d8eb2e6f45b20d293a5a5a48611a26bf6eac444e6c3284f04edc1ab6b9e  | 2021-11-09 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2019     | sha256:f1915874869d31d4ba9002478809248b7661937d28a01156b12e4c72558ec8f2  | 2021-11-09 |
| mcr.microsoft.com/windows/nanoserver:1809                                 | sha256:3c0ca16693dfc1252120cb6066ddfccf53b9bbce4523bdb7c7fb3f55dd86f33f  | 2021-11-04 |
| mcr.microsoft.com/windows/servercore:ltsc2019                             | sha256:bfa356b928c9977bf2c03d536e251eda8879debf42d884771cb855313a6a5da7  | 2021-11-04 |



