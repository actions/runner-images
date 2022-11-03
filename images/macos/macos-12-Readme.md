| Announcements |
|-|
| [[all OSs] Nodejs 12.x will be removed from the images on November, 14](https://github.com/actions/runner-images/issues/6482) |
| [macOS-latest workflows will use macOS-12](https://github.com/actions/runner-images/issues/6384) |
| [[all OSs] The VCPKG_ROOT variable will be removed from runner images](https://github.com/actions/runner-images/issues/6376) |
| [The macOS 10.15 Actions runner image will begin deprecation on 5/31/22 and will be fully unsupported by 12/1/22 for GitHub and ADO](https://github.com/actions/runner-images/issues/5583) |
***
# macOS 12.6 info
- System Version: macOS 12.6.1 (21G217)
- Kernel Version: Darwin 21.6.0
- Image Version: 20221027.1

## Installed Software
### Language and Runtime
- .NET SDK 3.1.101 3.1.201 3.1.302 3.1.424 5.0.102 5.0.202 5.0.302 5.0.408 6.0.402
- Bash 3.2.57(1)-release
- Clang/LLVM 14.0.0 is default
- Clang/LLVM 14.0.6 is available on `'$(brew --prefix llvm@14)/bin/clang'`
- gcc-11 (Homebrew GCC 11.3.0) 11.3.0 - available by `gcc-11` alias
- GNU Fortran (Homebrew GCC 11.3.0) 11.3.0 - available by `gfortran-11` alias
- Go 1.17.13
- julia 1.8.2
- Kotlin 1.7.20-release-201
- MSBuild 16.10.1.51301 (from /Library/Frameworks/Mono.framework/Versions/6.12.0/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node.js v16.18.0
- NVM 0.39.2
- NVM - Cached node versions: v12.22.12 v14.20.1 v16.18.0
- Perl 5.36.0
- PHP 8.1.11
- Python 2.7.18
- Python 3.11.0
- R 4.2.1
- Ruby 3.0.4p208

### Package Management
- Bundler version 2.3.24
- Carthage 0.38.0
- CocoaPods 1.11.3
- Composer 2.4.3
- Homebrew 3.6.7
- Miniconda 4.12.0
- NPM 8.19.2
- NuGet 6.3.1.1
- Pip 20.3.4 (python 2.7)
- Pip 22.3 (python 3.11)
- Pipx 1.1.0
- RubyGems 3.3.24
- Vcpkg 2022 (build from master \<2de7f388c>)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/local/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Apache Ant(TM) 1.10.12
- Apache Maven 3.8.6
- Gradle 7.5.1
- Sbt 1.7.2

### Utilities
- 7-Zip 17.04
- aria2 1.36.0
- azcopy 10.16.1
- bazel 5.3.2
- bazelisk 1.14.0
- bsdtar 3.5.1 - available by 'tar' alias
- Curl 7.85.0
- Git 2.38.1
- Git LFS: 3.2.0
- GitHub CLI: 2.18.1
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.3
- gpg (GnuPG) 2.3.8
- Hub CLI: 2.14.2
- ImageMagick 7.1.0-51
- jq 1.6
- mongo v5.0.11
- mongod v5.0.11
- OpenSSL 1.1.1q  5 Jul 2022 `(/usr/local/opt/openssl@1.1 -> ../Cellar/openssl@1.1/1.1.1q)`
- Packer 1.8.3
- PostgreSQL 14.5 (Homebrew)
- psql (PostgreSQL) 14.5 (Homebrew)
- Sox 14.4.2
- Subversion (SVN) 1.14.2
- Switchaudio-osx 1.1.0
- Vagrant 2.3.2
- VirtualBox 6.1.38r153438
- yq (https://github.com/mikefarah/yq/) version 4.28.2
- zstd 1.5.2

### Tools
- App Center CLI 2.11.0
- AWS CLI 2.8.6
- AWS SAM CLI 1.61.0
- AWS Session Manager CLI 1.2.398.0
- Azure CLI (azure-devops) 0.25.0
- Azure CLI 2.41.0
- Bicep CLI 0.11.1
- Cabal 3.6.2.0
- Cmake 3.24.2
- CodeQL Action Bundle 2.11.2
- Colima 0.4.6
- Fastlane 2.210.1
- GHC 9.4.2
- GHCup 0.1.18.0
- Jazzy 0.14.3
- Stack 2.9.1
- SwiftFormat 0.50.3
- Swig 4.0.2
- Xcode Command Line Tools 14.0.0.0.1.1661618636

### Linters
- SwiftLint 0.49.1
- yamllint 1.28.0

### Browsers
- Safari 16.1 (17614.2.9.1.13)
- SafariDriver 16.1 (17614.2.9.1.13)
- Google Chrome 107.0.5304.87 
- ChromeDriver 107.0.5304.62
- Microsoft Edge 107.0.1418.24 
- Microsoft Edge WebDriver 107.0.1418.23
- Mozilla Firefox 106.0.2
- geckodriver 0.32.0
- Selenium server 4.5.0

#### Environment variables
| Name            | Value                                          |
| --------------- | ---------------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/Caskroom/chromedriver/107.0.5304.62 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver                   |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin                 |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.345+1 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.16+101         | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.4+101          | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.3.0 | GRAALVM_11_ROOT       |

### Cached Tools
#### Ruby
- 2.7.6
- 3.0.4
- 3.1.2

#### Python
- 3.7.15
- 3.8.14
- 3.9.14
- 3.10.8
- 3.11.0

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Node.js
- 12.22.12
- 14.20.1
- 16.18.0
- 18.12.0

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.17.13 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.7  | x64          | GOROOT_1_18_X64      |
| 1.19.2  | x64          | GOROOT_1_19_X64      |

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
- PowerShell 7.2.7

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
| nginx | 1.23.2   | /usr/local/etc/nginx/nginx.conf | none          | 80         |

### Xamarin
#### Visual Studio for Mac
| Version        | Build     | Path                                 |
| -------------- | --------- | ------------------------------------ |
| 2019           | 8.10.25.2 | /Applications/Visual Studio 2019.app |
| 2022 (default) | 17.3.8.5  | /Applications/Visual Studio.app      |

##### Notes:
```
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
```

#### Xamarin bundles
| symlink           | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ----------------- | ------------ | ----------- | ----------- | --------------- |
| 6_12_20 (default) | 6.12         | 16.0        | 8.12        | 13.0            |
| 6_12_19           | 6.12         | 15.12       | 8.12        | 13.0            |
| 6_12_18           | 6.12         | 15.10       | 8.10        | 12.3            |
| 6_12_17           | 6.12         | 15.10       | 8.10        | 12.2            |
| 6_12_16           | 6.12         | 15.8        | 8.8         | 12.2            |
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
| 14.1             | 14B47b   | /Applications/Xcode_14.1.app   |
| 14.0.1 (default) | 14A400   | /Applications/Xcode_14.0.1.app |
| 14.0             | 14A309   | /Applications/Xcode_14.0.app   |
| 13.4.1           | 13F100   | /Applications/Xcode_13.4.1.app |
| 13.4             | 13F17a   | /Applications/Xcode_13.4.app   |
| 13.3.1           | 13E500a  | /Applications/Xcode_13.3.1.app |
| 13.2.1           | 13C100   | /Applications/Xcode_13.2.1.app |
| 13.1             | 13A1030d | /Applications/Xcode_13.1.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.1

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version                      |
| ----------------------- | -------------------- | ---------------------------------- |
| macOS 12.0              | macosx12.0           | 13.1                               |
| macOS 12.1              | macosx12.1           | 13.2.1                             |
| macOS 12.3              | macosx12.3           | 13.3.1, 13.4, 13.4.1, 14.0, 14.0.1 |
| macOS 13.0              | macosx13.0           | 14.1                               |
| iOS 15.0                | iphoneos15.0         | 13.1                               |
| iOS 15.2                | iphoneos15.2         | 13.2.1                             |
| iOS 15.4                | iphoneos15.4         | 13.3.1                             |
| iOS 15.5                | iphoneos15.5         | 13.4, 13.4.1                       |
| iOS 16.0                | iphoneos16.0         | 14.0, 14.0.1                       |
| iOS 16.1                | iphoneos16.1         | 14.1                               |
| Simulator - iOS 15.0    | iphonesimulator15.0  | 13.1                               |
| Simulator - iOS 15.2    | iphonesimulator15.2  | 13.2.1                             |
| Simulator - iOS 15.4    | iphonesimulator15.4  | 13.3.1                             |
| Simulator - iOS 15.5    | iphonesimulator15.5  | 13.4, 13.4.1                       |
| Simulator - iOS 16.0    | iphonesimulator16.0  | 14.0, 14.0.1                       |
| Simulator - iOS 16.1    | iphonesimulator16.1  | 14.1                               |
| tvOS 15.0               | appletvos15.0        | 13.1                               |
| tvOS 15.2               | appletvos15.2        | 13.2.1                             |
| tvOS 15.4               | appletvos15.4        | 13.3.1, 13.4, 13.4.1               |
| tvOS 16.0               | appletvos16.0        | 14.0, 14.0.1                       |
| tvOS 16.1               | appletvos16.1        | 14.1                               |
| Simulator - tvOS 15.0   | appletvsimulator15.0 | 13.1                               |
| Simulator - tvOS 15.2   | appletvsimulator15.2 | 13.2.1                             |
| Simulator - tvOS 15.4   | appletvsimulator15.4 | 13.3.1, 13.4, 13.4.1               |
| Simulator - tvOS 16.0   | appletvsimulator16.0 | 14.0, 14.0.1                       |
| Simulator - tvOS 16.1   | appletvsimulator16.1 | 14.1                               |
| watchOS 8.0             | watchos8.0           | 13.1                               |
| watchOS 8.3             | watchos8.3           | 13.2.1                             |
| watchOS 8.5             | watchos8.5           | 13.3.1, 13.4, 13.4.1               |
| watchOS 9.0             | watchos9.0           | 14.0, 14.0.1                       |
| watchOS 9.1             | watchos9.1           | 14.1                               |
| Simulator - watchOS 8.0 | watchsimulator8.0    | 13.1                               |
| Simulator - watchOS 8.3 | watchsimulator8.3    | 13.2.1                             |
| Simulator - watchOS 8.5 | watchsimulator8.5    | 13.3.1, 13.4, 13.4.1               |
| Simulator - watchOS 9.0 | watchsimulator9.0    | 14.0, 14.0.1                       |
| Simulator - watchOS 9.1 | watchsimulator9.1    | 14.1                               |
| DriverKit 21.0.1        | driverkit21.0.1      | 13.1                               |
| DriverKit 21.2          | driverkit21.2        | 13.2.1                             |
| DriverKit 21.4          | driverkit21.4        | 13.3.1, 13.4, 13.4.1, 14.0, 14.0.1 |
| DriverKit 22.1          | driverkit22.1        | 14.1                               |

#### Installed Simulators
| OS          | Xcode Version                                                        | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ----------- | -------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 15.0    | 13.1                                                                 | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                            |
| iOS 15.2    | 13.2.1                                                               | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                            |
| iOS 15.4    | 13.3.1                                                               | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                 |
| iOS 15.5    | 13.4<br>13.4.1                                                       | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                 |
| iOS 16.0    | 14.0<br>14.0.1                                                       | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                            |
| iOS 16.1    | 14.1                                                                 | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro (9.7-inch) |
| tvOS 15.0   | 13.1                                                                 | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 15.2   | 13.2.1                                                               | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 15.4   | 13.3.1<br>13.4<br>13.4.1                                             | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 16.0   | 13.1<br>13.2.1<br>13.3.1<br>13.4<br>13.4.1<br>14.0<br>14.0.1<br>14.1 | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 16.1   | 13.1<br>13.2.1<br>13.3.1<br>13.4<br>13.4.1<br>14.0<br>14.0.1<br>14.1 | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| watchOS 8.0 | 13.1                                                                 | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 - 45mm<br>Apple Watch Series 7 (41mm)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 8.3 | 13.2.1                                                               | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 45mm<br>Apple Watch Series 7 (41mm)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 8.5 | 13.3.1<br>13.4<br>13.4.1                                             | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 7 - 45mm<br>Apple Watch Series 7 (41mm)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 9.0 | 13.1<br>13.2.1<br>13.3.1<br>13.4<br>13.4.1<br>14.0<br>14.0.1<br>14.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                                                                                                                                                                                                                                                                                                |
| watchOS 9.1 | 13.1<br>13.2.1<br>13.3.1<br>13.4<br>13.4.1<br>14.0<br>14.0.1<br>14.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                                                                                                                                                                                                                                                      |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.3.13                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 33.0.3                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                       |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.1.8937393 (default)                                                                                                 |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

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

#### Environment variables
| Name              | Value                                                                                     |
| ----------------- | ----------------------------------------------------------------------------------------- |
| PARALLELS_DMG_URL | https://download.parallels.com/desktop/v18/18.0.2-53077/ParallelsDesktop-18.0.2-53077.dmg |

##### Notes:
```
If you want to use Parallels Desktop you should download a package from URL stored in
PARALLELS_DMG_URL environment variable. A system extension is allowed for this version.
```



