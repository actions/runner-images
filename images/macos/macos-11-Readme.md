| Announcements |
|-|
| [[macOS] Default Xcode on macOS 12 Monterey will be set to Xcode 14.1 on January, 9](https://github.com/actions/runner-images/issues/6746) |
| [macOS-latest workflows will use macOS-12](https://github.com/actions/runner-images/issues/6384) |
| [The macOS 10.15 Actions runner image will begin deprecation on 5/31/22 and will be fully unsupported by 12/1/22 for GitHub and ADO](https://github.com/actions/runner-images/issues/5583) |
***
# macOS 11
- OS Version: macOS 11.7.2 (20G1020)
- Kernel Version: Darwin 20.6.0
- Image Version: 20221215.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 3.1.101, 3.1.201, 3.1.302, 3.1.426, 5.0.102, 5.0.202, 5.0.302, 5.0.408, 6.0.404, 7.0.101
- Bash 3.2.57(1)-release
- Clang/LLVM 13.0.0
- Clang/LLVM (Homebrew) 14.0.6 - available on `$(brew --prefix llvm@14)/bin/clang`
- GCC 9 (Homebrew GCC 9.5.0) - available by `gcc-9` alias
- GCC 10 (Homebrew GCC 10.4.0) - available by `gcc-10` alias
- GCC 11 (Homebrew GCC 11.3.0) - available by `gcc-11` alias
- GNU Fortran 9 (Homebrew GCC 9.5.0) - available by `gfortran-9` alias
- GNU Fortran 10 (Homebrew GCC 10.4.0) - available by `gfortran-10` alias
- GNU Fortran 11 (Homebrew GCC 11.3.0) - available by `gfortran-11` alias
- Go 1.17.13
- Julia 1.8.3
- Kotlin 1.7.21-release-272
- Mono 6.12.0.188
- MSBuild 16.10.1.51301 (Mono 6.12.0.188)
- Node.js 16.19.0
- NVM 0.39.2
- NVM - Cached node versions: 14.21.2, 16.19.0, 18.12.1
- Perl 5.36.0
- PHP 8.2.0
- Python 2.7.18
- Python3 3.11.1
- R 4.2.2
- Ruby 2.7.7p221

### Package Management
- Bundler 2.3.26
- Carthage 0.38.0
- CocoaPods 1.11.3
- Composer 2.4.4
- Homebrew 3.6.15
- Miniconda 4.12.0
- NPM 8.19.3
- NuGet 6.3.1.1
- Pip 20.3.4 (python 2.7)
- Pip3 22.3.1 (python 3.11)
- Pipx 1.1.0
- RubyGems 3.3.26
- Vcpkg 2022 (build from commit 4b6bce313)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/local/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Apache Ant 1.10.12
- Apache Maven 3.8.6
- Gradle 7.6
- Sbt 1.8.0

### Utilities
- 7-Zip 17.04
- aria2 1.36.0
- azcopy 10.16.2
- bazel 5.4.0
- bazelisk 1.15.0
- bsdtar 3.3.2 - available by 'tar' alias
- Curl 7.86.0
- Git 2.39.0
- Git LFS 3.3.0
- GitHub CLI 2.20.2
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.3
- gpg (GnuPG) 2.3.8
- helm v3.10.3+g835b733
- Hub CLI 2.14.2
- ImageMagick 7.1.0-54
- jq 1.6
- mongo v5.0.11
- mongod v5.0.11
- Newman 5.3.2
- OpenSSL 1.1.1s  1 Nov 2022
- Packer 1.8.5
- PostgreSQL 14.6 (Homebrew)
- psql (PostgreSQL) 14.6 (Homebrew)
- Sox 14.4.2
- Subversion (SVN) 1.14.2
- Switchaudio-osx 1.1.0
- yq 4.30.5
- zstd 1.5.2

### Tools
- Aliyun CLI 3.0.140
- App Center CLI 2.12.0
- AWS CLI 2.9.7
- AWS SAM CLI 1.66.0
- AWS Session Manager CLI 1.2.398.0
- Azure CLI 2.43.0
- Azure CLI (azure-devops) 0.25.0
- Bicep CLI 0.13.1
- Cabal 3.6.2.0
- Cmake 3.25.1
- CodeQL Action Bundle 2.11.6
- Colima 0.5.0
- Fastlane 2.211.0
- GHC 9.4.3
- GHCup 0.1.18.0
- Jazzy 0.14.3
- Stack 2.9.1
- SwiftFormat 0.50.6
- Swig 4.1.1
- Xcode Command Line Tools 13.2.0.0.1.1638488800

### Linters
- SwiftLint 0.48.0
- Yamllint 1.28.0

### Browsers
- Safari 16.2 (16614.3.7.1.7)
- SafariDriver 16.2 (16614.3.7.1.7)
- Google Chrome 108.0.5359.124
- ChromeDriver 108.0.5359.71
- Microsoft Edge 108.0.1462.46
- Microsoft Edge WebDriver 108.0.1462.46
- Mozilla Firefox 108.0
- geckodriver 0.32.0
- Selenium server 4.5.0

#### Environment variables
| Name            | Value                                          |
| --------------- | ---------------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/Caskroom/chromedriver/108.0.5359.71 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver                   |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin                 |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.352+8 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.17+8           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.5+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.3.0 | GRAALVM_11_ROOT       |

### Cached Tools

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.10
- 2.7.7
- 3.0.5
- 3.1.3

#### Python
- 3.7.15
- 3.8.15
- 3.9.16
- 3.10.9
- 3.11.1

#### PyPy
- 2.7.18 [PyPy 7.3.10]
- 3.7.13 [PyPy 7.3.9]
- 3.8.15 [PyPy 7.3.10]
- 3.9.15 [PyPy 7.3.10]

#### Node.js
- 14.21.2
- 16.19.0
- 18.12.1

#### Go
- 1.17.13
- 1.18.9
- 1.19.4

### Rust Tools
- Cargo 1.66.0
- Rust 1.66.0
- Rustdoc 1.66.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.63.0
- Cargo-audit 0.17.4
- Cargo-outdated 0.11.1
- Cbindgen 0.24.3
- Clippy 0.1.66
- Rustfmt 1.5.1-stable

### PowerShell Tools
- PowerShell 7.2.8

#### PowerShell Modules
- Az: 9.2.0
- MarkdownPS: 1.9
- Pester: 5.3.3
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name  | Version  | ConfigFile                      | ServiceStatus | ListenPort |
| ----- | -------- | ------------------------------- | ------------- | ---------- |
| httpd | 2.4.54_1 | /usr/local/etc/httpd/httpd.conf | none          | 80         |
| nginx | 1.23.3   | /usr/local/etc/nginx/nginx.conf | none          | 80         |

### Xamarin

#### Visual Studio for Mac
| Version        | Build     | Path                                 |
| -------------- | --------- | ------------------------------------ |
| 2019           | 8.10.25.2 | /Applications/Visual Studio 2019.app |
| 2022 (default) | 17.4.2.17 | /Applications/Visual Studio.app      |

##### Notes
```
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
```

#### Xamarin bundles
| symlink           | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ----------------- | ------------ | ----------- | ----------- | --------------- |
| 6_12_16           | 6.12         | 15.8        | 8.8         | 12.2            |
| 6_12_15           | 6.12         | 15.8        | 8.8         | 12.1            |
| 6_12_14           | 6.12         | 15.8        | 8.8         | 12.0            |
| 6_12_13           | 6.12         | 15.6        | 8.6         | 12.0            |
| 6_12_12 (default) | 6.12         | 15.4        | 8.4         | 12.0            |
| 6_12_11           | 6.12         | 15.2        | 8.2         | 12.0            |
| 6_12_10           | 6.12         | 15.0        | 7.14        | 11.3            |
| 6_12_9            | 6.12         | 14.20       | 7.14        | 11.3            |
| 6_12_8            | 6.12         | 14.16       | 7.10        | 11.2            |
| 6_12_7            | 6.12         | 14.14       | 7.8         | 11.2            |
| 6_12_6            | 6.12         | 14.10       | 7.4         | 11.1            |
| 6_12_5            | 6.12         | 14.8        | 7.2         | 11.1            |
| 6_12_4            | 6.12         | 14.6        | 7.0         | 11.1            |
| 6_12_3            | 6.12         | 14.4        | 6.22        | 11.1            |
| 6_12_2            | 6.12         | 14.2        | 6.20        | 11.0            |
| 6_12_1            | 6.12         | 14.0        | 6.20        | 11.0            |
| 6_12_0            | 6.12         | 13.20       | 6.20        | 11.0            |

#### Unit Test Framework
- NUnit 3.6.1

### Xcode
| Version          | Build    | Path                           |
| ---------------- | -------- | ------------------------------ |
| 13.2.1 (default) | 13C100   | /Applications/Xcode_13.2.1.app |
| 13.1             | 13A1030d | /Applications/Xcode_13.1.app   |
| 13.0             | 13A233   | /Applications/Xcode_13.0.app   |
| 12.5.1           | 12E507   | /Applications/Xcode_12.5.1.app |
| 12.4             | 12D4e    | /Applications/Xcode_12.4.app   |
| 11.7             | 11E801a  | /Applications/Xcode_11.7.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.1
- Nomad CLI 0.0.2
- Nomad shenzhen CLI 0.14.3

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version |
| ----------------------- | -------------------- | ------------- |
| macOS 10.15             | macosx10.15          | 11.7          |
| macOS 11.1              | macosx11.1           | 12.4          |
| macOS 11.3              | macosx11.3           | 12.5.1, 13.0  |
| macOS 12.0              | macosx12.0           | 13.1          |
| macOS 12.1              | macosx12.1           | 13.2.1        |
| iOS 13.7                | iphoneos13.7         | 11.7          |
| iOS 14.4                | iphoneos14.4         | 12.4          |
| iOS 14.5                | iphoneos14.5         | 12.5.1        |
| iOS 15.0                | iphoneos15.0         | 13.0, 13.1    |
| iOS 15.2                | iphoneos15.2         | 13.2.1        |
| Simulator - iOS 13.7    | iphonesimulator13.7  | 11.7          |
| Simulator - iOS 14.4    | iphonesimulator14.4  | 12.4          |
| Simulator - iOS 14.5    | iphonesimulator14.5  | 12.5.1        |
| Simulator - iOS 15.0    | iphonesimulator15.0  | 13.0, 13.1    |
| Simulator - iOS 15.2    | iphonesimulator15.2  | 13.2.1        |
| tvOS 13.4               | appletvos13.4        | 11.7          |
| tvOS 14.3               | appletvos14.3        | 12.4          |
| tvOS 14.5               | appletvos14.5        | 12.5.1        |
| tvOS 15.0               | appletvos15.0        | 13.0, 13.1    |
| tvOS 15.2               | appletvos15.2        | 13.2.1        |
| Simulator - tvOS 13.4   | appletvsimulator13.4 | 11.7          |
| Simulator - tvOS 14.3   | appletvsimulator14.3 | 12.4          |
| Simulator - tvOS 14.5   | appletvsimulator14.5 | 12.5.1        |
| Simulator - tvOS 15.0   | appletvsimulator15.0 | 13.0, 13.1    |
| Simulator - tvOS 15.2   | appletvsimulator15.2 | 13.2.1        |
| watchOS 6.2             | watchos6.2           | 11.7          |
| watchOS 7.2             | watchos7.2           | 12.4          |
| watchOS 7.4             | watchos7.4           | 12.5.1        |
| watchOS 8.0             | watchos8.0           | 13.0, 13.1    |
| watchOS 8.3             | watchos8.3           | 13.2.1        |
| Simulator - watchOS 6.2 | watchsimulator6.2    | 11.7          |
| Simulator - watchOS 7.2 | watchsimulator7.2    | 12.4          |
| Simulator - watchOS 7.4 | watchsimulator7.4    | 12.5.1        |
| Simulator - watchOS 8.0 | watchsimulator8.0    | 13.0, 13.1    |
| Simulator - watchOS 8.3 | watchsimulator8.3    | 13.2.1        |
| DriverKit 19.0          | driverkit.macosx19.0 | 11.7          |
| DriverKit 20.2          | driverkit.macosx20.2 | 12.4          |
| DriverKit 20.4          | driverkit.macosx20.4 | 12.5.1, 13.0  |
| DriverKit 21.0.1        | driverkit21.0.1      | 13.1          |
| DriverKit 21.2          | driverkit21.2        | 13.2.1        |

#### Installed Simulators
| OS          | Xcode Version | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ----------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 13.7    | 11.7          | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                                                                                                                       |
| iOS 14.4    | 12.4          | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                             |
| iOS 14.5    | 12.5.1        | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                                                                             |
| iOS 15.0    | 13.0<br>13.1  | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad (9th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| iOS 15.2    | 13.2.1        | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad (9th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| tvOS 13.4   | 11.7          | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| tvOS 14.3   | 12.4          | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| tvOS 14.5   | 12.5.1        | Apple TV<br>Apple TV 4K<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| tvOS 15.0   | 13.0<br>13.1  | Apple TV<br>Apple TV 4K<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| tvOS 15.2   | 13.2.1        | Apple TV<br>Apple TV 4K<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| watchOS 6.2 | 11.7          | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| watchOS 7.2 | 12.4          | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| watchOS 7.4 | 12.5.1        | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| watchOS 8.0 | 13.0<br>13.1  | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                                                          |
| watchOS 8.3 | 13.2.1        | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                                                          |

### Android
| Package Name               | Version                                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                           |
| Android Emulator           | 31.3.14                                                                                                                                                       |
| Android SDK Build-tools    | 33.0.0 33.0.1<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)        |
| Android SDK Platform-Tools | 33.0.3                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                        |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                            |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.1.8937393 (default)                                                                                                        |
| SDK Patch Applier v4       | 1                                                                                                                                                             |

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
- libXext 1.3.5
- libXft 2.3.7
- Tcl/Tk 8.6.13
- Zlib 1.2.13

