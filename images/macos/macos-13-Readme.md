# macOS 13
- OS Version: macOS 13.5 (22G74)
- Kernel Version: Darwin 22.6.0
- Image Version: 20230801.2

## Installed Software

### Language and Runtime
- .NET Core SDK: 7.0.102, 7.0.202, 7.0.306
- Bash 3.2.57(1)-release
- Clang/LLVM 14.0.0
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 11 (Homebrew GCC 11.4.0) - available by `gcc-11` alias
- GCC 12 (Homebrew GCC 12.3.0) - available by `gcc-12` alias
- GNU Fortran 11 (Homebrew GCC 11.4.0) - available by `gfortran-11` alias
- GNU Fortran 12 (Homebrew GCC 12.3.0) - available by `gfortran-12` alias
- Julia 1.9.2
- Kotlin 1.9.0-release-358
- Perl 5.36.1
- PHP 8.2.8
- Python3 3.11.4
- R 4.3.1
- Ruby 3.0.6p216

### Package Management
- Bundler 2.4.17
- Carthage 0.39.0
- CocoaPods 1.12.1
- Composer 2.5.8
- Homebrew 4.1.3
- NPM 9.6.7
- Pip3 23.2.1 (python 3.11)
- Pipx 1.2.0
- RubyGems 3.4.17
- Vcpkg 2023 (build from commit 0895a8130)
- Yarn 1.22.19

### Project Management
- Apache Ant 1.10.13

### Utilities
- 7-Zip 17.05
- aria2 1.36.0
- azcopy 10.20.0
- bazel 6.3.1
- bazelisk 1.17.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.2.1
- Git 2.41.0
- Git LFS 3.4.0
- GitHub CLI 2.32.1
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.21.4
- gpg (GnuPG) 2.4.3
- jq 1.6
- OpenSSL 1.1.1u  30 May 2023
- Packer 1.9.2
- pkg-config 0.29.2
- Vagrant 2.3.7
- yq 4.34.2
- zstd 1.5.5

### Tools
- AWS CLI 2.13.5
- AWS SAM CLI 1.94.0
- AWS Session Manager CLI 1.2.463.0
- Azure CLI 2.50.0
- Azure CLI (azure-devops) 0.26.0
- Bicep CLI 0.19.5
- Cabal 3.6.2.0
- Cmake 3.27.1
- CodeQL Action Bundles 2.14.0 2.14.1
- Fastlane 2.214.0
- GHC 9.6.2
- GHCup 0.1.19.4
- Stack 2.9.3
- SwiftFormat 0.51.13
- Xcode Command Line Tools 14.3.1.0.1.1683849156

### Linters
- SwiftLint 0.52.4

### Browsers
- Safari 16.6 (18615.3.12.11.2)
- SafariDriver 16.6 (18615.3.12.11.2)
- Google Chrome 115.0.5790.114
- Google Chrome for Testing 115.0.5790.102
- ChromeDriver 115.0.5790.102
- Microsoft Edge 115.0.1901.188
- Microsoft Edge WebDriver 115.0.1901.188
- Mozilla Firefox 116.0
- geckodriver 0.33.0
- Selenium server 4.10.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version            | Vendor          | Environment Variable |
| ------------------ | --------------- | -------------------- |
| 8.0.382+5          | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.20+8          | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.8+7 (default) | Eclipse Temurin | JAVA_HOME_17_X64     |

### Cached Tools

#### Ruby
- 3.0.6
- 3.1.4

#### Python
- 3.8.17
- 3.9.17
- 3.10.12
- 3.11.4

#### PyPy
- 2.7.18 [PyPy 7.3.12]
- 3.7.13 [PyPy 7.3.9]
- 3.8.16 [PyPy 7.3.11]
- 3.9.17 [PyPy 7.3.12]

#### Node.js
- 16.20.1
- 18.17.0

#### Go
- 1.19.11
- 1.20.6

### Rust Tools
- Cargo 1.71.0
- Rust 1.71.0
- Rustdoc 1.71.0
- Rustup 1.26.0

#### Packages
- Bindgen 0.66.1
- Cargo-audit 0.17.6
- Cargo-outdated 0.13.1
- Cbindgen 0.24.5
- Clippy 0.1.71
- Rustfmt 1.5.2-stable

### PowerShell Tools
- PowerShell 7.2.13

#### PowerShell Modules
- Az: 10.2.0
- Pester: 5.5.0
- PSScriptAnalyzer: 1.21.0

### Xcode
| Version        | Build    | Path                           |
| -------------- | -------- | ------------------------------ |
| 15.0 (beta)    | 15A5161b | /Applications/Xcode_15.0.app   |
| 14.3.1         | 14E300c  | /Applications/Xcode_14.3.1.app |
| 14.3           | 14E222b  | /Applications/Xcode_14.3.app   |
| 14.2 (default) | 14C18    | /Applications/Xcode_14.2.app   |
| 14.1           | 14B47b   | /Applications/Xcode_14.1.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.1

#### Installed SDKs
| SDK                                                     | SDK Name                                        | Xcode Version |
| ------------------------------------------------------- | ----------------------------------------------- | ------------- |
| macOS 13.0                                              | macosx13.0                                      | 14.1          |
| macOS 13.1                                              | macosx13.1                                      | 14.2          |
| macOS 13.3                                              | macosx13.3                                      | 14.3, 14.3.1  |
| macOS 14.0                                              | macosx14.0                                      | 15.0          |
| iOS 16.1                                                | iphoneos16.1                                    | 14.1          |
| iOS 16.2                                                | iphoneos16.2                                    | 14.2          |
| iOS 16.4                                                | iphoneos16.4                                    | 14.3, 14.3.1  |
| iOS 17.0                                                | iphoneos17.0                                    | 15.0          |
| Simulator - iOS 16.1                                    | iphonesimulator16.1                             | 14.1          |
| Simulator - iOS 16.2                                    | iphonesimulator16.2                             | 14.2          |
| Simulator - iOS 16.4                                    | iphonesimulator16.4                             | 14.3, 14.3.1  |
| Simulator - iOS 17.0                                    | iphonesimulator17.0                             | 15.0          |
| tvOS 16.1                                               | appletvos16.1                                   | 14.1, 14.2    |
| tvOS 16.4                                               | appletvos16.4                                   | 14.3, 14.3.1  |
| tvOS 17.0                                               | appletvos17.0                                   | 15.0          |
| Simulator - tvOS 16.1                                   | appletvsimulator16.1                            | 14.1, 14.2    |
| Simulator - tvOS 16.4                                   | appletvsimulator16.4                            | 14.3, 14.3.1  |
| Simulator - tvOS 17.0                                   | appletvsimulator17.0                            | 15.0          |
| watchOS 9.1                                             | watchos9.1                                      | 14.1, 14.2    |
| watchOS 9.4                                             | watchos9.4                                      | 14.3, 14.3.1  |
| watchOS 10.0                                            | watchos10.0                                     | 15.0          |
| Simulator - watchOS 9.1                                 | watchsimulator9.1                               | 14.1, 14.2    |
| Simulator - watchOS 9.4                                 | watchsimulator9.4                               | 14.3, 14.3.1  |
| Simulator - watchOS 10.0                                | watchsimulator10.0                              | 15.0          |
| visionOS 1.0                                            | xros1.0                                         | 15.0          |
| Simulator - visionOS 1.0                                | xrsimulator1.0                                  | 15.0          |
| Asset Runtime SDK for macOS hosts targeting watchOS 9.4 | assetruntime.host.macosx.target.watchos9.4      | 14.3, 14.3.1  |
| Xcode 15.0                                              | com.apple.dt.xcode.xros.support.internal        | 15.0          |
| Xcode 15.0                                              | com.apple.dt.xcode.xrsimulator.support.internal | 15.0          |
| Asset Runtime SDK for macOS hosts targeting tvOS 16.4   | assetruntime.host.macosx.target.appletvos16.4   | 14.3, 14.3.1  |
| Asset Runtime SDK for macOS hosts targeting iOS 16.4    | assetruntime.host.macosx.target.iphoneos16.4    | 14.3, 14.3.1  |
| DriverKit 22.1                                          | driverkit22.1                                   | 14.1          |
| DriverKit 22.2                                          | driverkit22.2                                   | 14.2          |
| DriverKit 22.4                                          | driverkit22.4                                   | 14.3, 14.3.1  |
| DriverKit 23.0                                          | driverkit23.0                                   | 15.0          |

#### Installed Simulators
| OS           | Xcode Version                          | Simulators                                                                                                                                                                                                                                                                                                                                                           |
| ------------ | -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 16.1     | 14.1                                   | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                 |
| iOS 16.2     | 14.2                                   | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                 |
| iOS 16.4     | 14.3<br>14.3.1                         | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                 |
| iOS 17.0     | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                 |
| tvOS 16.1    | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                  |
| tvOS 16.4    | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                  |
| tvOS 17.0    | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                  |
| watchOS 9.1  | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm) |
| watchOS 9.4  | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm) |
| watchOS 10.0 | 14.1<br>14.2<br>14.3<br>14.3.1<br>15.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm) |

### Android
| Package Name               | Version                                                                                                                                                                                                                            |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 8.0                                                                                                                                                                                                                                |
| Android Emulator           | 32.1.14                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 34.0.0<br>33.0.0 33.0.1 33.0.2<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3                                                     |
| Android SDK Platforms      | android-34 (rev 1)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 34.0.4                                                                                                                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                             |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                                                                                                   |
| Google Play services       | 49                                                                                                                                                                                                                                 |
| Google Repository          | 58                                                                                                                                                                                                                                 |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.2.9519653 (default)                                                                                                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                  |

#### Environment variables
| Name                    | Value                                              |
| ----------------------- | -------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                  |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/25.2.9519653 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/25.2.9519653 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                  |
