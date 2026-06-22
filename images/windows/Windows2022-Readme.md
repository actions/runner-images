| Announcements |
|-|
| [Go versions <=1.23  will be removed from tool-cache](https://github.com/actions/runner-images/issues/14237) |
| [[Windows] Windows 11 Arm with Visual Studio 2026 is now available as a public preview](https://github.com/actions/runner-images/issues/14225) |
| [[All OS] PowerShell will be updated from 7.4 to 7.6 LTS on all runner images](https://github.com/actions/runner-images/issues/14150) |
| [[ARM] Arm64 runner images now maintained by GitHub](https://github.com/actions/runner-images/issues/14100) |
| [[Windows] `windows-latest` and `windows-2025` image-label will use Windows Server 2025 with Visual Studio 2026 image in June 2026](https://github.com/actions/runner-images/issues/14017) |
| [[Windows] The Windows Server 2025 with Visual Studio 2026 is now generally available in GitHub Actions](https://github.com/actions/runner-images/issues/14016) |
***
# Windows Server 2022
- OS Version: 10.0.20348 Build 5256
- Image Version: 20260616.203.1

## Windows features
- Windows Subsystem for Linux (WSLv1): Enabled

## Installed Software

### Language and Runtime
- Bash 5.3.9(1)-release
- Go 1.24.13
- Julia 1.12.0
- Kotlin 2.4.0
- LLVM 20.1.8
- Node 22.22.3
- Perl 5.32.1
- PHP 8.5.7
- Python 3.12.10
- Ruby 3.3.11

### Package Management
- Chocolatey 2.7.3
- Composer 2.10.1
- Helm 4.1.4
- Miniconda 26.3.2 (pre-installed on the image but not added to PATH)
- NPM 10.9.8
- NuGet 7.6.0.59
- pip 26.1.2 (python 3.12)
- Pipx 1.14.0
- RubyGems 3.5.22
- Vcpkg (build from commit cac7d29f24)
- Yarn 1.22.22

#### Environment variables
| Name                    | Value        |
| ----------------------- | ------------ |
| VCPKG_INSTALLATION_ROOT | C:\vcpkg     |
| CONDA                   | C:\Miniconda |

### Project Management
- Ant 1.10.17
- Gradle 9.5
- Maven 3.9.16
- sbt 1.12.12

### Tools
- 7zip 26.01
- aria2 1.37.0
- azcopy 10.32.4
- Bazel 9.1.1
- Bazelisk 1.28.1
- Bicep 0.44.1
- Cabal 3.16.1.0
- CMake 3.31.6
- CodeQL Action Bundle 2.25.6
- Docker 29.1.5
- Docker Compose 2.40.3
- Docker-wincred 0.9.8
- ghc 9.14.1
- Git 2.54.0.windows.1
- Git LFS 3.7.1
- ImageMagick 7.1.2-25
- InnoSetup 6.7.1
- jq 1.8.1
- Kind 0.32.0
- Kubectl 1.36.2
- Mercurial 6.3.1
- gcc 14.2.0
- gdb 16.2
- GNU Binutils 2.44
- Newman 6.2.2
- NSIS 3.10
- OpenSSL 3.6.3
- Packer 1.15.3
- Pulumi 3.245.0
- R 4.6.0
- Service Fabric SDK 10.1.2493.9590
- Stack 3.11.1
- Subversion (SVN) 1.14.5
- Swig 4.3.1
- VSWhere 3.1.7
- WinAppDriver 1.2.2009.02003
- WiX Toolset 3.14.1.8722
- yamllint 1.38.0
- zstd 1.5.7
- Ninja 1.13.2

### CLI Tools
- Alibaba Cloud CLI 3.3.23
- AWS CLI 2.35.5
- AWS SAM CLI 1.162.1
- AWS Session Manager CLI 1.2.814.0
- Azure CLI 2.87.0
- Azure DevOps CLI extension 1.0.4
- GitHub CLI 2.94.0

### Rust Tools
- Cargo 1.96.0
- Rust 1.96.0
- Rustdoc 1.96.0
- Rustup 1.29.0

#### Packages
- bindgen 0.72.1
- cargo-audit 0.22.2
- cargo-outdated 0.19.0
- cbindgen 0.29.4
- Clippy 0.1.96
- Rustfmt 1.9.0

### Browsers and Drivers
- Google Chrome 149.0.7827.115
- Chrome Driver 149.0.7827.115
- Microsoft Edge 149.0.4022.69
- Microsoft Edge Driver 149.0.4022.69
- Mozilla Firefox 152.0
- Gecko Driver 0.37.0
- IE Driver 4.14.0.0
- Selenium server 4.45.0

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
| 8.0.492+9 (default) | JAVA_HOME_8_X64      |
| 11.0.31+11          | JAVA_HOME_11_X64     |
| 17.0.19+10          | JAVA_HOME_17_X64     |
| 21.0.11+10.0        | JAVA_HOME_21_X64     |
| 25.0.3+9.0          | JAVA_HOME_25_X64     |

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
- 1.24.13
- 1.25.11

#### Node.js
- 22.22.3
- 24.16.0

#### Python
- 3.10.11
- 3.11.9
- 3.12.10
- 3.13.14
- 3.14.6

#### PyPy
- 2.7.18 [PyPy 7.3.23]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.19 [PyPy 7.3.16]
- 3.10.16 [PyPy 7.3.19]

#### Ruby
- 3.2.11
- 3.3.11
- 3.4.9
- 4.0.5

### Databases

#### PostgreSQL
| Property             | Value                                                                                                                  |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| ServiceName          | postgresql-x64-14                                                                                                      |
| Version              | 14.23                                                                                                                  |
| ServiceStatus        | Stopped                                                                                                                |
| ServiceStartType     | Disabled                                                                                                               |
| EnvironmentVariables | PGBIN=C:\Program Files\PostgreSQL\14\bin <br> PGDATA=C:\PostgreSQL\14\data <br> PGROOT=C:\Program Files\PostgreSQL\14  |
| Path                 | C:\Program Files\PostgreSQL\14                                                                                         |
| UserName             | postgres                                                                                                               |
| Password             | root                                                                                                                   |

#### MongoDB
| Version  | ServiceName | ServiceStatus | ServiceStartType |
| -------- | ----------- | ------------- | ---------------- |
| 7.0.37.0 | MongoDB     | Stopped       | Disabled         |

### Database tools
- Azure CosmosDb Emulator 2.14.27.0
- DacFx 170.4.83.3
- MySQL 8.0.46.0
- SQL OLEDB Driver 18 18.7.5.0
- SQL OLEDB Driver 19 19.4.1.0
- SQLPS 1.0
- MongoDB Shell (mongosh) 2.8.3

### Web Servers
| Name   | Version | ConfigFile                            | ServiceName | ServiceStatus | ListenPort |
| ------ | ------- | ------------------------------------- | ----------- | ------------- | ---------- |
| Apache | 2.4.55  | C:\tools\Apache24\conf\httpd.conf     | Apache      | Stopped       | 80         |
| Nginx  | 1.31.1  | C:\tools\nginx-1.31.1\conf\nginx.conf | nginx       | Stopped       | 80         |

### Visual Studio Enterprise 2022
| Name                          | Version       | Path                                                     |
| ----------------------------- | ------------- | -------------------------------------------------------- |
| Visual Studio Enterprise 2022 | 17.14.37328.6 | C:\Program Files\Microsoft Visual Studio\2022\Enterprise |

#### Workloads, components and extensions
| Package                                                                   | Version         |
| ------------------------------------------------------------------------- | --------------- |
| android                                                                   | 35.0.78.0       |
| Component.Android.NDK.R23C                                                | 17.14.36510.44  |
| Component.Android.SDK.MAUI                                                | 17.14.36510.44  |
| Component.Dotfuscator                                                     | 17.14.36510.44  |
| Component.Linux.CMake                                                     | 17.14.36510.44  |
| Component.Linux.RemoteFileExplorer                                        | 17.14.36510.44  |
| Component.MDD.Android                                                     | 17.14.36804.6   |
| Component.MDD.Linux                                                       | 17.14.36510.44  |
| Component.Microsoft.VisualStudio.RazorExtension                           | 17.14.36510.44  |
| Component.Microsoft.VisualStudio.Tools.Applications.amd64                 | 17.1.37110.1    |
| Component.Microsoft.VisualStudio.Web.AzureFunctions                       | 17.14.36510.44  |
| Component.Microsoft.Web.LibraryManager                                    | 17.14.36510.44  |
| Component.Microsoft.WebTools.BrowserLink.WebLivePreview                   | 17.14.2.50506   |
| Component.Microsoft.Windows.DriverKit                                     | 10.0.26100.16   |
| Component.OpenJDK                                                         | 17.14.36510.44  |
| Component.UnityEngine.x64                                                 | 17.14.36510.44  |
| Component.Unreal                                                          | 17.14.36510.44  |
| Component.Unreal.Android                                                  | 17.14.36510.44  |
| Component.Unreal.Debugger                                                 | 17.14.36907.17  |
| Component.Unreal.Ide                                                      | 17.14.36510.44  |
| Component.VisualStudio.GitHub.Copilot                                     | 17.14.37320.22  |
| Component.VisualStudio.GitHubCopilotForAzure.x64                          | 17.14.37202.16  |
| Component.VSInstallerProjects2022                                         | 3.0.0           |
| Component.WixToolset.VisualStudioExtension.Dev17                          | 1.0.0.22        |
| Component.WixToolset.VisualStudioExtension.Schemas3                       | 1.0.0.22        |
| Component.Xamarin                                                         | 17.14.36510.44  |
| ComponentGroup.Microsoft.NET.AppModernization                             | 17.14.37203.1   |
| ios                                                                       | 26.0.9752.0     |
| maccatalyst                                                               | 26.0.9752.0     |
| maui.blazor                                                               | 9.0.111.6930    |
| maui.core                                                                 | 9.0.111.6930    |
| maui.windows                                                              | 9.0.111.6930    |
| Microsoft.Component.Azure.DataLake.Tools                                  | 17.14.36510.44  |
| Microsoft.Component.ClickOnce                                             | 17.14.36510.44  |
| Microsoft.Component.CodeAnalysis.SDK                                      | 17.14.36510.44  |
| Microsoft.Component.MSBuild                                               | 17.14.36510.44  |
| Microsoft.Component.NetFX.Native                                          | 17.14.36510.44  |
| Microsoft.Component.PythonTools                                           | 17.14.36510.44  |
| Microsoft.Component.PythonTools.Web                                       | 17.14.36510.44  |
| Microsoft.Component.VC.Runtime.UCRTSDK                                    | 17.14.36510.44  |
| Microsoft.ComponentGroup.Blend                                            | 17.14.36510.44  |
| Microsoft.ComponentGroup.ClickOnce.Publish                                | 17.14.36510.44  |
| Microsoft.Net.Component.4.5.2.TargetingPack                               | 17.14.36510.44  |
| Microsoft.Net.Component.4.6.2.TargetingPack                               | 17.14.36510.44  |
| Microsoft.Net.Component.4.6.TargetingPack                                 | 17.14.36510.44  |
| Microsoft.Net.Component.4.7.1.TargetingPack                               | 17.14.36510.44  |
| Microsoft.Net.Component.4.7.2.SDK                                         | 17.14.36510.44  |
| Microsoft.Net.Component.4.7.2.TargetingPack                               | 17.14.36510.44  |
| Microsoft.Net.Component.4.7.TargetingPack                                 | 17.14.36510.44  |
| Microsoft.Net.Component.4.8.1.SDK                                         | 17.14.36510.44  |
| Microsoft.Net.Component.4.8.1.TargetingPack                               | 17.14.36510.44  |
| Microsoft.Net.Component.4.8.SDK                                           | 17.14.36510.44  |
| Microsoft.Net.Component.4.8.TargetingPack                                 | 17.14.36510.44  |
| Microsoft.Net.ComponentGroup.4.8.DeveloperTools                           | 17.14.36510.44  |
| Microsoft.Net.ComponentGroup.DevelopmentPrerequisites                     | 17.14.36510.44  |
| Microsoft.Net.ComponentGroup.TargetingPacks.Common                        | 17.14.36510.44  |
| microsoft.net.runtime.android                                             | 9.0.1726.26416  |
| microsoft.net.runtime.android.aot                                         | 9.0.1726.26416  |
| microsoft.net.runtime.android.aot.net8                                    | 9.0.1726.26416  |
| microsoft.net.runtime.android.net8                                        | 9.0.1726.26416  |
| microsoft.net.runtime.ios                                                 | 9.0.1726.26416  |
| microsoft.net.runtime.maccatalyst                                         | 9.0.1726.26416  |
| microsoft.net.runtime.mono.tooling                                        | 9.0.1726.26416  |
| microsoft.net.runtime.mono.tooling.net8                                   | 9.0.1726.26416  |
| microsoft.net.sdk.emscripten                                              | 9.0.14.25803    |
| Microsoft.NetCore.Component.DevelopmentTools                              | 17.14.36510.44  |
| Microsoft.NetCore.Component.Runtime.8.0                                   | 17.14.37328.3   |
| Microsoft.NetCore.Component.Runtime.9.0                                   | 17.14.37328.3   |
| Microsoft.NetCore.Component.SDK                                           | 17.14.37328.3   |
| Microsoft.NetCore.Component.Web                                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.AppInsights.Tools                        | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.AspNet                                   | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.AspNet45                                 | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Azure.AuthoringTools                     | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Azure.ClientLibs                         | 17.14.36907.17  |
| Microsoft.VisualStudio.Component.Azure.Compute.Emulator                   | 17.14.36517.7   |
| Microsoft.VisualStudio.Component.Azure.ResourceManager.Tools              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Azure.ServiceFabric.Tools                | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Azure.Waverton                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Azure.Waverton.BuildTools                | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.ClassDesigner                            | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.CodeMap                                  | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Common.Azure.Tools                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.CoreEditor                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.CppBuildInsights                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Debugger.JustInTime                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.DiagnosticTools                          | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.DockerTools                              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.DotNetModelBuilder                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.DslTools                                 | 17.14.37111.13  |
| Microsoft.VisualStudio.Component.EntityFramework                          | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.FSharp                                   | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.FSharp.Desktop                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.FSharp.WebTemplates                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.GraphDocument                            | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Graphics                                 | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Graphics.Tools                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.HLSL                                     | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.IISExpress                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.IntelliCode                              | 17.14.36621.7   |
| Microsoft.VisualStudio.Component.IntelliTrace.FrontEnd                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.JavaScript.Diagnostics                   | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.JavaScript.TypeScript                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.LinqToSql                                | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.LiveUnitTesting                          | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Core                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.ManagedDesktop.Prerequisites             | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.MSODBC.SQL                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Node.Tools                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.NuGet                                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.NuGet.BuildTools                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.PortableLibrary                          | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Roslyn.Compiler                          | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Roslyn.LanguageServices                  | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Sharepoint.Tools                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.SQL.CLR                                  | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.SQL.DataSources                          | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.SQL.LocalDB.Runtime                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.SQL.SSDT                                 | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.TeamOffice                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.TestTools.CodedUITest                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.TestTools.WebLoadTest                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.TextTemplating                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.TypeScript.TSServer                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Unity                                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64                             | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.UWP.VC.ARM64EC                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.14.29.16.11.ARM64                     | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ASAN                                  | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATL                                   | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64                             | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre                     | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATL.Spectre                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATLMFC                                | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre                        | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.CLI.Support                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.CMake.Project                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.CoreIde                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.DiagnosticTools                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Llvm.Clang                            | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Llvm.ClangToolset                     | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM                               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM.Spectre                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64                             | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.MFC.ARM64.Spectre                     | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Modules.x86.x64                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Redist.14.Latest                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Redist.MSM                            | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre                  | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre                | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Runtimes.ARM64EC.Spectre              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForBoostTest               | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.TestAdapterForGoogleTest              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM                             | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64                           | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Tools.ARM64EC                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VC.Tools.x86.x64                         | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Vcpkg                                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.VSSDK                                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Wcf.Tooling                              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Web                                      | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.WebDeploy                                | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Windows10SDK                             | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Windows10SDK.19041                       | 17.14.36809.9   |
| Microsoft.VisualStudio.Component.Windows11SDK.22621                       | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Windows11SDK.26100                       | 17.14.37011.9   |
| Microsoft.VisualStudio.Component.Windows11Sdk.WindowsPerformanceToolkit   | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.WindowsAppSdkSupport.CSharp              | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.Workflow                                 | 17.14.36510.44  |
| Microsoft.VisualStudio.Component.WslDebugging                             | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Native            | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Azure.CloudServices                 | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Azure.Prerequisites                 | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Azure.ResourceManager.Tools         | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.AzureFunctions                      | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.All                            | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Android                        | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Blazor                         | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.iOS                            | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.MacCatalyst                    | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Shared                         | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Maui.Windows                        | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.MSIX.Packaging                      | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Core                  | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Llvm.Clang            | 17.14.36802.14  |
| Microsoft.VisualStudio.ComponentGroup.UWP.NetCoreAndStandard              | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.UWP.VC.v142                         | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.VC.Tools.142.x86.x64                | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.VisualStudioExtension.Prerequisites | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Web                                 | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.Web.CloudTools                      | 17.14.36614.30  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions                  | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.CMake            | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.WebToolsExtensions.TemplateEngine   | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppDevelopment.Prerequisites | 17.14.36510.44  |
| Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs                    | 17.14.36510.44  |
| Microsoft.VisualStudio.Workload.Azure                                     | 17.14.37202.16  |
| Microsoft.VisualStudio.Workload.CoreEditor                                | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Data                                      | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.DataScience                               | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.ManagedDesktop                            | 17.14.36518.2   |
| Microsoft.VisualStudio.Workload.ManagedGame                               | 17.14.36301.6   |
| Microsoft.VisualStudio.Workload.NativeCrossPlat                           | 17.14.36716.0   |
| Microsoft.VisualStudio.Workload.NativeDesktop                             | 17.14.36517.7   |
| Microsoft.VisualStudio.Workload.NativeGame                                | 17.14.36331.10  |
| Microsoft.VisualStudio.Workload.NativeMobile                              | 17.14.36802.14  |
| Microsoft.VisualStudio.Workload.NetCrossPlat                              | 17.14.36518.2   |
| Microsoft.VisualStudio.Workload.NetWeb                                    | 17.14.37325.6   |
| Microsoft.VisualStudio.Workload.Node                                      | 17.14.36517.7   |
| Microsoft.VisualStudio.Workload.Office                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Python                                    | 17.14.36015.10  |
| Microsoft.VisualStudio.Workload.Universal                                 | 17.14.36331.10  |
| Microsoft.VisualStudio.Workload.VisualStudioExtension                     | 17.14.36015.10  |
| runtimes.ios                                                              | 9.0.1726.26416  |
| runtimes.maccatalyst                                                      | 9.0.1726.26416  |
| wasm.tools                                                                | 9.0.1726.26416  |
| ProBITools.MicrosoftAnalysisServicesModelingProjects2022                  | 4.0.0           |
| ProBITools.MicrosoftReportProjectsforVisualStudio2022                     | 4.0.0           |
| SSIS.MicrosoftDataToolsIntegrationServices                                | 2.2             |
| VisualStudioClient.MicrosoftVisualStudio2022InstallerProjects             | 3.0.0           |
| Windows Driver Kit                                                        | 10.1.26100.4202 |
| Windows Driver Kit Visual Studio Extension                                | 10.0.26100.16   |
| Windows Software Development Kit                                          | 10.1.26100.7705 |
| WixToolset.WixToolsetVisualStudio2022Extension                            | 1.0.0.22        |

#### Microsoft Visual C++
| Name                                         | Architecture | Version     |
| -------------------------------------------- | ------------ | ----------- |
| Microsoft Visual C++ 2013 Additional Runtime | x64          | 12.0.40660  |
| Microsoft Visual C++ 2013 Minimum Runtime    | x64          | 12.0.40660  |
| Microsoft Visual C++ 2022 Additional Runtime | x64          | 14.51.36247 |
| Microsoft Visual C++ 2022 Debug Runtime      | x64          | 14.44.35211 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x64          | 14.51.36247 |
| Microsoft Visual C++ 2022 Additional Runtime | x86          | 14.51.36247 |
| Microsoft Visual C++ 2022 Debug Runtime      | x86          | 14.44.35211 |
| Microsoft Visual C++ 2022 Minimum Runtime    | x86          | 14.51.36247 |

#### Installed Windows SDKs
- 10.0.17763.0
- 10.0.19041.0
- 10.0.22621.0
- 10.0.26100.0

### .NET Core Tools
- .NET Core SDK: 8.0.128, 8.0.206, 8.0.319, 8.0.422, 9.0.118, 9.0.205, 9.0.315, 10.0.109, 10.0.204, 10.0.301
- .NET Framework: 4.7.2, 4.8, 4.8.1
- Microsoft.AspNetCore.App: 6.0.42, 8.0.6, 8.0.22, 8.0.28, 9.0.6, 9.0.17, 10.0.8, 10.0.9
- Microsoft.NETCore.App: 6.0.42, 8.0.6, 8.0.22, 8.0.28, 9.0.6, 9.0.17, 10.0.8, 10.0.9
- Microsoft.WindowsDesktop.App: 8.0.6, 8.0.22, 8.0.28, 9.0.6, 9.0.17, 10.0.8, 10.0.9
- nbgv 3.9.50+6feeb89450

### PowerShell Tools
- PowerShell 7.6.2

#### Powershell Modules
- Az: 15.6.1
- AWSPowershell: 5.0.234
- DockerMsftProvider: 1.0.0.8
- MarkdownPS: 1.10
- Microsoft.Graph: 2.38.0
- Pester: 3.4.0, 5.7.1
- PowerShellGet: 1.0.0.1, 2.2.5
- PSScriptAnalyzer: 1.25.0
- PSWindowsUpdate: 2.2.1.5
- SqlServer: 22.3.0
- VSSetup: 2.2.16

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                             |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                                                                                                                                 |
| Android Emulator           | 36.6.11                                                                                                                                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0<br>32.0.0                                                                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33 (rev 3) |
| Android SDK Platform-Tools | 37.0.0                                                                                                                                                                                                                                                                                                                                                              |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                              |
| CMake                      | 3.22.1<br>3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                                                           |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                                  |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                                  |
| NDK                        | 27.3.13750724<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                                                                                     |

#### Environment variables
| Name                    | Value                                    |
| ----------------------- | ---------------------------------------- |
| ANDROID_HOME            | C:\Android\android-sdk                   |
| ANDROID_NDK             | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_HOME        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | C:\Android\android-sdk\ndk\29.0.14206865 |
| ANDROID_NDK_ROOT        | C:\Android\android-sdk\ndk\27.3.13750724 |
| ANDROID_SDK_ROOT        | C:\Android\android-sdk                   |

### Cached Docker images
| Repository:Tag                                                            | Digest                                                                   | Created    |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2022  | sha256:ec04e733695f49a0dc9132184f6b06704866b34f422004093c1972512c86259e  | 2025-09-09 |
| mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2022 | sha256:3983348680840ca6e53ad641e314c3c9184ca2fd19f88bc467600f7d9f6e9d73  | 2025-09-09 |
| mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-ltsc2022     | sha256:460dedaed73224f73ff10dc3ad754d0ed250aa57bcdf6c5052a811b4b7e29345  | 2025-09-09 |
| mcr.microsoft.com/windows/nanoserver:ltsc2022                             | sha256:7644d94e806b07c22d7e276a8cdbcbffac1d02bf3d5170884302d0e9b0a519e9  | 2026-06-07 |
| mcr.microsoft.com/windows/servercore:ltsc2022                             | sha256:a23b350061d76236e2c427e32175a2decfe3214200eee4ae9ee9cd9e98f26bf0  | 2026-06-07 |

