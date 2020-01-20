# Windows Server 2016

The following software is installed on machines with the 20191009.1 update.

Components marked with **\*** have been upgraded since the previous version of the image.


## Chocolatey

_Version:_ 0.10.15<br/>
_Environment:_
* PATH: contains location for choco.exe

## Docker

_Version:_ 19.03.3<br/>
_Environment:_
* PATH: contains location of docker.exe

## Docker-compose

_Version:_ 1.24.0<br/>
_Environment:_
* PATH: contains location of docker-compose.exe

## Powershell Core

_Version:_ 6.2.3
<br/>

## Docker images

The following container images have been cached:
* mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2016 (Digest: sha256:f247ce2cdad4711b6a597bf3a84581278251e13176a2129158e3138fa7c6730d)
* mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2016 (Digest: sha256:ebb0693431d47cbd070f8b6473b5a3b79896e8a146d202f78b92cabf6ceb4b3d)
* mcr.microsoft.com/windows/servercore:ltsc2016 (Digest: sha256:45469202b1d2630e502330c0c4e977fac9b4540611c9778dedfc140f683f8f68)
* microsoft/aspnetcore-build:1.0-2.0 (Digest: sha256:9ecc7c5a8a7a11dca5f08c860165646cb30d084606360a3a72b9cbe447241c0c)
* mcr.microsoft.com/windows/nanoserver:10.0.14393.953 (Digest: sha256:fc60bd5ae0e61b334ce1cf1bcbf20c10c36b4c5482a01da319c9c989f9e6e268)

## Visual Studio 2017 Enterprise

_Version:_ VisualStudio/15.9.16+28307.858<br/>
_Location:_ C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise

The following workloads including required and recommended components are installed with Visual Studio 2017:

* Universal Windows Platform development
* .NET desktop development
* Desktop development with C++
* ASP.NET and web development
* Azure development
* Node.js development
* Data storage and processing
* Data science and analytical applications *
* Game development with Unity *
* Linux development with C++ *
* Game development with C++ *
* Mobile development with C++ *
* Office/SharePoint development
* Mobile development with .NET
* .NET Core cross-platform development
* Visual Studio extension development *
* Python development *
* Mobile development with JavaScript *

In addition the following optional components are installed:

* Microsoft.Net.Component.4.6.2.SDK
* Microsoft.Net.Component.4.6.2.TargetingPack
* Microsoft.Net.ComponentGroup.4.6.2.DeveloperTools
* Microsoft.Net.Component.4.7.SDK
* Microsoft.Net.Component.4.7.TargetingPack
* Microsoft.Net.ComponentGroup.4.7.DeveloperTools
* Microsoft.Net.Component.4.7.1.SDK
* Microsoft.Net.Component.4.7.1.TargetingPack
* Microsoft.Net.ComponentGroup.4.7.1.DeveloperTools
* Microsoft.Net.ComponentGroup.4.7.2.DeveloperTools
* Microsoft.Net.Core.Component.SDK.1x
* Microsoft.NetCore.1x.ComponentGroup.Web
* Microsoft.VisualStudio.Component.Azure.Storage.AzCopy
* Microsoft.VisualStudio.Component.PowerShell.Tools
* Microsoft.VisualStudio.Component.VC.140
* Component.Dotfuscator
* Microsoft.VisualStudio.Component.VC.ATL
* Microsoft.VisualStudio.Component.VC.ATL.ARM
* Microsoft.VisualStudio.Component.VC.ATL.ARM64
* Microsoft.VisualStudio.Component.VC.ATLMFC
* Microsoft.VisualStudio.Component.VC.ClangC2
* Microsoft.VisualStudio.Component.VC.CLI.Support
* Microsoft.VisualStudio.Component.VC.Modules.x86.x64
* Microsoft.VisualStudio.Component.Windows10SDK.10240
* Microsoft.VisualStudio.Component.Windows10SDK.10586
* Microsoft.VisualStudio.Component.Windows10SDK.14393
* Microsoft.VisualStudio.Component.Windows10SDK.15063.Desktop
* Component.Unreal
* Component.Unreal.Android
* Component.Android.SDK23
* Microsoft.VisualStudio.Component.TestTools.WebLoadTest
* Microsoft.VisualStudio.Web.Mvc4.ComponentGroup
* Component.Linux.CMake
* Microsoft.Component.PythonTools.UWP
* Microsoft.Component.VC.Runtime.OSSupport
* Microsoft.VisualStudio.Component.VC.Tools.ARM
* Microsoft.VisualStudio.ComponentGroup.UWP.VC
* Microsoft.VisualStudio.Component.VSSDK
* Microsoft.VisualStudio.Component.LinqToSql
* Microsoft.VisualStudio.Component.TestTools.CodedUITest
* Microsoft.VisualStudio.Component.TestTools.Core
* Microsoft.VisualStudio.Component.TypeScript.2.0
* Microsoft.VisualStudio.Component.TypeScript.2.1
* Microsoft.VisualStudio.Component.TypeScript.2.2
* Microsoft.VisualStudio.Component.VC.Tools.ARM64
* Microsoft.VisualStudio.Component.Windows10SDK.16299.Desktop.arm
* Microsoft.VisualStudio.Component.DslTools
* Microsoft.VisualStudio.Component.Windows81SDK
* Microsoft.VisualStudio.Component.WinXP
* Microsoft.VisualStudio.ComponentGroup.NativeDesktop.Win81
* Microsoft.VisualStudio.ComponentGroup.NativeDesktop.WinXP
* Microsoft.VisualStudio.ComponentGroup.ArchitectureTools.Managed
* Microsoft.Component.Blend.SDK.WPF
* Microsoft.Component.VC.Runtime.UCRTSDK
* Microsoft.VisualStudio.Component.VC.ATL.Spectre
* Microsoft.VisualStudio.Component.VC.ATL.ARM.Spectre
* Microsoft.VisualStudio.Component.VC.ATL.ARM64.Spectre
* Microsoft.VisualStudio.Component.VC.ATLMFC.Spectre
* Microsoft.VisualStudio.Component.Windows10SDK.17134
* Microsoft.VisualStudio.Component.Windows10SDK.17763
* Microsoft.VisualStudio.Component.VC.Runtimes.x86.x64.Spectre
* Microsoft.VisualStudio.Component.VC.Runtimes.ARM.Spectre
* Microsoft.VisualStudio.Component.VC.Runtimes.ARM64.Spectre

## SQL Server Data Tools for VS 2017

_Version:_ 15.1.61906.3130<br/>

The following components are installed:

* SQL Server Data Tools
* SQL Server Analysis Services Designer
* SQL Server Integration Services Designer
* SQL Server Reporting Services Designers

## WIX Tools

_Toolset Version:_ 3.11.4516<br/>
_WIX Toolset Studio 2017 Extension Version:_ 0.9.21.62588<br/>
_Environment:_
* WIX: Installation root of WIX

## .NET 4.8

_Version:_ 4.8.03761

## Windows Driver Kit

_Version:_ 10.0.17763.0<br/>

## Azure Service Fabric

_SDK Version:_ 3.3.617.9590<br/>
_Runtime Version:_ 6.4.617.9590

## WinAppDriver

_Version:_ 1.1.1809.18001<br/>

## Android SDK Build Tools

#### 29.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\29.0.2

#### 29.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\29.0.0

#### 28.0.3

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\28.0.3

#### 28.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\28.0.2

#### 28.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\28.0.1

#### 28.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\28.0.0

#### 27.0.3

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\27.0.3

#### 27.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\27.0.2

#### 27.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\27.0.1

#### 27.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\27.0.0

#### 26.0.3

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\26.0.3

#### 26.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\26.0.2

#### 26.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\26.0.1

#### 26.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\26.0.0

#### 25.0.3

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\25.0.3

#### 25.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\25.0.2

#### 25.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\25.0.1

#### 25.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\25.0.0

#### 24.0.3

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\24.0.3

#### 24.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\24.0.2

#### 24.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\24.0.1

#### 24.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\24.0.0

#### 23.0.3

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\23.0.3

#### 23.0.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\23.0.2

#### 23.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\23.0.1

#### 22.0.1

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\22.0.1

#### 21.1.2

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\21.1.2

#### 20.0.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\20.0.0

#### 19.1.0

_Location:_ C:\Program Files (x86)\Android\android-sdk\build-tools\19.1.0


## Android SDK Platforms

#### 10 (API 29)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-29

#### 9 (API 28)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-28

#### 8.1.0 (API 27)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-27

#### 8.0.0 (API 26)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-26

#### 7.1.1 (API 25)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-25

#### 7.0 (API 24)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-24

#### 6.0 (API 23)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-23

#### 5.1.1 (API 22)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-22

#### 5.0.1 (API 21)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-21

#### 4.4.2 (API 19)

_Location:_ C:\Program Files (x86)\Android\android-sdk\platforms\android-19


## Azure/AzureRM Powershell modules

#### 2.1.0

This version is installed and is available via Get-Module -ListAvailable

#### 3.8.0

This version is saved but not installed
_Location:_ C:\Modules\azurerm_3.8.0\AzureRM\3.8.0\AzureRM.psd1

#### 4.2.1

This version is saved but not installed
_Location:_ C:\Modules\azurerm_4.2.1\AzureRM\4.2.1\AzureRM.psd1

#### 5.1.1

This version is saved but not installed
_Location:_ C:\Modules\azurerm_5.1.1\AzureRM\5.1.1\AzureRM.psd1

#### 6.7.0

This version is saved but not installed
_Location:_ C:\Modules\azurerm_6.7.0\AzureRM\6.7.0\AzureRM.psd1


## TLS12

_Version:_ 1.2<br/>
_Description:_ .NET has been configured to use TLS 1.2 by default

## Azure CLI

_Version:_ 2.0.74
_Environment:_
* PATH: contains location of az.cmd

## Azure DevOps Cli extension

_Version:_ azure-devops                      0.13.0

## Python

_Version:_ 2.7.16 (x64)<br/>_Version:_ 2.7.16 (x86)<br/>_Version:_ 3.4.4 (x64)<br/>_Version:_ 3.4.4 (x86)<br/>_Version:_ 3.5.4 (x64)<br/>_Version:_ 3.5.4 (x86)<br/>_Version:_ 3.6.8 (x64)<br/>_Version:_ 3.6.8 (x86)<br/>_Version:_ 3.7.4 (x64)<br/>_Version:_ 3.7.4 (x86)<br/><br/>

## PyPy

_Version:_ 2.7.13 (x86)<br/>_Version:_ 3.5.3 (x86)<br/><br/>

## Ruby

_Version:_ 2.4.6 (x64)<br/>_Version:_ 2.5.5 (x64)<br/>_Version:_ 2.6.3 (x64)<br/><br/>

## Python (64 bit)

#### Python 3.6.8
_Environment:_
* PATH: contains location of python.exe

#### Python 2.7.16

_Location:_ C:/hostedtoolcache/windows/Python/2.7*/x64

## Git

_Version:_ 2.23.0<br/>
_Environment:_
* PATH: contains location of git.exe

## Git Large File Storage (LFS)

_Version:_ 2.8.0<br/>
_Environment:_
* PATH: contains location of git-lfs.exe
* GIT_LFS_PATH: location of git-lfs.exe

## Go (x64)

#### 1.9.7

_Environment:_
* GOROOT_1_9_X64: root directory of the Go 1.9.7 installation

#### 1.10.8

_Environment:_
* GOROOT_1_10_X64: root directory of the Go 1.10.8 installation

#### 1.11.12

_Environment:_
* GOROOT_1_11_X64: root directory of the Go 1.11.12 installation

#### 1.12.7

_Environment:_
* PATH: contains the location of go.exe version 1.12.7
* GOROOT: root directory of the Go 1.12.7 installation
* GOROOT_1_12_X64: root directory of the Go 1.12.7 installation
#### 1.13

_Environment:_
* GOROOT_1_13_X64: root directory of the Go 1.13 installation



## Boost

####

* PATH: contains the location of Boost version
* BOOST_ROOT: root directory of the Boost version  installation
* BOOST_ROOT_1_69_0: root directory of the Boost version  installation


## PHP (x64)

#### 7.3.10

_Environment:_
* PATH: contains the location of php.exe version 7.3.10
* PHPROOT: root directory of the PHP 7.3.10 installation

## Ruby (x64)

#### 2.5.5p157
_Environment:_
* Location: C:\hostedtoolcache\windows\Ruby\2.5.5\x64\bin
* PATH: contains the location of ruby.exe version 2.5.5p157

## Rust (64-bit)

#### 1.38.0
_Location:_ C:\Rust\.cargo\bin
_Environment:_
* PATH: contains the location of rustc.exe

## Subversion

_Version:_ 1.8.17<br/>
_Environment:_
* PATH: contains location of svn.exe

## Google Chrome

_version:_
77.0.3865.90

## Mozilla Firefox

_version:_
69.0.1

## Selenium Web Drivers


#### Chrome Driver

_version:_
77.0.3865.40

_Environment:_
* ChromeWebDriver: location of chromedriver.exe

#### Gecko Driver

_version:_
0.24.0

_Environment:_
* GeckoWebDriver: location of geckodriver.exe

#### IE Driver

_version:_
3.8.0.0

_Environment:_
* IEWebDriver: location of IEDriverServer.exe


## Node.js

_Version:_ 10.16.3<br/>
_Architecture:_ x64<br/>
_Environment:_
* PATH: contains location of node.exe<br/>
* Gulp CLI version: 2.2.0 Local version: Unknown<br/>
* Grunt grunt-cli v1.3.2<br/>
* Bower 1.8.8<br/>
* Yarn 1.19.1<br/>

## npm

_Version:_ 6.9.0<br/>
_Environment:_
* PATH: contains location of npm.cmd

## Java Development Kit

#### 1.8.0_222

_Environment:_
* JAVA_HOME: location of JDK
* PATH: contains bin folder of JDK

#### 1.7.0_232

_Location:_ C:\Program Files\Java\zulu-7-azure-jdk_7.31.0.5-7.0.232-win_x64

#### 11.0.4

_Location:_ C:\Program Files\Java\zulu-11-azure-jdk_11.33.15-11.0.4-win_x64

## Ant

_Version:_ 1.10.5<br/>
_Environment:_
* PATH: contains location of ant.cmd
* ANT_HOME: location of ant.cmd
* COBERTURA_HOME: location of cobertura-2.1.1.jar

## Maven

_Version:_ 3.6.2<br/>
_Environment:_
* PATH: contains location of mvn.bat
* M2_HOME: Maven installation root

## Gradle

_Version:_ 5.6.2<br/>
_Environment:_
* PATH: contains location of gradle

## Cmake

_Version:_ 3.15.4<br/>
_Environment:_
* PATH: contains location of cmake.exe

## SQL Server Data Tier Application Framework (x64)

_Version:_ 15.0.4538.1<br/>

## .NET Core

The following runtimes and SDKs are installed:

_Environment:_
* PATH: contains location of dotnet.exe

_SDK:_
* 2.2.402 C:\Program Files\dotnet\sdk\2.2.402
* 2.2.401 C:\Program Files\dotnet\sdk\2.2.401
* 2.2.301 C:\Program Files\dotnet\sdk\2.2.301
* 2.2.300 C:\Program Files\dotnet\sdk\2.2.300
* 2.2.206 C:\Program Files\dotnet\sdk\2.2.206
* 2.2.205 C:\Program Files\dotnet\sdk\2.2.205
* 2.2.204 C:\Program Files\dotnet\sdk\2.2.204
* 2.2.203 C:\Program Files\dotnet\sdk\2.2.203
* 2.2.202 C:\Program Files\dotnet\sdk\2.2.202
* 2.2.109 C:\Program Files\dotnet\sdk\2.2.109
* 2.2.108 C:\Program Files\dotnet\sdk\2.2.108
* 2.2.107 C:\Program Files\dotnet\sdk\2.2.107
* 2.2.106 C:\Program Files\dotnet\sdk\2.2.106
* 2.2.105 C:\Program Files\dotnet\sdk\2.2.105
* 2.2.104 C:\Program Files\dotnet\sdk\2.2.104
* 2.2.103 C:\Program Files\dotnet\sdk\2.2.103
* 2.2.102 C:\Program Files\dotnet\sdk\2.2.102
* 2.2.101 C:\Program Files\dotnet\sdk\2.2.101
* 2.2.100 C:\Program Files\dotnet\sdk\2.2.100
* 2.1.802 C:\Program Files\dotnet\sdk\2.1.802
* 2.1.801 C:\Program Files\dotnet\sdk\2.1.801
* 2.1.701 C:\Program Files\dotnet\sdk\2.1.701
* 2.1.700 C:\Program Files\dotnet\sdk\2.1.700
* 2.1.606 C:\Program Files\dotnet\sdk\2.1.606
* 2.1.605 C:\Program Files\dotnet\sdk\2.1.605
* 2.1.604 C:\Program Files\dotnet\sdk\2.1.604
* 2.1.603 C:\Program Files\dotnet\sdk\2.1.603
* 2.1.602 C:\Program Files\dotnet\sdk\2.1.602
* 2.1.509 C:\Program Files\dotnet\sdk\2.1.509
* 2.1.508 C:\Program Files\dotnet\sdk\2.1.508
* 2.1.507 C:\Program Files\dotnet\sdk\2.1.507
* 2.1.506 C:\Program Files\dotnet\sdk\2.1.506
* 2.1.505 C:\Program Files\dotnet\sdk\2.1.505
* 2.1.504 C:\Program Files\dotnet\sdk\2.1.504
* 2.1.503 C:\Program Files\dotnet\sdk\2.1.503
* 2.1.502 C:\Program Files\dotnet\sdk\2.1.502
* 2.1.500 C:\Program Files\dotnet\sdk\2.1.500
* 2.1.403 C:\Program Files\dotnet\sdk\2.1.403
* 2.1.402 C:\Program Files\dotnet\sdk\2.1.402
* 2.1.401 C:\Program Files\dotnet\sdk\2.1.401
* 2.1.302 C:\Program Files\dotnet\sdk\2.1.302
* 2.1.301 C:\Program Files\dotnet\sdk\2.1.301
* 2.1.300 C:\Program Files\dotnet\sdk\2.1.300
* 2.1.202 C:\Program Files\dotnet\sdk\2.1.202
* 1.1.14 C:\Program Files\dotnet\sdk\1.1.14

_Runtime:_
* 2.2.7 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.7
* 2.2.6 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.6
* 2.2.5 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.5
* 2.2.4 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.4
* 2.2.3 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.3
* 2.2.2 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.2
* 2.2.1 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.1
* 2.2.0 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.2.0
* 2.1.9 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.9
* 2.1.8 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.8
* 2.1.7 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.7
* 2.1.6 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.6
* 2.1.5 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.5
* 2.1.4 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.4
* 2.1.3 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.3
* 2.1.2 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.2
* 2.1.13 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.13
* 2.1.12 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.12
* 2.1.11 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.11
* 2.1.10 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.10
* 2.1.1 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.1
* 2.1.0 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.1.0
* 2.0.9 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\2.0.9
* 1.1.13 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\1.1.13
* 1.0.16 C:\Program Files\dotnet\shared\Microsoft.NETCore.App\1.0.16

## Mysql

_Version:_ 5.7.21.0<br/>
_Environment:_
* PATH: contains location of mysql.exe

## SQLPS

_Version:_ 1.0

## SQLServer PS

_Version:_ 21.1.18179

## MinGW

_Version:_ 8.1.0<br/>
_Environment:_
* PATH: contains location of the MinGW 'bin' directory

## TypeScript

_Version:_ Version 3.6.3<br/>

## Miniconda

_Version:_ conda 4.6.14<br/>
_Environment:_
* CONDA: contains location of the root of the Miniconda installation

## Azure CosmosDb Emulator

_Version:_ 2.5.7.0<br/>
_Location:_ C:\Program Files\Azure Cosmos DB Emulator\

## 7zip

_Version:_ 19.00<br/>

## Mercurial

_Version:_ <br/>

## jq

_Version:_ jq-1.6<br/>

## Inno Setup

_Version:_ 6.0.2<br/>

## Perl

_Version:_ v5.26.2<br/>

## GitVersion

_Version:_ 5.0.1.0<br/>

## OpenSSL

_Version:_ 1.1.1c at C:\Program Files\Git\usr\bin\openssl.exe<br/>_Version:_ 1.1.1c at C:\Program Files\Git\mingw64\bin\openssl.exe<br/>_Version:_ 1.0.2j at C:\Program Files (x86)\Subversion\bin\openssl.exe<br/>_Version:_ 1.1.1b at C:\Strawberry\c\bin\openssl.exe<br/>_Version:_ 1.1.1 at C:\Program Files\OpenSSL\bin\openssl.exe<br/>

## Cloud Foundry CLI

_Version:_ 6.46.1<br/>

## Vcpkg

_Version:_ 2019.09.12-nohash<br/>
_Environment:_
* PATH: contains location of the vcpkg directory
* VCPKG_INSTALLATION_ROOT: root directory of the vcpkg installation
