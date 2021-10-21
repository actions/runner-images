| Announcements |
|-|
| [[macOS] Xcode 12.5 will be removed from Big Sur on October, 18](https://github.com/actions/virtual-environments/issues/4183) |
| [[macOS] Default Xcode on Big Sur image will be set to Xcode 13.0 on October, 18](https://github.com/actions/virtual-environments/issues/4180) |
| [macOS-latest workflows will use macOS-11](https://github.com/actions/virtual-environments/issues/4060) |
***
# macOS 10.14 info
- System Version: macOS 10.14.6 (18G9323)
- Kernel Version: Darwin 18.7.0
- Image Version: 20211016.1

## Installed Software
### Language and Runtime
- .NET SDK 2.1.302 2.1.403 2.1.507
- Bash 3.2.57(1)-release
- Clang/LLVM 11.0.0 is default
- Clang/LLVM 13.0.0 is available on `'$(brew --prefix llvm)/bin/clang'`
- gcc-9 (Homebrew GCC 9.4.0) 9.4.0 - available by `gcc-9` alias
- gcc-10 (Homebrew GCC 10.3.0) 10.3.0 - available by `gcc-10` alias
- gcc-11 (Homebrew GCC 11.2.0) 11.2.0 - available by `gcc-11` alias
- GNU Fortran (Homebrew GCC 9.4.0) 9.4.0 - available by `gfortran-9` alias
- GNU Fortran (Homebrew GCC 10.3.0) 10.3.0 - available by `gfortran-10` alias
- GNU Fortran (Homebrew GCC 11.2.0) 11.2.0 - available by `gfortran-11` alias
- Go 1.15.15
- julia 1.6.3
- Kotlin 1.5.31-release-548
- MSBuild 15.7.224.30163 (from /Library/Frameworks/Mono.framework/Versions/5.12.0/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node.js v8.17.0
- NVM 0.39.0
- NVM - Cached node versions: v10.24.1 v12.22.7 v14.18.1
- Perl 5.34.0
- PHP 8.0.11
- Python 2.7.18
- Python 3.9.7
- R 4.1.1
- Ruby 2.7.4p191

### Package Management
- Bundler version 2.2.29
- Carthage 0.38.0
- CocoaPods 1.11.2
- Composer 2.1.9
- Homebrew 3.2.16
- Miniconda 4.10.3
- NPM 3.10.10
- NuGet 4.7.0.5148
- Pip 20.3.4 (python 2.7)
- Pip 21.2.4 (python 3.9)
- Pipx 0.16.4
- RubyGems 3.2.29
- Yarn 1.22.15

#### Environment variables
| Name                    | Value                |
| ----------------------- | -------------------- |
| CONDA                   | /usr/local/miniconda |
| VCPKG_INSTALLATION_ROOT |                      |

### Project Management
- Apache Ant(TM) 1.10.11
- Apache Maven 3.8.3
- Gradle 7.2
- Sbt 1.5.5

### Utilities
- 7-Zip 17.04
- aria2 1.36.0
- azcopy 10.12.2
- bazel 3.7.1
- bazelisk 1.10.1
- bsdtar 2.8.3 - available by 'tar' alias
- Curl 7.79.1
- Git LFS: 3.0.1
- Git: 2.33.1
- GitHub CLI: 2.1.0
- GNU parallel 20210922
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.2
- gpg (GnuPG) 2.3.2
- helm v3.7.1+g1d11fcb
- Hub CLI: 2.14.2
- jq 1.6
- mongo v5.0.3
- mongod v5.0.3
- OpenSSL 1.1.1l  24 Aug 2021 `(/usr/local/opt/openssl@1.1 -> /usr/local/Cellar/openssl@1.1/1.1.1l_1)`
- Packer 1.7.6
- PostgreSQL 14.0
- psql (PostgreSQL) 14.0
- Sox 14.4.2
- Subversion (SVN) 1.14.1
- Switchaudio-osx 1.1.0
- Vagrant 2.2.18
- virtualbox 6.1.26r145957
- zstd 1.5.0


### Tools
- Aliyun CLI 3.0.94
- App Center CLI 1.2.2
- AWS CLI 2.2.46
- AWS SAM CLI 1.33.0
- AWS Session Manager CLI 1.2.245.0
- Azure CLI 2.29.0
- Bicep CLI 0.4.1008
- Cabal 3.4.1.0
- Cmake 3.21.3
- Fastlane 2.196.0
- GHC 9.0.1
- GHCup 0.1.17.2
- Stack 2.7.3
- SwiftFormat 0.48.16
- Swig 4.0.2
- Xcode Command Line Tools 10.3.0.0.1.1562985497

### Linters
- SwiftLint 0.44.0
- yamllint 1.26.3

### Browsers
- Safari 14.1.2 (14611.3.10.1.5)
- SafariDriver 14.1.2 (14611.3.10.1.5)
- Google Chrome 94.0.4606.81 
- ChromeDriver 94.0.4606.61
- Microsoft Edge 94.0.992.50 
- MSEdgeDriver 94.0.992.50
- Mozilla Firefox 93.0
- geckodriver 0.30.0

#### Environment variables
| Name            | Value                                         |
| --------------- | --------------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/Caskroom/chromedriver/94.0.4606.61 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver                  |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin                |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.302+8 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.12+7           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 12.0.2+10.3         | Adopt OpenJDK   | JAVA_HOME_12_X64     |
| 13.0.2+8.1          | Adopt OpenJDK   | JAVA_HOME_13_X64     |
| 14.0.2+12           | Adopt OpenJDK   | JAVA_HOME_14_X64     |
| 17.0.0+35           | Eclipse Temurin | JAVA_HOME_17_X64     |

### Cached Tools
#### Ruby
- 2.4.10
- 2.5.9
- 2.6.8
- 2.7.4
- 3.0.2

#### Python
- 2.7.18
- 3.5.10
- 3.6.15
- 3.7.12
- 3.8.12
- 3.9.7
- 3.10.0

#### PyPy
- 2.7.18 [PyPy 7.3.5]
- 3.6.12 [PyPy 7.3.3]

#### Node.js
- 10.24.1
- 12.22.7
- 14.18.1

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.13.15 | x64          | GOROOT_1_13_X64      |
| 1.14.15 | x64          | GOROOT_1_14_X64      |
| 1.15.15 (Default) | x64          | GOROOT_1_15_X64      |
| 1.16.9  | x64          | GOROOT_1_16_X64      |
| 1.17.2  | x64          | GOROOT_1_17_X64      |
### Rust Tools
- Cargo 1.55.0
- Rust 1.55.0
- Rustdoc 1.55.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.1
- Cargo-audit 0.15.2
- Cargo-outdated v0.9.17
- Cbindgen 0.20.0
- Clippy 0.1.55
- Rustfmt 1.4.37-stable

### PowerShell Tools
- PowerShell 7.1.5

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| Az               | 6.1.0   |
| MarkdownPS       | 1.9     |
| Pester           | 5.3.1   |
| PSScriptAnalyzer | 1.20.0  |

### Xamarin
#### Visual Studio for Mac
- 8.5.0.3183

#### Xamarin bundles
| symlink          | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ---------------- | ------------ | ----------- | ----------- | --------------- |
| 6_8_0            | 6.8          | 13.14       | 6.14        | 10.2            |
| 6_6_1            | 6.6          | 13.10       | 6.10        | 10.1            |
| 6_6_0            | 6.6          | 13.8        | 6.8         | 10.1            |
| 6_4_2            | 6.4          | 13.6        | 6.6         | 10.0            |
| 6_4_1            | 6.4          | 13.4        | 6.4         | 10.0            |
| 6_4_0            | 6.4          | 13.2        | 6.2         | 10.0            |
| 6_0_0            | 6.0          | 12.14       | 5.16        | 9.4             |
| 5_18_3           | 5.18         | 12.10       | 5.10        | 9.3             |
| 5_18_2           | 5.18         | 12.8        | 5.8         | 9.2             |
| 5_18_1           | 5.18         | 12.6        | 5.6         | 9.2             |
| 5_16_0_0         | 5.16         | 12.2        | 5.2         | 9.1             |
| 5_16_0           | 5.16         | 12.2        | 5.2         | 9.1             |
| 5_12_0_3         | 5.12         | 12.2        | 5.3         | 9.0             |
| 5_12_0_XC10_PRE  | 5.12         | 12.0        | 5.2         | 9.0             |
| 5_12_0 (default) | 5.12         | 11.14       | 4.6         | 9.0             |
| 5_10_1           | 5.10         | 11.12       | 4.4         | 8.3             |
| 5_8_1            | 5.8          | 11.9        | 4.2         | 8.2             |
| 5_8_0            | 5.8          | 11.8        | 4.2         | 8.2             |
| 5_4_1            | 5.4          | 11.6        | 4.0         | 8.1             |
| 5_4_0            | 5.4          | 11.2        | 3.8         | 8.0             |
| 5_2_0            | 5.2          | 11.0        | 3.6         | 7.4             |
| Legacy_5_0_1     | 5.0          | 10.10       | 3.4         | 7.3             |
| Legacy_4_8_1     | 4.8          | 10.6        | 3.0         | 7.1             |

#### Unit Test Framework
- NUnit 3.6.1

### Xcode
| Version          | Build   | Path                           |
| ---------------- | ------- | ------------------------------ |
| 11.3.1 (default) | 11C505  | /Applications/Xcode_11.3.1.app |
| 11.3             | 11C29   | /Applications/Xcode_11.3.app   |
| 11.2.1           | 11B500  | /Applications/Xcode_11.2.1.app |
| 11.2             | 11B52   | /Applications/Xcode_11.2.app   |
| 11.1             | 11A1027 | /Applications/Xcode_11.1.app   |
| 11.0             | 11A420a | /Applications/Xcode_11.app     |
| 10.3             | 10G8    | /Applications/Xcode_10.3.app   |
| 10.2.1           | 10E1001 | /Applications/Xcode_10.2.1.app |
| 10.2             | 10E125  | /Applications/Xcode_10.2.app   |
| 10.1             | 10B61   | /Applications/Xcode_10.1.app   |
| 10.0             | 10A255  | /Applications/Xcode_10.app     |
| 9.4.1            | 9F2000  | /Applications/Xcode_9.4.1.app  |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.0
- Nomad CLI 0.0.2
- Nomad shenzhen CLI 0.14.3
- xctool 0.3.7

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version                          |
| ----------------------- | -------------------- | -------------------------------------- |
| macOS 10.13             | macosx10.13          | 9.4.1                                  |
| macOS 10.14             | macosx10.14          | 10.0, 10.1, 10.2, 10.2.1, 10.3         |
| macOS 10.15             | macosx10.15          | 11.0, 11.1, 11.2, 11.2.1, 11.3, 11.3.1 |
| iOS 11.4                | iphoneos11.4         | 9.4.1                                  |
| iOS 12.0                | iphoneos12.0         | 10.0                                   |
| iOS 12.1                | iphoneos12.1         | 10.1                                   |
| iOS 12.2                | iphoneos12.2         | 10.2, 10.2.1                           |
| iOS 12.4                | iphoneos12.4         | 10.3                                   |
| iOS 13.0                | iphoneos13.0         | 11.0                                   |
| iOS 13.1                | iphoneos13.1         | 11.1                                   |
| iOS 13.2                | iphoneos13.2         | 11.2, 11.2.1, 11.3, 11.3.1             |
| Simulator - iOS 11.4    | iphonesimulator11.4  | 9.4.1                                  |
| Simulator - iOS 12.0    | iphonesimulator12.0  | 10.0                                   |
| Simulator - iOS 12.1    | iphonesimulator12.1  | 10.1                                   |
| Simulator - iOS 12.2    | iphonesimulator12.2  | 10.2, 10.2.1                           |
| Simulator - iOS 12.4    | iphonesimulator12.4  | 10.3                                   |
| Simulator - iOS 13.0    | iphonesimulator13.0  | 11.0                                   |
| Simulator - iOS 13.1    | iphonesimulator13.1  | 11.1                                   |
| Simulator - iOS 13.2    | iphonesimulator13.2  | 11.2, 11.2.1, 11.3, 11.3.1             |
| tvOS 11.4               | appletvos11.4        | 9.4.1                                  |
| tvOS 12.0               | appletvos12.0        | 10.0                                   |
| tvOS 12.1               | appletvos12.1        | 10.1                                   |
| tvOS 12.2               | appletvos12.2        | 10.2, 10.2.1                           |
| tvOS 12.4               | appletvos12.4        | 10.3                                   |
| tvOS 13.0               | appletvos13.0        | 11.0, 11.1                             |
| tvOS 13.2               | appletvos13.2        | 11.2, 11.2.1, 11.3, 11.3.1             |
| Simulator - tvOS 11.4   | appletvsimulator11.4 | 9.4.1                                  |
| Simulator - tvOS 12.0   | appletvsimulator12.0 | 10.0                                   |
| Simulator - tvOS 12.1   | appletvsimulator12.1 | 10.1                                   |
| Simulator - tvOS 12.2   | appletvsimulator12.2 | 10.2, 10.2.1                           |
| Simulator - tvOS 12.4   | appletvsimulator12.4 | 10.3                                   |
| Simulator - tvOS 13.0   | appletvsimulator13.0 | 11.0, 11.1                             |
| Simulator - tvOS 13.2   | appletvsimulator13.2 | 11.2, 11.2.1, 11.3, 11.3.1             |
| watchOS 4.3             | watchos4.3           | 9.4.1                                  |
| watchOS 5.0             | watchos5.0           | 10.0                                   |
| watchOS 5.1             | watchos5.1           | 10.1                                   |
| watchOS 5.2             | watchos5.2           | 10.2, 10.2.1                           |
| watchOS 5.3             | watchos5.3           | 10.3                                   |
| watchOS 6.0             | watchos6.0           | 11.0, 11.1                             |
| watchOS 6.1             | watchos6.1           | 11.2, 11.2.1, 11.3, 11.3.1             |
| Simulator - watchOS 4.3 | watchsimulator4.3    | 9.4.1                                  |
| Simulator - watchOS 5.0 | watchsimulator5.0    | 10.0                                   |
| Simulator - watchOS 5.1 | watchsimulator5.1    | 10.1                                   |
| Simulator - watchOS 5.2 | watchsimulator5.2    | 10.2, 10.2.1                           |
| Simulator - watchOS 5.3 | watchsimulator5.3    | 10.3                                   |
| Simulator - watchOS 6.0 | watchsimulator6.0    | 11.0, 11.1                             |
| Simulator - watchOS 6.1 | watchsimulator6.1    | 11.2, 11.2.1, 11.3, 11.3.1             |
| DriverKit 19.0          | driverkit.macosx19.0 | 11.0, 11.1, 11.2, 11.2.1, 11.3, 11.3.1 |

#### Installed Simulators
| OS          | Xcode Version                                                                                       | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ----------- | --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 8.4     | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPad 2<br>iPad Air<br>iPad Retina                                                                                                                                                                                                                                                                                                                                                                                        |
| iOS 9.0     | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Air<br>iPad Air 2<br>iPad Retina                                                                                                                                                                                                                                                                                                                                           |
| iOS 9.1     | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Air<br>iPad Air 2<br>iPad Pro<br>iPad Retina                                                                                                                                                                                                                                                                                                                               |
| iOS 9.2     | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Air<br>iPad Air 2<br>iPad Pro<br>iPad Retina                                                                                                                                                                                                                                                                                                                               |
| iOS 9.3     | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Air<br>iPad Air 2<br>iPad Pro<br>iPad Retina                                                                                                                                                                                                                                                                                                                               |
| iOS 10.0    | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (12.9 inch)<br>iPad Pro (9.7 inch)                                                                                                                                                                                                                                                                                                                     |
| iOS 10.1    | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (12.9 inch)<br>iPad Pro (9.7 inch)                                                                                                                                                                                                                                                                                        |
| iOS 10.2    | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (12.9 inch)<br>iPad Pro (9.7 inch)                                                                                                                                                                                                                                                                                        |
| iOS 10.3    | 9.4.1<br>10.0<br>10.1<br>10.2<br>10.2.1<br>10.3<br>11.0<br>11.1<br>11.2<br>11.2.1<br>11.3<br>11.3.1 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPad (5th generation)<br>iPad Air<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (12.9 inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (9.7 inch)                                                                                                                                                                                              |
| iOS 11.4    | 9.4.1                                                                                               | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE<br>iPhone X<br>iPad (5th generation)<br>iPad Air<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                 |
| iOS 12.0    | 10.0                                                                                                | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE<br>iPhone X<br>iPhone XR<br>iPhone XS<br>iPhone XS Max<br>iPad (5th generation)<br>iPad (6th generation)<br>iPad Air<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (9.7-inch)                                                                                             |
| iOS 12.1    | 10.1                                                                                                | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE<br>iPhone X<br>iPhone XR<br>iPhone XS<br>iPhone XS Max<br>iPad (5th generation)<br>iPad (6th generation)<br>iPad Air<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                              |
| iOS 12.2    | 10.2<br>10.2.1                                                                                      | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE<br>iPhone X<br>iPhone XR<br>iPhone Xs<br>iPhone Xs Max<br>iPad (5th generation)<br>iPad (6th generation)<br>iPad Air<br>iPad Air (3rd generation)<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch) |
| iOS 12.4    | 10.3                                                                                                | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE<br>iPhone X<br>iPhone XR<br>iPhone Xs<br>iPhone Xs Max<br>iPad (5th generation)<br>iPad (6th generation)<br>iPad Air<br>iPad Air (3rd generation)<br>iPad Air 2<br>iPad Pro (10.5-inch)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch) |
| iOS 13.0    | 11.0                                                                                                | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPad Air (3rd generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                                             |
| iOS 13.1    | 11.1                                                                                                | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPad Air (3rd generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                                             |
| iOS 13.2    | 11.2<br>11.2.1                                                                                      | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                    |
| iOS 13.3    | 11.3<br>11.3.1                                                                                      | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                    |
| tvOS 11.4   | 9.4.1                                                                                               | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 12.0   | 10.0                                                                                                | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 12.1   | 10.1                                                                                                | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 12.2   | 10.2<br>10.2.1                                                                                      | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 12.4   | 10.3                                                                                                | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 13.0   | 11.0<br>11.1                                                                                        | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 13.2   | 11.2<br>11.2.1                                                                                      | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| tvOS 13.3   | 11.3<br>11.3.1                                                                                      | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| watchOS 4.3 | 9.4.1                                                                                               | Apple Watch - 38mm<br>Apple Watch - 42mm<br>Apple Watch Series 2 - 38mm<br>Apple Watch Series 2 - 42mm<br>Apple Watch Series 3 - 38mm<br>Apple Watch Series 3 - 42mm                                                                                                                                                                                                                                                                                                                        |
| watchOS 5.0 | 10.0                                                                                                | Apple Watch Series 2 - 38mm<br>Apple Watch Series 2 - 42mm<br>Apple Watch Series 3 - 38mm<br>Apple Watch Series 3 - 42mm<br>Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 5.1 | 10.1                                                                                                | Apple Watch Series 2 - 38mm<br>Apple Watch Series 2 - 42mm<br>Apple Watch Series 3 - 38mm<br>Apple Watch Series 3 - 42mm<br>Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 5.2 | 10.2<br>10.2.1                                                                                      | Apple Watch Series 2 - 38mm<br>Apple Watch Series 2 - 42mm<br>Apple Watch Series 3 - 38mm<br>Apple Watch Series 3 - 42mm<br>Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 5.3 | 10.3                                                                                                | Apple Watch Series 2 - 38mm<br>Apple Watch Series 2 - 42mm<br>Apple Watch Series 3 - 38mm<br>Apple Watch Series 3 - 42mm<br>Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm                                                                                                                                                                                                                                                                                                      |
| watchOS 6.0 | 11.0<br>11.1                                                                                        | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm                                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 6.1 | 11.2<br>11.2.1<br>11.3<br>11.3.1                                                                    | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm                                                                                                                                                                                                                                                                                                                                                                    |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                                                                                                                                                                |
| Android Emulator           | 30.8.4                                                                                                                                                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3<br>22.0.1<br>21.1.2<br>20.0.0<br>19.1.0                                                                                    |
| Android SDK Platforms      | android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)<br>android-22 (rev 2)<br>android-21 (rev 2)<br>android-20 (rev 2)<br>android-19 (rev 4)<br>android-18 (rev 3)<br>android-17 (rev 3)<br>android-16 (rev 5)<br>android-15 (rev 5) |
| Android SDK Platform-Tools | 31.0.3                                                                                                                                                                                                                                                                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                                             |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                                                                                                                                                   |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                                                                                                                           |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                                                 |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                                                 |
| NDK                        | 15.2.4203891<br>18.1.5063045<br>21.4.7075529 (default)<br>22.1.7171670<br>23.0.7599858                                                                                                                                                                                                                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                                                                                                                  |
| Intel HAXM                 | 7.6.5                                                                                                                                                                                                                                                                                                                                                                              |

#### Environment variables
| Name                    | Value                                                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                                                                  |
| ANDROID_NDK_18R_PATH    | /Users/runner/Library/Android/sdk/ndk/18.1.5063045                                                 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk-bundle -> /Users/runner/Library/Android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/23.0.7599858                                                 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk-bundle -> /Users/runner/Library/Android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                                                                  |



