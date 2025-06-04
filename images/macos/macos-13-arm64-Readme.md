| Announcements |
|-|
| [[macOS] Xcode 15.4 will be removed from macOS15 images on  May 29th, 2025](https://github.com/actions/runner-images/issues/12195) |
| [[macOS] Go version 1.21.* will be removed from all macOS images on May 12, 2025.](https://github.com/actions/runner-images/issues/12032) |
***
# macOS 13
- OS Version: macOS 13.7.6 (22H625)
- Kernel Version: Darwin 22.6.0
- Image Version: 20250527.1294

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.410, 9.0.102, 9.0.203, 9.0.300
- Bash 3.2.57(1)-release
- Clang/LLVM 14.0.0
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 12 (Homebrew GCC 12.4.0) - available by `gcc-12` alias
- GCC 13 (Homebrew GCC 13.3.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.2.0) - available by `gcc-14` alias
- GNU Fortran 12 (Homebrew GCC 12.4.0) - available by `gfortran-12` alias
- GNU Fortran 13 (Homebrew GCC 13.3.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.2.0) - available by `gfortran-14` alias
- Kotlin 2.1.10-release-473
- Mono 6.12.0.188
- Node.js 20.19.2
- Perl 5.40.2
- Python3 3.13.3
- Ruby 3.3.8

### Package Management
- Bundler 2.6.9
- Carthage 0.40.0
- CocoaPods 1.16.2
- Homebrew 4.5.3
- NPM 10.8.2
- NuGet 6.3.1.1
- Pip3 25.1.1 (python 3.13)
- Pipx 1.7.1
- RubyGems 3.6.9
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.9
- Gradle 8.14.1

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.29.1
- bazel 8.2.1
- bazelisk 1.26.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.49.0
- Git LFS 3.6.1
- GitHub CLI 2.73.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.4.8
- jq 1.7.1
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.12.0
- pkgconf 2.4.3
- Unxip 3.1
- yq 4.45.4
- zstd 1.5.7
- Ninja 1.12.1

### Tools
- AWS CLI 2.27.22
- AWS SAM CLI 1.139.0
- AWS Session Manager CLI 1.2.707.0
- Azure CLI 2.73.0
- Azure CLI (azure-devops) 1.0.1
- Bicep CLI 0.35.1
- Cmake 3.31.6
- CodeQL Action Bundle 2.21.3
- Fastlane 2.227.2
- SwiftFormat 0.56.1
- Xcbeautify 2.28.0
- Xcode Command Line Tools 14.3.1.0.1.1683849156
- Xcodes 1.6.0

### Linters

### Browsers
- Safari 18.5 (18621.2.5.18.1)
- SafariDriver 18.5 (18621.2.5.18.1)
- Google Chrome 137.0.7151.41
- Google Chrome for Testing 137.0.7151.40
- ChromeDriver 137.0.7151.40
- Mozilla Firefox 138.0.4
- geckodriver 0.36.0
- Selenium server 4.33.0

#### Environment variables
| Name            | Value                                   |
| --------------- | --------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-arm64 |
| EDGEWEBDRIVER   |                                         |
| GECKOWEBDRIVER  | /opt/homebrew/opt/geckodriver/bin       |

### Java
| Version             | Environment Variable |
| ------------------- | -------------------- |
| 11.0.27+6           | JAVA_HOME_11_arm64   |
| 17.0.15+6 (default) | JAVA_HOME_17_arm64   |
| 21.0.7+6.0          | JAVA_HOME_21_arm64   |

### Cached Tools

#### Ruby
- 3.1.7
- 3.2.8
- 3.3.8
- 3.4.4

#### Python
- 3.11.9
- 3.12.10
- 3.13.3

#### Node.js
- 18.20.8
- 20.19.2
- 22.16.0

#### Go
- 1.22.12
- 1.23.9
- 1.24.3

### Rust Tools
- Cargo 1.87.0
- Rust 1.87.0
- Rustdoc 1.87.0
- Rustup 1.28.2

#### Packages
- Clippy 0.1.87
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.10

#### PowerShell Modules
- Az: 12.4.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Xcode
| Version        | Build   | Path                           | Symlinks                                                  |
| -------------- | ------- | ------------------------------ | --------------------------------------------------------- |
| 15.2 (default) | 15C500b | /Applications/Xcode_15.2.app   | /Applications/Xcode_15.2.0.app<br>/Applications/Xcode.app |
| 15.1           | 15C65   | /Applications/Xcode_15.1.app   | /Applications/Xcode_15.1.0.app                            |
| 15.0.1         | 15A507  | /Applications/Xcode_15.0.1.app | /Applications/Xcode_15.0.app                              |
| 14.3.1         | 14E300c | /Applications/Xcode_14.3.1.app | /Applications/Xcode_14.3.app                              |
| 14.2           | 14C18   | /Applications/Xcode_14.2.app   | /Applications/Xcode_14.2.0.app                            |
| 14.1           | 14B47b  | /Applications/Xcode_14.1.app   | /Applications/Xcode_14.1.0.app                            |

#### Installed SDKs
| SDK                                                     | SDK Name                                      | Xcode Version |
| ------------------------------------------------------- | --------------------------------------------- | ------------- |
| macOS 13.0                                              | macosx13.0                                    | 14.1          |
| macOS 13.1                                              | macosx13.1                                    | 14.2          |
| macOS 13.3                                              | macosx13.3                                    | 14.3.1        |
| macOS 14.0                                              | macosx14.0                                    | 15.0.1        |
| macOS 14.2                                              | macosx14.2                                    | 15.1, 15.2    |
| iOS 16.1                                                | iphoneos16.1                                  | 14.1          |
| iOS 16.2                                                | iphoneos16.2                                  | 14.2          |
| iOS 16.4                                                | iphoneos16.4                                  | 14.3.1        |
| iOS 17.0                                                | iphoneos17.0                                  | 15.0.1        |
| iOS 17.2                                                | iphoneos17.2                                  | 15.1, 15.2    |
| Simulator - iOS 16.1                                    | iphonesimulator16.1                           | 14.1          |
| Simulator - iOS 16.2                                    | iphonesimulator16.2                           | 14.2          |
| Simulator - iOS 16.4                                    | iphonesimulator16.4                           | 14.3.1        |
| Simulator - iOS 17.0                                    | iphonesimulator17.0                           | 15.0.1        |
| Simulator - iOS 17.2                                    | iphonesimulator17.2                           | 15.1, 15.2    |
| tvOS 16.1                                               | appletvos16.1                                 | 14.1, 14.2    |
| tvOS 16.4                                               | appletvos16.4                                 | 14.3.1        |
| tvOS 17.0                                               | appletvos17.0                                 | 15.0.1        |
| tvOS 17.2                                               | appletvos17.2                                 | 15.1, 15.2    |
| Simulator - tvOS 16.1                                   | appletvsimulator16.1                          | 14.1, 14.2    |
| Simulator - tvOS 16.4                                   | appletvsimulator16.4                          | 14.3.1        |
| Simulator - tvOS 17.0                                   | appletvsimulator17.0                          | 15.0.1        |
| Simulator - tvOS 17.2                                   | appletvsimulator17.2                          | 15.1, 15.2    |
| watchOS 9.1                                             | watchos9.1                                    | 14.1, 14.2    |
| watchOS 9.4                                             | watchos9.4                                    | 14.3.1        |
| watchOS 10.0                                            | watchos10.0                                   | 15.0.1        |
| watchOS 10.2                                            | watchos10.2                                   | 15.1, 15.2    |
| Simulator - watchOS 9.1                                 | watchsimulator9.1                             | 14.1, 14.2    |
| Simulator - watchOS 9.4                                 | watchsimulator9.4                             | 14.3.1        |
| Simulator - watchOS 10.0                                | watchsimulator10.0                            | 15.0.1        |
| Simulator - watchOS 10.2                                | watchsimulator10.2                            | 15.1, 15.2    |
| visionOS 1.0                                            | xros1.0                                       | 15.2          |
| Simulator - visionOS 1.0                                | xrsimulator1.0                                | 15.2          |
| Asset Runtime SDK for macOS hosts targeting watchOS 9.4 | assetruntime.host.macosx.target.watchos9.4    | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting tvOS 16.4   | assetruntime.host.macosx.target.appletvos16.4 | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting iOS 16.4    | assetruntime.host.macosx.target.iphoneos16.4  | 14.3.1        |
| DriverKit 22.1                                          | driverkit22.1                                 | 14.1          |
| DriverKit 22.2                                          | driverkit22.2                                 | 14.2          |
| DriverKit 22.4                                          | driverkit22.4                                 | 14.3.1        |
| DriverKit 23.0                                          | driverkit23.0                                 | 15.0.1        |
| DriverKit 23.2                                          | driverkit23.2                                 | 15.1, 15.2    |

#### Installed Simulators
| OS           | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 16.1     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 16.2     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 16.4     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 17.0     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                        |
| iOS 17.2     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                        |
| tvOS 16.1    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 16.4    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.0    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.2    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| watchOS 9.1  | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                             |
| watchOS 9.4  | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                             |
| watchOS 10.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.2 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |
| visionOS 1.0 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                           |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 11.0                                                                                                                                                                                                                                                                                                              |
| Android Emulator           | 35.5.10                                                                                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 36.0.0<br>35.0.0 35.0.1<br>34.0.0<br>33.0.2 33.0.3                                                                                                                                                                                                                                                                |
| Android SDK Platforms      | android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3) |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                                                            |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                            |
| CMake                      | 3.31.5                                                                                                                                                                                                                                                                                                            |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                |
| NDK                        | 26.3.11579264 (default)<br>27.2.12479018<br>28.1.13356709                                                                                                                                                                                                                                                         |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/28.1.13356709 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

### Miscellaneous
- Tcl/Tk 8.6.16

