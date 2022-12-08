| Announcements |
|-|
| [macOS-latest workflows will use macOS-12](https://github.com/actions/runner-images/issues/6384) |
| [[all OSs] The VCPKG_ROOT variable will be removed from runner images](https://github.com/actions/runner-images/issues/6376) |
| [The macOS 10.15 Actions runner image will begin deprecation on 5/31/22 and will be fully unsupported by 12/1/22 for GitHub and ADO](https://github.com/actions/runner-images/issues/5583) |
***
# macOS 10.15 info
- System Version: macOS 10.15.7 (19H2026)
- Kernel Version: Darwin 19.6.0
- Image Version: 20221018.1

## Installed Software
### Language and Runtime
- .NET SDK 3.1.101 3.1.201 3.1.302 3.1.424 5.0.102 5.0.202 5.0.302 5.0.408
- Bash 3.2.57(1)-release
- Clang/LLVM 12.0.0 is default
- Clang/LLVM 14.0.6 is available on `'$(brew --prefix llvm@14)/bin/clang'`
- gcc-9 (Homebrew GCC 9.5.0) 9.5.0 - available by `gcc-9` alias
- gcc-10 (Homebrew GCC 10.4.0) 10.4.0 - available by `gcc-10` alias
- gcc-11 (Homebrew GCC 11.3.0) 11.3.0 - available by `gcc-11` alias
- GNU Fortran (Homebrew GCC 9.5.0) 9.5.0 - available by `gfortran-9` alias
- GNU Fortran (Homebrew GCC 10.4.0) 10.4.0 - available by `gfortran-10` alias
- GNU Fortran (Homebrew GCC 11.3.0) 11.3.0 - available by `gfortran-11` alias
- Go 1.17.13
- julia 1.8.2
- Kotlin 1.7.20-release-201
- MSBuild 16.10.1.31401 (from /Library/Frameworks/Mono.framework/Versions/6.12.0/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node.js v16.18.0
- NVM 0.39.2
- NVM - Cached node versions: v12.22.12 v14.20.1 v16.18.0
- Perl 5.36.0
- PHP 8.1.11
- Python 2.7.18
- Python 3.10.8
- R 4.2.1
- Ruby 2.7.6p219

### Package Management
- Bundler version 2.3.24
- Carthage 0.38.0
- CocoaPods 1.11.3
- Composer 2.4.3
- Homebrew 3.6.6
- Miniconda 4.12.0
- NPM 8.19.2
- NuGet 6.2.1.2
- Pip 20.3.4 (python 2.7)
- Pip 22.2.2 (python 3.10)
- Pipx 1.1.0
- RubyGems 3.3.24
- Vcpkg 2022 (build from master \<f4b262b25>)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/local/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |
| VCPKG_ROOT              | /usr/local/share/vcpkg |

### Project Management
- Apache Ant(TM) 1.10.12
- Apache Maven 3.8.6
- Gradle 7.5.1
- Sbt 1.7.2

### Utilities
- 7-Zip 17.04
- aria2 1.36.0
- azcopy 10.16.1
- bazel 5.3.1
- bazelisk 1.14.0
- bsdtar 3.3.2 - available by 'tar' alias
- Curl 7.85.0
- Git 2.38.1
- Git LFS: 3.2.0
- GitHub CLI: 2.18.0
- GNU parallel 20220922
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.3
- gpg (GnuPG) 2.3.8
- helm v3.10.1+g9f88ccb
- Hub CLI: 2.14.2
- ImageMagick 7.1.0-51
- jq 1.6
- mongo v5.0.11
- mongod v5.0.11
- Newman 5.3.2
- OpenSSL 1.1.1q  5 Jul 2022 `(/usr/local/opt/openssl@1.1 -> ../Cellar/openssl@1.1/1.1.1q)`
- Packer 1.8.3
- PostgreSQL 14.5 (Homebrew)
- psql (PostgreSQL) 14.5 (Homebrew)
- Sox 14.4.2
- Subversion (SVN) 1.14.2
- Switchaudio-osx 1.1.0
- Vagrant 2.3.1
- VirtualBox 6.1.38r153438
- yq (https://github.com/mikefarah/yq/) version 4.28.1
- zstd 1.5.2

### Tools
- Aliyun CLI 3.0.131
- App Center CLI 2.11.0
- AWS CLI 2.8.3
- AWS SAM CLI 1.60.0
- AWS Session Manager CLI 1.2.398.0
- Azure CLI (azure-devops) 0.25.0
- Azure CLI 2.41.0
- Bicep CLI 0.11.1
- Cabal 3.6.2.0
- Cmake 3.24.2
- Fastlane 2.210.1
- GHC 9.4.2
- GHCup 0.1.18.0
- Jazzy 0.14.3
- Stack 2.9.1
- SwiftFormat 0.50.2
- Swig 4.0.2
- Xcode Command Line Tools 12.4.0.0.1.1610135815

### Linters
- SwiftLint 0.48.0
- yamllint 1.28.0

### Browsers
- Safari 15.6.1 (15613.3.9.1.16)
- SafariDriver 15.6.1 (15613.3.9.1.16)
- Google Chrome 106.0.5249.119 
- ChromeDriver 106.0.5249.61
- Microsoft Edge 106.0.1370.47 
- Microsoft Edge WebDriver 106.0.1370.47
- Mozilla Firefox 105.0.3
- geckodriver 0.32.0
- Selenium server 4.5.0

#### Environment variables
| Name            | Value                                          |
| --------------- | ---------------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/Caskroom/chromedriver/106.0.5249.61 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver                   |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin                 |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.345+1 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.16+101         | Eclipse Temurin | JAVA_HOME_11_X64     |
| 12.0.2+10.3         | Adopt OpenJDK   | JAVA_HOME_12_X64     |
| 13.0.2+8.1          | Adopt OpenJDK   | JAVA_HOME_13_X64     |
| 14.0.2+12           | Adopt OpenJDK   | JAVA_HOME_14_X64     |
| 17.0.4+101          | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.2.0 | GRAALVM_11_ROOT       |

### Cached Tools
#### Ruby
- 2.4.10
- 2.5.9
- 2.6.10
- 2.7.6
- 3.0.4

#### Python
- 2.7.18
- 3.6.15
- 3.7.15
- 3.8.14
- 3.9.14
- 3.10.8

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.6.12 [PyPy 7.3.3]
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Node.js
- 12.22.12
- 14.20.1
- 16.17.1

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.16.15 | x64          | GOROOT_1_16_X64      |
| 1.17.13 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.7  | x64          | GOROOT_1_18_X64      |

### Rust Tools
- Cargo 1.64.0
- Rust 1.64.0
- Rustdoc 1.64.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.61.0
- Cargo-audit 0.17.2
- Cargo-outdated 0.11.1
- Cbindgen 0.24.3
- Clippy 0.1.64
- Rustfmt 1.5.1-stable

### PowerShell Tools
- PowerShell 7.2.6

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| Az               | 9.0.1   |
| MarkdownPS       | 1.9     |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.21.0  |

### Web Servers
| Name  | Version  | ConfigFile                      | ServiceStatus | ListenPort |
| ----- | -------- | ------------------------------- | ------------- | ---------- |
| httpd | 2.4.54_1 | /usr/local/etc/httpd/httpd.conf | none          | 80         |
| nginx | 1.23.1   | /usr/local/etc/nginx/nginx.conf | none          | 80         |

### Xamarin
#### Visual Studio for Mac
| Version        | Build     | Path                            |
| -------------- | --------- | ------------------------------- |
| 2019 (default) | 8.10.25.2 | /Applications/Visual Studio.app |

#### Xamarin bundles
| symlink          | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ---------------- | ------------ | ----------- | ----------- | --------------- |
| 6_12_7 (default) | 6.12         | 14.14       | 7.8         | 11.2            |
| 6_12_6           | 6.12         | 14.10       | 7.4         | 11.1            |
| 6_12_5           | 6.12         | 14.8        | 7.2         | 11.1            |
| 6_12_4           | 6.12         | 14.6        | 7.0         | 11.1            |
| 6_12_3           | 6.12         | 14.4        | 6.22        | 11.1            |
| 6_12_2           | 6.12         | 14.2        | 6.20        | 11.0            |
| 6_12_1           | 6.12         | 14.0        | 6.20        | 11.0            |
| 6_12_0           | 6.12         | 13.20       | 6.20        | 11.0            |
| 6_10_0           | 6.10         | 13.18       | 6.18        | 10.3            |
| 6_8_1            | 6.8          | 13.16       | 6.16        | 10.2            |
| 6_8_0            | 6.8          | 13.14       | 6.14        | 10.2            |
| 6_6_1            | 6.6          | 13.10       | 6.10        | 10.1            |
| 6_6_0            | 6.6          | 13.8        | 6.8         | 10.1            |
| 6_4_2            | 6.4          | 13.6        | 6.6         | 10.0            |
| 6_4_1            | 6.4          | 13.4        | 6.4         | 10.0            |
| 6_4_0            | 6.4          | 13.2        | 6.2         | 10.0            |

#### Unit Test Framework
- NUnit 3.6.1

### Xcode
| Version        | Build    | Path                           |
| -------------- | -------- | ------------------------------ |
| 12.4 (default) | 12D4e    | /Applications/Xcode_12.4.app   |
| 12.3           | 12C33    | /Applications/Xcode_12.3.app   |
| 12.2           | 12B45b   | /Applications/Xcode_12.2.app   |
| 12.1.1         | 12A7605b | /Applications/Xcode_12.1.1.app |
| 12.1           | 12A7403  | /Applications/Xcode_12.1.app   |
| 12.0.1         | 12A7300  | /Applications/Xcode_12.app     |
| 11.7           | 11E801a  | /Applications/Xcode_11.7.app   |
| 11.6           | 11E708   | /Applications/Xcode_11.6.app   |
| 11.5           | 11E608c  | /Applications/Xcode_11.5.app   |
| 11.4.1         | 11E503a  | /Applications/Xcode_11.4.1.app |
| 11.3.1         | 11C505   | /Applications/Xcode_11.3.1.app |
| 11.2.1         | 11B500   | /Applications/Xcode_11.2.1.app |
| 10.3           | 10G8     | /Applications/Xcode_10.3.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.1
- Nomad CLI 0.0.2
- Nomad shenzhen CLI 0.14.3

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version                                                  |
| ----------------------- | -------------------- | -------------------------------------------------------------- |
| macOS 10.14             | macosx10.14          | 10.3                                                           |
| macOS 10.15             | macosx10.15          | 11.2.1, 11.3.1, 11.4.1, 11.5, 11.6, 11.7, 12.0.1, 12.1, 12.1.1 |
| macOS 11.0              | macosx11.0           | 12.2                                                           |
| macOS 11.1              | macosx11.1           | 12.3, 12.4                                                     |
| iOS 12.4                | iphoneos12.4         | 10.3                                                           |
| iOS 13.2                | iphoneos13.2         | 11.2.1, 11.3.1                                                 |
| iOS 13.4                | iphoneos13.4         | 11.4.1                                                         |
| iOS 13.5                | iphoneos13.5         | 11.5                                                           |
| iOS 13.6                | iphoneos13.6         | 11.6                                                           |
| iOS 13.7                | iphoneos13.7         | 11.7                                                           |
| iOS 14.0                | iphoneos14.0         | 12.0.1                                                         |
| iOS 14.1                | iphoneos14.1         | 12.1                                                           |
| iOS 14.2                | iphoneos14.2         | 12.1.1, 12.2                                                   |
| iOS 14.3                | iphoneos14.3         | 12.3                                                           |
| iOS 14.4                | iphoneos14.4         | 12.4                                                           |
| Simulator - iOS 12.4    | iphonesimulator12.4  | 10.3                                                           |
| Simulator - iOS 13.2    | iphonesimulator13.2  | 11.2.1, 11.3.1                                                 |
| Simulator - iOS 13.4    | iphonesimulator13.4  | 11.4.1                                                         |
| Simulator - iOS 13.5    | iphonesimulator13.5  | 11.5                                                           |
| Simulator - iOS 13.6    | iphonesimulator13.6  | 11.6                                                           |
| Simulator - iOS 13.7    | iphonesimulator13.7  | 11.7                                                           |
| Simulator - iOS 14.0    | iphonesimulator14.0  | 12.0.1                                                         |
| Simulator - iOS 14.1    | iphonesimulator14.1  | 12.1                                                           |
| Simulator - iOS 14.2    | iphonesimulator14.2  | 12.1.1, 12.2                                                   |
| Simulator - iOS 14.3    | iphonesimulator14.3  | 12.3                                                           |
| Simulator - iOS 14.4    | iphonesimulator14.4  | 12.4                                                           |
| tvOS 12.4               | appletvos12.4        | 10.3                                                           |
| tvOS 13.2               | appletvos13.2        | 11.2.1, 11.3.1                                                 |
| tvOS 13.4               | appletvos13.4        | 11.4.1, 11.5, 11.6, 11.7                                       |
| tvOS 14.0               | appletvos14.0        | 12.0.1, 12.1                                                   |
| tvOS 14.2               | appletvos14.2        | 12.1.1, 12.2                                                   |
| tvOS 14.3               | appletvos14.3        | 12.3, 12.4                                                     |
| Simulator - tvOS 12.4   | appletvsimulator12.4 | 10.3                                                           |
| Simulator - tvOS 13.2   | appletvsimulator13.2 | 11.2.1, 11.3.1                                                 |
| Simulator - tvOS 13.4   | appletvsimulator13.4 | 11.4.1, 11.5, 11.6, 11.7                                       |
| Simulator - tvOS 14.0   | appletvsimulator14.0 | 12.0.1, 12.1                                                   |
| Simulator - tvOS 14.2   | appletvsimulator14.2 | 12.1.1, 12.2                                                   |
| Simulator - tvOS 14.3   | appletvsimulator14.3 | 12.3, 12.4                                                     |
| watchOS 5.3             | watchos5.3           | 10.3                                                           |
| watchOS 6.1             | watchos6.1           | 11.2.1, 11.3.1                                                 |
| watchOS 6.2             | watchos6.2           | 11.4.1, 11.5, 11.6, 11.7                                       |
| watchOS 7.0             | watchos7.0           | 12.0.1, 12.1                                                   |
| watchOS 7.1             | watchos7.1           | 12.1.1, 12.2                                                   |
| watchOS 7.2             | watchos7.2           | 12.3, 12.4                                                     |
| Simulator - watchOS 5.3 | watchsimulator5.3    | 10.3                                                           |
| Simulator - watchOS 6.1 | watchsimulator6.1    | 11.2.1, 11.3.1                                                 |
| Simulator - watchOS 6.2 | watchsimulator6.2    | 11.4.1, 11.5, 11.6, 11.7                                       |
| Simulator - watchOS 7.0 | watchsimulator7.0    | 12.0.1, 12.1                                                   |
| Simulator - watchOS 7.1 | watchsimulator7.1    | 12.1.1, 12.2                                                   |
| Simulator - watchOS 7.2 | watchsimulator7.2    | 12.3, 12.4                                                     |
| DriverKit 19.0          | driverkit.macosx19.0 | 11.2.1, 11.3.1, 11.4.1, 11.5, 11.6, 11.7, 12.0.1, 12.1, 12.1.1 |
| DriverKit 20.0          | driverkit.macosx20.0 | 12.2                                                           |
| DriverKit 20.2          | driverkit.macosx20.2 | 12.3, 12.4                                                     |

#### Installed Simulators
| OS          | Xcode Version                  | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ----------- | ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 12.4    | 10.3                           | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE<br>iPhone X<br>iPhone XR<br>iPhone Xs<br>iPhone Xs Max<br>iPad (5th generation)<br>iPad (6th generation)<br>iPad Air<br>iPad Air (3rd generation)<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch) |
| iOS 13.2    | 11.2.1                         | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                    |
| iOS 13.3    | 11.3.1                         | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                    |
| iOS 13.4    | 11.4.1                         | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                     |
| iOS 13.5    | 11.5                           | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                     |
| iOS 13.6    | 11.6                           | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                     |
| iOS 13.7    | 11.7                           | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                     |
| iOS 14.0    | 12.0.1                         | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                |
| iOS 14.1    | 12.1                           | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                           |
| iOS 14.2    | 12.1.1<br>12.2                 | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                           |
| iOS 14.3    | 12.3                           | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                           |
| iOS 14.4    | 12.4                           | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                           |
| tvOS 12.4   | 10.3                           | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 13.2   | 11.2.1                         | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 13.3   | 11.3.1                         | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 13.4   | 11.4.1<br>11.5<br>11.6<br>11.7 | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 14.0   | 12.0.1<br>12.1                 | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 14.2   | 12.1.1<br>12.2                 | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 14.3   | 12.3<br>12.4                   | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| watchOS 5.3 | 10.3                           | Apple Watch Series 2 - 38mm<br>Apple Watch Series 2 - 42mm<br>Apple Watch Series 3 - 38mm<br>Apple Watch Series 3 - 42mm<br>Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 6.1 | 11.2.1<br>11.3.1               | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm                                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 6.2 | 11.4.1<br>11.5<br>11.6<br>11.7 | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm                                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 7.0 | 12.0.1<br>12.1                 | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 7.1 | 12.1.1<br>12.2                 | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 7.2 | 12.3<br>12.4                   | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                      |

### Android
| Package Name               | Version                                                                                                                                                                                                                                             |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 7.0                                                                                                                                                                                                                                                 |
| Android Emulator           | 31.3.12                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)                            |
| Android SDK Platform-Tools | 33.0.3                                                                                                                                                                                                                                              |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                              |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                    |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                            |
| Google Play services       | 49                                                                                                                                                                                                                                                  |
| Google Repository          | 58                                                                                                                                                                                                                                                  |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.1.8937393 (default)                                                                                                                                                                                              |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                   |
| Intel HAXM                 | 7.6.5                                                                                                                                                                                                                                               |

#### Environment variables
| Name                    | Value                                              |
| ----------------------- | -------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                  |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/25.1.8937393 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/25.1.8937393 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                  |

### Miscellaneous
- libXext 1.3.4
- libXft 2.3.6
- Tcl/Tk 8.6.12_1
- Zlib 1.2.13



