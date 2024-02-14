| Announcements |
|-|
| [[All OSes] Powershell Core will be updated to 7.4.x LTS on January, 28](https://github.com/actions/runner-images/issues/9115) |
***
# macOS 11
- OS Version: macOS 11.7.10 (20G1427)
- Kernel Version: Darwin 20.6.0
- Image Version: 20240127.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 6.0.418, 7.0.102, 7.0.202, 7.0.306, 7.0.405, 8.0.101
- Bash 3.2.57(1)-release
- Clang/LLVM 13.0.0
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 10 (Homebrew GCC 10.5.0) - available by `gcc-10` alias
- GCC 11 (Homebrew GCC 11.4.0) - available by `gcc-11` alias
- GCC 12 (Homebrew GCC 12.3.0) - available by `gcc-12` alias
- GNU Fortran 10 (Homebrew GCC 10.5.0) - available by `gfortran-10` alias
- GNU Fortran 11 (Homebrew GCC 11.4.0) - available by `gfortran-11` alias
- GNU Fortran 12 (Homebrew GCC 12.3.0) - available by `gfortran-12` alias
- Julia 1.10.0
- Kotlin 1.9.22-release-704
- Go 1.20.13
- Mono 6.12.0.188
- Node.js 18.19.0
- MSBuild 16.10.1.51301 (Mono 6.12.0.188)
- NVM 0.39.7
- NVM - Cached node versions: 16.20.2, 18.19.0, 20.11.0
- Perl 5.38.2
- Python 2.7.18
- Python3 3.12.1
- R 4.3.2
- Ruby 2.7.8p225

### Package Management
- Bundler 2.4.22
- Carthage 0.39.1
- CocoaPods 1.14.3
- Homebrew 4.2.5
- Miniconda 23.11.0
- NPM 10.2.3
- NuGet 6.3.1.1
- Pip 20.3.4 (python 2.7)
- Pip3 23.3.2 (python 3.12)
- Pipx 1.4.3
- RubyGems 3.4.10
- Vcpkg 2024 (build from commit 7032c5759)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/local/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Apache Ant 1.10.14
- Apache Maven 3.9.6
- Gradle 8.5
- Sbt 1.9.8

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.22.2
- bazel 7.0.2
- bazelisk 1.19.0
- bsdtar 3.3.2 - available by 'tar' alias
- Curl 8.5.0
- Git 2.43.0
- Git LFS 3.4.1
- GitHub CLI 2.42.1
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.21.4
- gpg (GnuPG) 2.4.4
- helm v3.14.0+g3fc9f4b
- jq 1.7.1
- mongo 5.0.21
- mongod 5.0.21
- Newman 6.1.0
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.9.4
- pkg-config 0.29.2
- PostgreSQL 14.10 (Homebrew)
- psql (PostgreSQL) 14.10 (Homebrew)
- Sox 14.4.2
- Subversion (SVN) 1.14.3
- Switchaudio-osx 1.2.2
- yq 4.40.5
- zstd 1.5.5

### Tools
- Aliyun CLI 3.0.197
- App Center CLI 2.14.0
- AWS CLI 2.15.15
- AWS SAM CLI 1.108.0
- AWS Session Manager CLI 1.2.553.0
- Azure CLI 2.56.0
- Azure CLI (azure-devops) 0.26.0
- Bicep CLI 0.24.24
- Cabal 3.10.2.1
- Cmake 3.28.1
- CodeQL Action Bundle 2.16.1
- Fastlane 2.219.0
- GHC 9.8.1
- GHCup 0.1.20.0
- Jazzy 0.14.4
- Stack 2.13.1
- SwiftFormat 0.53.0
- Swig 4.2.0
- Xcode Command Line Tools 13.2.0.0.1.1638488800

### Linters
- SwiftLint 0.48.0
- Yamllint 1.33.0

### Browsers
- Safari 16.6.1 (16615.3.12.11.5)
- SafariDriver 16.6.1 (16615.3.12.11.5)
- Google Chrome 121.0.6167.85
- Google Chrome for Testing 121.0.6167.85
- ChromeDriver 121.0.6167.85
- Microsoft Edge 121.0.2277.83
- Microsoft Edge WebDriver 121.0.2277.83
- Mozilla Firefox 122.0
- geckodriver 0.34.0
- Selenium server 4.17.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 8.0.402+6 (default) | JAVA_HOME_8_X64      |
| 11.0.22+7           | JAVA_HOME_11_X64     |
| 17.0.10+7           | JAVA_HOME_17_X64     |
| 21.0.2+13.0         | JAVA_HOME_21_X64     |

### Cached Tools

#### Ruby
- 2.5.9
- 2.6.10
- 2.7.8
- 3.0.6
- 3.1.4

#### PyPy
- 2.7.18 [PyPy 7.3.15]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.18 [PyPy 7.3.15]
- 3.10.13 [PyPy 7.3.15]

#### Python
- 3.7.17
- 3.8.18
- 3.9.18
- 3.10.13
- 3.11.7
- 3.12.1

#### Node.js
- 16.20.2
- 18.19.0
- 20.11.0

#### Go
- 1.19.13
- 1.20.13
- 1.21.6

### Rust Tools
- Cargo 1.75.0
- Rust 1.75.0
- Rustdoc 1.75.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.69.2
- Cargo-audit 0.18.3
- Cargo-outdated 0.14.0
- Cbindgen 0.26.0
- Clippy 0.1.75
- Rustfmt 1.7.0-stable

### PowerShell Tools
- PowerShell 7.4.1

#### PowerShell Modules
- Az: 11.2.0
- MarkdownPS: 1.9
- Pester: 5.5.0
- PSScriptAnalyzer: 1.21.0

### Web Servers
| Name  | Version | ConfigFile                      | ServiceStatus | ListenPort |
| ----- | ------- | ------------------------------- | ------------- | ---------- |
| httpd | 2.4.58  | /usr/local/etc/httpd/httpd.conf | none          | 80         |
| nginx | 1.25.3  | /usr/local/etc/nginx/nginx.conf | none          | 80         |

### Xamarin

#### Visual Studio for Mac
| Version        | Build      | Path                                 |
| -------------- | ---------- | ------------------------------------ |
| 2019           | 8.10.25.2  | /Applications/Visual Studio 2019.app |
| 2022 (default) | 17.6.8.400 | /Applications/Visual Studio.app      |

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
| Package Name               | Version                                                                                                                                                                                           |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                               |
| Android Emulator           | 33.1.24                                                                                                                                                                                           |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0                                                                                                                                                |
| Android SDK Platforms      | android-34-ext8 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 2)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1) |
| Android SDK Platform-Tools | 34.0.5                                                                                                                                                                                            |
| Android Support Repository | 47.0.0                                                                                                                                                                                            |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                                                                        |
| Google Play services       | 49                                                                                                                                                                                                |
| Google Repository          | 58                                                                                                                                                                                                |
| NDK                        | 24.0.8215888<br>25.2.9519653 (default)<br>26.1.10909125                                                                                                                                           |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/26.1.10909125 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/25.2.9519653  |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

### Miscellaneous
- libXext 1.3.5
- libXft 2.3.8
- Tcl/Tk 8.6.13_5
- Zlib 1.3.1

