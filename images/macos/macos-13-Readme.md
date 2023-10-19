| Announcements |
|-|
| [[All OS] Android NDK r23 will be removed from images on October 9](https://github.com/actions/runner-images/issues/8383) |
***
# macOS 13
- OS Version: macOS 13.6 (22G120)
- Kernel Version: Darwin 22.6.0
- Image Version: 20231018.14

## Installed Software

### Language and Runtime
- .NET Core SDK: 7.0.102, 7.0.202, 7.0.306, 7.0.402
- Bash 3.2.57(1)-release
- Clang/LLVM 14.0.3
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 11 (Homebrew GCC 11.4.0) - available by `gcc-11` alias
- GCC 12 (Homebrew GCC 12.3.0) - available by `gcc-12` alias
- GNU Fortran 11 (Homebrew GCC 11.4.0) - available by `gfortran-11` alias
- GNU Fortran 12 (Homebrew GCC 12.3.0) - available by `gfortran-12` alias
- Julia 1.9.3
- Kotlin 1.9.10-release-459
- Mono 6.12.0.188
- Perl 5.38.0
- PHP 8.2.11
- Python3 3.11.6
- R 4.3.1
- Ruby 3.0.6p216

### Package Management
- Bundler 2.4.21
- Carthage 0.39.1
- CocoaPods 1.13.0
- Composer 2.6.5
- Homebrew 4.1.16
- NPM 9.8.1
- NuGet 6.3.1.1
- Pip3 23.3 (python 3.11)
- Pipx 1.2.0
- RubyGems 3.4.21
- Vcpkg 2023 (build from commit a9794606a)
- Yarn 1.22.19

### Project Management
- Apache Ant 1.10.14
- Apache Maven 3.9.5
- Gradle 8.4

### Utilities
- 7-Zip 17.05
- aria2 1.36.0
- azcopy 10.21.0
- bazel 6.3.2
- bazelisk 1.18.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.4.0
- Git 2.42.0
- Git LFS 3.4.0
- GitHub CLI 2.37.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.21.4
- gpg (GnuPG) 2.4.3
- jq 1.7
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.9.4
- pkg-config 0.29.2
- yq 4.35.2
- zstd 1.5.5

### Tools
- AWS CLI 2.13.26
- AWS SAM CLI 1.98.0
- AWS Session Manager CLI 1.2.497.0
- Azure CLI 2.53.0
- Azure CLI (azure-devops) 0.26.0
- Bicep CLI 0.22.6
- Cabal 3.6.2.0
- Cmake 3.27.7
- CodeQL Action Bundle 2.15.0
- Fastlane 2.216.0
- GHC 9.8.1
- GHCup 0.1.19.4
- Stack 2.13.1
- SwiftFormat 0.52.7
- Xcode Command Line Tools 15.0.0.0.1.1694021235

### Linters
- SwiftLint 0.53.0

### Browsers
- Safari 17.0 (18616.1.27.111.22)
- SafariDriver 17.0 (18616.1.27.111.22)
- Google Chrome 118.0.5993.88
- Google Chrome for Testing 118.0.5993.70
- ChromeDriver 118.0.5993.70
- Microsoft Edge 118.0.2088.46
- Microsoft Edge WebDriver 118.0.2088.46
- Mozilla Firefox 118.0.2
- geckodriver 0.33.0
- Selenium server 4.14.1

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.382+5            | JAVA_HOME_8_X64      |
| 11.0.21+9            | JAVA_HOME_11_X64     |
| 17.0.8+101 (default) | JAVA_HOME_17_X64     |
| 21.0.0+35.0.LTS      | JAVA_HOME_21_X64     |

### Cached Tools

#### Ruby
- 3.0.6
- 3.1.4

#### Python
- 3.8.18
- 3.9.18
- 3.10.13
- 3.11.6

#### PyPy
- 2.7.18 [PyPy 7.3.13]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.18 [PyPy 7.3.13]
- 3.10.13 [PyPy 7.3.13]

#### Node.js
- 16.20.2
- 18.18.2
- 20.8.1

#### Go
- 1.19.13
- 1.20.10
- 1.21.3

### Rust Tools
- Cargo 1.73.0
- Rust 1.73.0
- Rustdoc 1.73.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.68.1
- Cargo-audit 0.18.2
- Cargo-outdated 0.13.1
- Cbindgen 0.26.0
- Clippy 0.1.73
- Rustfmt 1.6.0-stable

### PowerShell Tools
- PowerShell 7.2.15

#### PowerShell Modules
- Az: 10.4.1
- Pester: 5.5.0
- PSScriptAnalyzer: 1.21.0

### Xcode
| Version          | Build   | Path                           |
| ---------------- | ------- | ------------------------------ |
| 15.0.1           | 15A507  | /Applications/Xcode_15.0.1.app |
| 15.0             | 15A240d | /Applications/Xcode_15.0.app   |
| 14.3.1 (default) | 14E300c | /Applications/Xcode_14.3.1.app |
| 14.2             | 14C18   | /Applications/Xcode_14.2.app   |
| 14.1             | 14B47b  | /Applications/Xcode_14.1.app   |

#### Xcode Support Tools
- xcpretty 0.3.0

#### Installed SDKs
| SDK                                                     | SDK Name                                      | Xcode Version |
| ------------------------------------------------------- | --------------------------------------------- | ------------- |
| macOS 13.0                                              | macosx13.0                                    | 14.1          |
| macOS 13.1                                              | macosx13.1                                    | 14.2          |
| macOS 13.3                                              | macosx13.3                                    | 14.3.1        |
| macOS 14.0                                              | macosx14.0                                    | 15.0, 15.0.1  |
| iOS 16.1                                                | iphoneos16.1                                  | 14.1          |
| iOS 16.2                                                | iphoneos16.2                                  | 14.2          |
| iOS 16.4                                                | iphoneos16.4                                  | 14.3.1        |
| iOS 17.0                                                | iphoneos17.0                                  | 15.0, 15.0.1  |
| Simulator - iOS 16.1                                    | iphonesimulator16.1                           | 14.1          |
| Simulator - iOS 16.2                                    | iphonesimulator16.2                           | 14.2          |
| Simulator - iOS 16.4                                    | iphonesimulator16.4                           | 14.3.1        |
| Simulator - iOS 17.0                                    | iphonesimulator17.0                           | 15.0, 15.0.1  |
| tvOS 16.1                                               | appletvos16.1                                 | 14.1, 14.2    |
| tvOS 16.4                                               | appletvos16.4                                 | 14.3.1        |
| tvOS 17.0                                               | appletvos17.0                                 | 15.0, 15.0.1  |
| Simulator - tvOS 16.1                                   | appletvsimulator16.1                          | 14.1, 14.2    |
| Simulator - tvOS 16.4                                   | appletvsimulator16.4                          | 14.3.1        |
| Simulator - tvOS 17.0                                   | appletvsimulator17.0                          | 15.0, 15.0.1  |
| watchOS 9.1                                             | watchos9.1                                    | 14.1, 14.2    |
| watchOS 9.4                                             | watchos9.4                                    | 14.3.1        |
| watchOS 10.0                                            | watchos10.0                                   | 15.0, 15.0.1  |
| Simulator - watchOS 9.1                                 | watchsimulator9.1                             | 14.1, 14.2    |
| Simulator - watchOS 9.4                                 | watchsimulator9.4                             | 14.3.1        |
| Simulator - watchOS 10.0                                | watchsimulator10.0                            | 15.0, 15.0.1  |
| Asset Runtime SDK for macOS hosts targeting watchOS 9.4 | assetruntime.host.macosx.target.watchos9.4    | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting tvOS 16.4   | assetruntime.host.macosx.target.appletvos16.4 | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting iOS 16.4    | assetruntime.host.macosx.target.iphoneos16.4  | 14.3.1        |
| DriverKit 22.1                                          | driverkit22.1                                 | 14.1          |
| DriverKit 22.2                                          | driverkit22.2                                 | 14.2          |
| DriverKit 22.4                                          | driverkit22.4                                 | 14.3.1        |
| DriverKit 23.0                                          | driverkit23.0                                 | 15.0, 15.0.1  |

#### Installed Simulators
| OS           | Xcode Version                            | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------ | ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 16.1     | 14.1                                     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 16.2     | 14.2                                     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 16.4     | 14.3.1                                   | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 17.0     | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                        |
| tvOS 16.1    | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 16.4    | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.0    | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| watchOS 9.1  | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                             |
| watchOS 9.4  | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                             |
| watchOS 10.0 | 14.1<br>14.2<br>14.3.1<br>15.0<br>15.0.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                                           |
| Android Emulator           | 32.1.15                                                                                                                                                                                                                                                       |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                                                |
| Android SDK Platforms      | android-34-ext8 (rev 1)<br>android-34 (rev 2)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 34.0.5                                                                                                                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                        |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                                                                                                                              |
| Google Play services       | 49                                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                                            |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)<br>26.1.10909125                                                                                                                                                                                       |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                             |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/25.2.9519653  |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/26.1.10909125 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/25.2.9519653  |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

