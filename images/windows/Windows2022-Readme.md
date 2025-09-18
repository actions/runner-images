| Announcements |
|-|
| [[Windows, Ubuntu] CMake will be upgraded to latest version on September 15](https://github.com/actions/runner-images/issues/12958) |
| [[Ubuntu & Windows] Four tools scheduled for deprecation on November 3, 2025](https://github.com/actions/runner-images/issues/12898) |
| [Windows-latest workflows will use Windows Server 2025 image in GH](https://github.com/actions/runner-images/issues/12677) |
| [[Windows-2022] Openssl version will be updated to version 3.5.2 on 2025-10-10](https://github.com/actions/runner-images/issues/12676) |
| [[Windows 2022] MongoDB 5.x version will be removed from Windows 2022 image on 2025-09-08 and will be updated to 7.x version.](https://github.com/actions/runner-images/issues/12640) |
***
# Windows Server 2022
- OS Version: 10.0.20348 Build 4052
- Image Version: 20250907.29.1

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.2.37(1)-release
- Go 1.24.7
- Julia 1.11.6
- Kotlin 2.2.10
- LLVM 20.1.8
- Node 20.19.5
- Perl 5.32.1
- PHP 8.4.11
- Python 3.9.13
- Ruby 3.3.9

### Package Management
- Chocolatey 2.5.1
- Composer 2.8.11
- Helm 3.18.6
- Miniconda 25.7.0 (pre-installed on the image but not added to PATH)
- NPM 10.8.2
- NuGet 6.14.0.116
- pip 25.2 (python 3.9)
- Pipx 1.7.1
- RubyGems 3.5.22
- Vcpkg (build from commit b1e15efef6)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.15
- Gradle 9.0
- Maven 3.9.11
- sbt 1.11.6

### Tools
- 7zip 25.01
- aria2 1.37.0
- azcopy 10.30.0
- Bazel 8.4.0
- Bazelisk 1.26.0
- Bicep 0.37.4
- Cabal 3.16.0.0
- CMake 3.31.6
- CodeQL Action Bundle 2.23.0
- Docker 27.5.1
- Docker Compose v2 2.32.2
- Docker-wincred 0.9.3
- ghc 9.12.2
- Git 2.51.0.windows.1
- Git LFS 3.7.0
- ImageMagick 7.1.2-3
- InnoSetup 6.4.0
- jq 1.8.1
- Kind 0.30.0
- Kubectl 1.34.0
- Mercurial 6.3.1
- gcc 12.2.0
- gdb 11.2
- GNU Binutils 2.39
- Newman 6.2.1
- NSIS 3.10
- OpenSSL 1.1.1w
- Packer 1.12.0
- Pulumi 3.193.0
- R 4.4.2
- Service Fabric SDK 10.1.2493.9590
- Stack 3.7.1
- Subversion (SVN) 1.14.5
- Swig 4.1.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.37.1
- zstd 1.5.7
- Ninja 1.13.1

### CLI Tools
- Alibaba Cloud CLI 3.0.300
- AWS CLI 2.28.25
- AWS SAM CLI 1.143.0
- AWS Session Manager CLI 1.2.707.0
- Azure CLI 2.77.0
- Azure DevOps CLI extension 1.0.2
- GitHub CLI 2.78.0

### Rust Tools
- Cargo 1.89.0
- Rust 1.89.0
- Rustdoc 1.89.0
- Rustup 1.28.2

#### Packages
- bindgen 0.72.1
- cargo-audit 0.21.2
- cargo-outdated 0.17.0
- cbindgen 0.29.0
- Clippy 0.1.89
- Rustfmt 1.8.0

### Browsers and Drivers
- Google Chrome 140.0.7339.81
- Chrome Driver 140.0.7339.80
- Microsoft Edge 140.0.3485.54
- Microsoft Edge Driver 140.0.3485.54
- Mozilla Firefox 142.0.1
- Gecko Driver 0.36.0
- IE Driver 4.14.0.0
- Selenium server 4.35.0

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
| 8.0.462+8 (default) | JAVA_HOME_8_X64      |
| 11.0.28+6           | JAVA_HOME_11_X64     |
| 17.0.16+8           | JAVA_HOME_17_X64     |
| 21.0.8+9.0          | JAVA_HOME_21_X64     |

### Shells
| Name          | Target                            |
| ------------- | --------------------------------- |
| gitbash.exe   | C:\Program Files\Git\bin\bash.exe |
| msys2bash.cmd | C:\msys64\usr\bin\bash.exe        |
| wslbash.exe   | C:\Windows\System32\bash.exe      |

### MSYS2
- Pacman 6.1.0

#### Notes
```
Location: C:\msys64

Note: MSYS2 is pre-installed on image but not added to PATH.
```

### Cached Tools

#### Go
- 1.22.12
- 1.23.12
- 1.24.7

#### Node.js
- 18.20.8
- 20.19.5
- 22.19.0

#### Python
- 3.9.13
- 3.10.11
- 3.11.9
- 3.12.10
- 3.13.7

#### PyPy
- 2.7.18 [PyPy 7.3.20]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.1.7
- 3.2.9
- 3.3.9
- 3.4.5

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| ServiceName          | postgresql-x64-14                                                                                                                    |
| Version              | 14.19                                                                                                                                |
| ServiceStatus        | Stopped                                                                                                                              |
| ServiceStartType     | Disabled                                                                                                                             |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\Program Files\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                                       |
| UserName             | postgres                                                                                                                             |
| Password             | root                                                                                                                                 |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 5.0.31.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.25.0
- DacFx 170.1.61.1
- MySQL 8.0.43.0
- SQL OLEDB Driver 18.7.4.0
- SQLPS 1.0

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.29.1  | C:\tools\nginx-1.29.1\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version        | Path                                                     |
| ----------------------------- | -------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.14.36414.22 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 35.0.78.0       |
| Component.Android.NDK.R23C                                                | 17.14.36015.10  |
| Component.Android.SDK.MAUI                                                | 17.14.36015.10  |
| Component.Dotfuscator                                                     | 17.14.36015.10  |
| Component.Linux.CMake                                                     | 17.14.36108.8   |
| Component.Linux.RemoteFileExplorer                                        | 17.14.36108.8   |
| Component.MDD.Android                                                     | 17.14.36015.10  |
| Component.MDD.Linux                                                       | 17.14.36108.8   |
| Component.MDD.Linux.GCC.arm                                               | 17.14.36015.10  |
| Component.Microsoft.VisualStudio.LiveShare.2022                           | 1.0.5949        |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.14.36015.10  |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.0.35906.1    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.14.36015.10  |
| Component.Microsoft.Web.LibraryManager                                    | 17.14.36015.10  |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.14.2.50506   |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.12   |
| Component.OpenJDK                                                         | 17.14.36015.10  |
| Component.UnityEngine.x64                                                 | 17.14.36015.10  |
| Component.Unreal                                                          | 17.14.36015.10  |
| Component.Unreal.Android                                                  | 17.14.36015.10  |
| Component.Unreal.Debugger                                                 | 17.14.36015.10  |
| Component.Unreal.Ide                                                      | 17.14.36015.10  |
| Component.VisualStudio.GitHub.Copilot                                     | 17.14.36414.12  |
| Component.VSInstallerProjects2022                                         | 2.0.1           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| Component.Xamarin                                                         | 17.14.36015.10  |
| ios                                                                       | 18.5.9214.0     |
| maccatalyst                                                               | 18.5.9214.0     |
| maui.blazor                                                               | 9.0.82.6628     |
| maui.core                                                                 | 9.0.82.6628     |
| maui.windows                                                              | 9.0.82.6628     |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.14.36015.10  |
| Microsoft.Component.ClickOnce                                             | 17.14.36015.10  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.14.36015.10  |
| Microsoft.Component.MSBuild                                               | 17.14.36015.10  |
| Microsoft.Component.NetFX.Native                                          | 17.14.36015.10  |
| Microsoft.Component.PythonTools                                           | 17.14.36015.10  |
| Microsoft.Component.PythonTools.Web                                       | 17.14.36015.10  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.14.36015.10  |
| Microsoft.ComponentGroup.Blend                                            | 17.14.36015.10  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.14.36015.10  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.14.36015.10  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.14.36015.10  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.14.36015.10  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.14.36015.10  |
| Microsoft.Net.Component.4.7.2.SDK                                         | 17.14.36015.10  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.14.36015.10  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.14.36015.10  |
| Microsoft.Net.Component.4.8.1.SDK                                         | 17.14.36015.10  |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 17.14.36015.10  |
| Microsoft.Net.Component.4.8.SDK                                           | 17.14.36015.10  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.14.36015.10  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.14.36015.10  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.14.36015.10  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.14.36015.10  |
| microsoft.net.runtime.android                                             | 9.0.825.36511   |
| microsoft.net.runtime.android.aot                                         | 9.0.825.36511   |
| microsoft.net.runtime.android.aot.net8                                    | 9.0.825.36511   |
| microsoft.net.runtime.android.net8                                        | 9.0.825.36511   |
| microsoft.net.runtime.ios                                                 | 9.0.825.36511   |
| microsoft.net.runtime.ios.net8                                            | 9.0.825.36511   |
| microsoft.net.runtime.maccatalyst                                         | 9.0.825.36511   |
| microsoft.net.runtime.maccatalyst.net8                                    | 9.0.825.36511   |
| microsoft.net.runtime.mono.tooling                                        | 9.0.825.36511   |
| microsoft.net.runtime.mono.tooling.net8                                   | 9.0.825.36511   |
| microsoft.net.sdk.emscripten                                              | 9.0.12.35301    |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.14.36015.10  |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 17.14.36331.10  |
| Microsoft.NetCore.Component.Runtime.9.0                                   | 17.14.36331.10  |
| Microsoft.NetCore.Component.SDK                                           | 17.14.36331.10  |
| Microsoft.NetCore.Component.Web                                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.14.36024.20  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Embedded                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.HLSL                                     | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.14.36414.12  |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Unity                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Web                                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 17.14.36414.12  |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.14.36322.40  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 17.14.36015.10  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.14.36322.40  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Data                                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.14.36301.6   |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.14.36108.8   |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.14.36331.10  |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.14.36331.10  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Node                                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Office                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Python                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.14.36331.10  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.14.36015.10  |
| runtimes.ios                                                              | 9.0.825.36511   |
| runtimes.ios.net8                                                         | 9.0.825.36511   |
| runtimes.maccatalyst                                                      | 9.0.825.36511   |
| runtimes.maccatalyst.net8                                                 | 9.0.825.36511   |
| wasm.tools                                                                | 9.0.825.36511   |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 3.0.4           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 3.0.1           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 1.6.2           |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 2.0.1           |
| Windows Driver Kit                                                        | 10.1.26100.4202 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26100.12   |
| Windows Software Development Kit                                          | 10.1.26100.4654 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.44.35211 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.44.35211 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.44.35211 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.44.35211 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.44.35211 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.44.35211 |

#### Installed Windows SDKs
- 10.0.17763.0
- 10.0.19041.0
- 10.0.22621.0
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 8.0.119, 8.0.206, 8.0.316, 8.0.413, 9.0.109, 9.0.205, 9.0.304
- .NET Framework: 4.7.2, 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.39, 8.0.6, 8.0.19, 9.0.6, 9.0.8
- Microsoft.NETCore.App: 6.0.39, 8.0.6, 8.0.19, 9.0.6, 9.0.8
- Microsoft.WindowsDesktop.App: 8.0.6, 8.0.19, 9.0.6, 9.0.8
- nbgv 3.7.115+d31f50f4d1

### PowerShell Tools
- PowerShell 7.4.11

#### Powershell Modules
- Az: 12.5.0
- AWSPowershell: 5.0.49
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.30.0
- Pester: 3.4.0, 5.7.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.24.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.4.5.1
- VSSetup: 2.2.16

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                                                                                                                                                                   |
| Android Emulator           | 36.1.9                                                                                                                                                                                                                                                                                                                                                                                                                |
| Android SDK Build-tools    | 36.0.0<br>35.0.0 35.0.1<br>34.0.0<br>33.0.0 33.0.1 33.0.2 33.0.3<br>32.0.0<br>31.0.0                                                                                                                                                                                                                                                                                                                                  |
| Android SDK Platforms      | android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android SDK Platform-Tools | 36.0.0                                                                                                                                                                                                                                                                                                                                                                                                                |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                                                                                |
| CMake                      | 3.18.1<br>3.22.1<br>3.31.5                                                                                                                                                                                                                                                                                                                                                                                            |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                                                                                    |
| NDK                        | 26.3.11579264<br>27.3.13750724<br>28.2.13676358                                                                                                                                                                                                                                                                                                                                                                       |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\28.2.13676358 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:b06372fdf2436467edcaea8526ff623e86af057be7ae2096166ee8c6d6f0a7f4  | 2025-08-12 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:93b737c136a81a61b8a27f87ae9072bd649cd39d950dadffc899b663e54cce18  | 2025-08-12 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:35fb40d7f9be74ac14c712e1e5d0064aee2fdb4bf3173450c7c634b725801d80  | 2025-08-12 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:6b12945bd34dd80b9c3bca145948d32155f0c3657c567909c85bb829f6197755  | 2025-08-08 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:d9e1a220c13cf25c7b213fbd96df2b63671e2dba0de3909003d4bb23a8bc8a1c  | 2025-08-08 |

