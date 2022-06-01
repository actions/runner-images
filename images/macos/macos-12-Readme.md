| Announcements |
|-|
| [[macOS] Default Visual studio for mac will be changed to version 2022 for macOS 11&12 on May, 30](https://github.com/actions/virtual-environments/issues/5601) |
| [[all OSs] Android NDK 22 will be replaced in favor of 24, version 23 will be set as the default one on June, 6](https://github.com/actions/virtual-environments/issues/5595) |
| [macOS 12 (Monterey) is available as a public beta in GitHub Actions and Azure DevOps](https://github.com/actions/virtual-environments/issues/5446) |
***
# macOS 12.4 info
- System Version: macOS 12.4 (21F79)
- Kernel Version: Darwin 21.5.0
- Image Version: 20220531.1

## Installed Software
### Language and Runtime
- .NET SDK 3.1.101 3.1.201 3.1.302 3.1.419 5.0.102 5.0.202 5.0.302 5.0.408
- Bash 3.2.57(1)-release
- Clang/LLVM 13.0.1 is available on `'$(brew --prefix llvm)/bin/clang'`
- Clang/LLVM 13.1.6 is default
- gcc-11 (Homebrew GCC 11.3.0_1) 11.3.0 - available by `gcc-11` alias
- GNU Fortran (Homebrew GCC 11.3.0_1) 11.3.0 - available by `gfortran-11` alias
- Go 1.17.10
- julia 1.7.3
- Kotlin 1.6.21-release-334
- MSBuild 16.10.1.17201 (from /Library/Frameworks/Mono.framework/Versions/6.12.0/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node.js v16.15.0
- NVM 0.39.1
- NVM - Cached node versions: v12.22.12 v14.19.3 v16.15.0
- Perl 5.34.0
- PHP 8.1.6
- Python 2.7.18
- Python 3.9.13
- R 4.2.0
- Ruby 3.0.4p208

### Package Management
- Bundler version 2.3.14
- Carthage 0.38.0
- CocoaPods 1.11.3
- Composer 2.3.5
- Homebrew 3.4.11
- NPM 8.5.5
- NuGet 5.9.0.7134
- Pip 20.3.4 (python 2.7)
- Pip 22.1.1 (python 3.9)
- Pipx 1.1.0
- RubyGems 3.2.33
- Vcpkg 2022 (build from master \<f78f4440d>)
- Yarn 1.22.19

### Project Management
- Apache Ant(TM) 1.10.12
- Apache Maven 3.8.5
- Gradle 7.4.2
- Sbt 1.6.2

### Utilities
- 7-Zip 17.04
- aria2 1.36.0
- azcopy 10.15.0
- bazel 5.1.1
- bazelisk 1.11.0
- bsdtar 3.5.1 - available by 'tar' alias
- Curl 7.83.1
- Git 2.36.1
- Git LFS: 3.2.0
- GitHub CLI: 2.11.3
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.3
- gpg (GnuPG) 2.3.6
- Hub CLI: 2.14.2
- ImageMagick 7.1.0-33
- jq 1.6
- mongo v5.0.7
- mongod v5.0.7
- OpenSSL 1.1.1o  3 May 2022 `(/usr/local/opt/openssl@1.1 -> ../Cellar/openssl@1.1/1.1.1o)`
- Packer 1.8.1
- PostgreSQL 14.3
- psql (PostgreSQL) 14.3
- Sox 14.4.2
- Subversion (SVN) 1.14.2
- Switchaudio-osx 1.1.0
- VirtualBox 6.1.34r150636
- yq (https://github.com/mikefarah/yq/) version 4.25.2
- zstd 1.5.2

### Tools
- App Center CLI 2.10.10
- AWS CLI 2.7.4
- AWS SAM CLI 1.51.0
- AWS Session Manager CLI 1.2.331.0
- Azure CLI (azure-devops) 0.25.0
- Azure CLI 2.37.0
- Bicep CLI 0.6.18
- Cabal 3.6.2.0
- Cmake 3.23.2
- Fastlane 2.206.2
- GHC 9.2.3
- GHCup 0.1.17.8
- Jazzy 0.14.2
- Stack 2.7.5
- SwiftFormat 0.49.9
- Swig 4.0.2
- Xcode Command Line Tools 13.4.0.0.1.1651278267

### Linters
- SwiftLint 0.47.1
- yamllint 1.26.3

### Browsers
- Safari 15.5 (17613.2.7.1.8)
- SafariDriver 15.5 (17613.2.7.1.8)
- Google Chrome 102.0.5005.61 
- ChromeDriver 102.0.5005.61
- Microsoft Edge 102.0.1245.30 
- Microsoft Edge WebDriver 102.0.1245.2
- Mozilla Firefox 101.0
- geckodriver 0.31.0
- Selenium server 4.2.0

#### Environment variables
| Name            | Value                                          |
| --------------- | ---------------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/Caskroom/chromedriver/102.0.5005.61 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver                   |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin                 |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.332+9 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.15+10          | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.3+7            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.1.0 | GRAALVM_11_ROOT       |

### Cached Tools
#### Ruby
- 2.7.6
- 3.0.4
- 3.1.2

#### Python
- 3.7.13
- 3.8.12
- 3.9.13
- 3.10.4

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Node.js
- 12.22.12
- 14.19.3
- 16.15.0

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.16.15 | x64          | GOROOT_1_16_X64      |
| 1.17.10 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.2  | x64          | GOROOT_1_18_X64      |

### Rust Tools
- Cargo 1.61.0
- Rust 1.61.0
- Rustdoc 1.61.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo-audit 0.17.0
- Cargo-outdated 0.11.1
- Cbindgen 0.23.0
- Clippy 0.1.61
- Rustfmt 1.4.38-stable

### PowerShell Tools
- PowerShell 7.2.4

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| Az               | 8.0.0   |
| MarkdownPS       | 1.9     |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.20.0  |

### Web Servers
| Name  | Version  | ConfigFile                      | ServiceStatus | ListenPort |
| ----- | -------- | ------------------------------- | ------------- | ---------- |
| httpd | 2.4.53_2 | /usr/local/etc/httpd/httpd.conf | none          | 80         |
| nginx | 1.21.6_1 | /usr/local/etc/nginx/nginx.conf | none          | 80         |

### Xamarin
#### Visual Studio for Mac
| Version        | Build     | Path                                 |
| -------------- | --------- | ------------------------------------ |
| 2019           | 8.10.23.7 | /Applications/Visual Studio 2019.app |
| 2022 (default) | 17.0.1.72 | /Applications/Visual Studio.app      |

#### Xamarin bundles
| symlink           | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ----------------- | ------------ | ----------- | ----------- | --------------- |
| 6_12_16 (default) | 6.12         | 15.8        | 8.8         | 12.2            |
| 6_12_15           | 6.12         | 15.8        | 8.8         | 12.1            |
| 6_12_14           | 6.12         | 15.8        | 8.8         | 12.0            |
| 6_12_13           | 6.12         | 15.6        | 8.6         | 12.0            |
| 6_12_12           | 6.12         | 15.4        | 8.4         | 12.0            |
| 6_12_11           | 6.12         | 15.2        | 8.2         | 12.0            |
| 6_12_10           | 6.12         | 15.0        | 7.14        | 11.3            |

#### Unit Test Framework
- NUnit 3.6.1

### Xcode
| Version          | Build    | Path                           |
| ---------------- | -------- | ------------------------------ |
| 13.4             | 13F17a   | /Applications/Xcode_13.4.app   |
| 13.3.1 (default) | 13E500a  | /Applications/Xcode_13.3.1.app |
| 13.2.1           | 13C100   | /Applications/Xcode_13.2.1.app |
| 13.1             | 13A1030d | /Applications/Xcode_13.1.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.0

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version |
| ----------------------- | -------------------- | ------------- |
| macOS 12.0              | macosx12.0           | 13.1          |
| macOS 12.1              | macosx12.1           | 13.2.1        |
| macOS 12.3              | macosx12.3           | 13.3.1, 13.4  |
| iOS 15.0                | iphoneos15.0         | 13.1          |
| iOS 15.2                | iphoneos15.2         | 13.2.1        |
| iOS 15.4                | iphoneos15.4         | 13.3.1        |
| iOS 15.5                | iphoneos15.5         | 13.4          |
| Simulator - iOS 15.0    | iphonesimulator15.0  | 13.1          |
| Simulator - iOS 15.2    | iphonesimulator15.2  | 13.2.1        |
| Simulator - iOS 15.4    | iphonesimulator15.4  | 13.3.1        |
| Simulator - iOS 15.5    | iphonesimulator15.5  | 13.4          |
| tvOS 15.0               | appletvos15.0        | 13.1          |
| tvOS 15.2               | appletvos15.2        | 13.2.1        |
| tvOS 15.4               | appletvos15.4        | 13.3.1, 13.4  |
| Simulator - tvOS 15.0   | appletvsimulator15.0 | 13.1          |
| Simulator - tvOS 15.2   | appletvsimulator15.2 | 13.2.1        |
| Simulator - tvOS 15.4   | appletvsimulator15.4 | 13.3.1, 13.4  |
| watchOS 8.0             | watchos8.0           | 13.1          |
| watchOS 8.3             | watchos8.3           | 13.2.1        |
| watchOS 8.5             | watchos8.5           | 13.3.1, 13.4  |
| Simulator - watchOS 8.0 | watchsimulator8.0    | 13.1          |
| Simulator - watchOS 8.3 | watchsimulator8.3    | 13.2.1        |
| Simulator - watchOS 8.5 | watchsimulator8.5    | 13.3.1, 13.4  |
| DriverKit 21.0.1        | driverkit21.0.1      | 13.1          |
| DriverKit 21.2          | driverkit21.2        | 13.2.1        |
| DriverKit 21.4          | driverkit21.4        | 13.3.1, 13.4  |

#### Installed Simulators
| OS          | Xcode Version  | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ----------- | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 15.0    | 13.1           | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                            |
| iOS 15.2    | 13.2.1         | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                            |
| iOS 15.4    | 13.3.1         | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| iOS 15.5    | 13.4           | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| tvOS 15.0   | 13.1           | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 15.2   | 13.2.1         | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 15.4   | 13.3.1<br>13.4 | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| watchOS 8.0 | 13.1           | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 8.3 | 13.2.1         | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 8.5 | 13.3.1<br>13.4 | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                    |

### Android
| Package Name               | Version                                                                                                                                      |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 7.0                                                                                                                                          |
| Android Emulator           | 31.2.10                                                                                                                                      |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)             |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                       |
| Android Support Repository | 47.0.0                                                                                                                                       |
| CMake                      | 3.18.1                                                                                                                                       |
| Google Play services       | 49                                                                                                                                           |
| Google Repository          | 58                                                                                                                                           |
| NDK                        | 21.4.7075529 (default)<br>22.1.7171670<br>23.2.8568313                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                            |

#### Environment variables
| Name                    | Value                                                                                              |
| ----------------------- | -------------------------------------------------------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                                                                  |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk-bundle -> /Users/runner/Library/Android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/23.2.8568313                                                 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk-bundle -> /Users/runner/Library/Android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                                                                  |

### Miscellaneous
- libXext 1.3.4
- libXft 2.3.4
- Tcl/Tk 8.6.12
- Zlib 1.2.12



