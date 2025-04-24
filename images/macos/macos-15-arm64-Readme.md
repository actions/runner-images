| Announcements |
|-|
| [[macOS] Go version 1.21.* will be removed from all macOS images on May 12, 2025.](https://github.com/actions/runner-images/issues/12032) |
| [[macOS 14] Xcode Command Line Tool version will be downgraded to 15.3.0 on macOS14 images](https://github.com/actions/runner-images/issues/11969) |
***
# macOS 15
- OS Version: macOS 15.4.1 (24E263)
- Kernel Version: Darwin 24.4.0
- Image Version: 20250421.1300

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.408, 9.0.102, 9.0.203
- Bash 3.2.57(1)-release
- Clang/LLVM 15.0.0
- Clang/LLVM (Homebrew) 18.1.8 - available on `$(brew --prefix llvm@18)/bin/clang`
- GCC 12 (Homebrew GCC 12.4.0) - available by `gcc-12` alias
- GCC 13 (Homebrew GCC 13.3.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.2.0_1) - available by `gcc-14` alias
- GNU Fortran 12 (Homebrew GCC 12.4.0) - available by `gfortran-12` alias
- GNU Fortran 13 (Homebrew GCC 13.3.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.2.0_1) - available by `gfortran-14` alias
- Kotlin 2.1.10-release-473
- Node.js 22.14.0
- Perl 5.40.2
- Python3 3.13.3
- Ruby 3.3.8

### Package Management
- Bundler 2.6.8
- Carthage 0.40.0
- CocoaPods 1.16.2
- Homebrew 4.4.31
- NPM 10.9.2
- Pip3 25.0.1 (python 3.13)
- Pipx 1.7.1
- RubyGems 3.6.8
- Vcpkg 2025 (build from commit 0d5cae1530)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.9
- Gradle 8.13

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.28.1
- bazel 8.2.1
- bazelisk 1.26.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.49.0
- Git LFS 3.6.1
- GitHub CLI 2.70.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.4.7
- jq 1.7.1
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.12.0
- pkgconf 2.4.3
- Unxip 3.1
- yq 4.45.1
- zstd 1.5.7
- Ninja 1.12.1

### Tools
- AWS CLI 2.26.5
- AWS SAM CLI 1.137.1
- AWS Session Manager CLI 1.2.707.0
- Azure CLI 2.71.0
- Azure CLI (azure-devops) 1.0.1
- Bicep CLI 0.34.44
- Cmake 3.31.6
- CodeQL Action Bundle 2.21.0
- Fastlane 2.227.1
- SwiftFormat 0.55.5
- Xcbeautify 2.28.0
- Xcode Command Line Tools 16.3.0.0.1.1742442376
- Xcodes 1.6.0

### Linters

### Browsers
- Safari 18.4 (20621.1.15.11.10)
- SafariDriver 18.4 (20621.1.15.11.10)
- Google Chrome 135.0.7049.96
- Google Chrome for Testing 135.0.7049.95
- ChromeDriver 135.0.7049.95
- Selenium server 4.29.0

#### Environment variables
| Name            | Value                                   |
| --------------- | --------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-arm64 |
| EDGEWEBDRIVER   |                                         |
| GECKOWEBDRIVER  |                                         |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 11.0.26+4            | JAVA_HOME_11_arm64   |
| 17.0.15+6            | JAVA_HOME_17_arm64   |
| 21.0.7+6.0 (default) | JAVA_HOME_21_arm64   |

### Cached Tools

#### Ruby
- 3.1.7
- 3.2.8
- 3.3.8
- 3.4.3

#### Python
- 3.11.9
- 3.12.10
- 3.13.3

#### Node.js
- 18.20.8
- 20.19.0
- 22.14.0

#### Go
- 1.21.13
- 1.22.12
- 1.23.8
- 1.24.2

### Rust Tools
- Cargo 1.86.0
- Rust 1.86.0
- Rustdoc 1.86.0
- Rustup 1.28.1

#### Packages
- Clippy 0.1.86
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.7

#### PowerShell Modules
- Az: 12.4.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Xcode
| Version        | Build    | Path                         | Symlinks                                                                                  |
| -------------- | -------- | ---------------------------- | ----------------------------------------------------------------------------------------- |
| 16.3           | 16E140   | /Applications/Xcode_16.3.app | /Applications/Xcode_16.3.0.app                                                            |
| 16.2           | 16C5032a | /Applications/Xcode_16.2.app | /Applications/Xcode_16.2.0.app                                                            |
| 16.1           | 16B40    | /Applications/Xcode_16.1.app | /Applications/Xcode_16.1.0.app                                                            |
| 16.0 (default) | 16A242d  | /Applications/Xcode_16.app   | /Applications/Xcode_16.0.0.app<br>/Applications/Xcode_16.0.app<br>/Applications/Xcode.app |
| 15.4           | 15F31d   | /Applications/Xcode_15.4.app | /Applications/Xcode_15.4.0.app                                                            |

#### Installed SDKs
| SDK                      | SDK Name             | Xcode Version |
| ------------------------ | -------------------- | ------------- |
| macOS 14.5               | macosx14.5           | 15.4          |
| macOS 15.0               | macosx15.0           | 16.0          |
| macOS 15.1               | macosx15.1           | 16.1          |
| macOS 15.2               | macosx15.2           | 16.2          |
| macOS 15.4               | macosx15.4           | 16.3          |
| iOS 17.5                 | iphoneos17.5         | 15.4          |
| iOS 18.0                 | iphoneos18.0         | 16.0          |
| iOS 18.1                 | iphoneos18.1         | 16.1          |
| iOS 18.2                 | iphoneos18.2         | 16.2          |
| iOS 18.4                 | iphoneos18.4         | 16.3          |
| Simulator - iOS 17.5     | iphonesimulator17.5  | 15.4          |
| Simulator - iOS 18.0     | iphonesimulator18.0  | 16.0          |
| Simulator - iOS 18.1     | iphonesimulator18.1  | 16.1          |
| Simulator - iOS 18.2     | iphonesimulator18.2  | 16.2          |
| Simulator - iOS 18.4     | iphonesimulator18.4  | 16.3          |
| tvOS 17.5                | appletvos17.5        | 15.4          |
| tvOS 18.0                | appletvos18.0        | 16.0          |
| tvOS 18.1                | appletvos18.1        | 16.1          |
| tvOS 18.2                | appletvos18.2        | 16.2          |
| tvOS 18.4                | appletvos18.4        | 16.3          |
| Simulator - tvOS 17.5    | appletvsimulator17.5 | 15.4          |
| Simulator - tvOS 18.0    | appletvsimulator18.0 | 16.0          |
| Simulator - tvOS 18.1    | appletvsimulator18.1 | 16.1          |
| Simulator - tvOS 18.2    | appletvsimulator18.2 | 16.2          |
| Simulator - tvOS 18.4    | appletvsimulator18.4 | 16.3          |
| watchOS 10.5             | watchos10.5          | 15.4          |
| watchOS 11.0             | watchos11.0          | 16.0          |
| watchOS 11.1             | watchos11.1          | 16.1          |
| watchOS 11.2             | watchos11.2          | 16.2          |
| watchOS 11.4             | watchos11.4          | 16.3          |
| Simulator - watchOS 10.5 | watchsimulator10.5   | 15.4          |
| Simulator - watchOS 11.0 | watchsimulator11.0   | 16.0          |
| Simulator - watchOS 11.1 | watchsimulator11.1   | 16.1          |
| Simulator - watchOS 11.2 | watchsimulator11.2   | 16.2          |
| Simulator - watchOS 11.4 | watchsimulator11.4   | 16.3          |
| visionOS 1.2             | xros1.2              | 15.4          |
| visionOS 2.0             | xros2.0              | 16.0          |
| visionOS 2.1             | xros2.1              | 16.1          |
| visionOS 2.2             | xros2.2              | 16.2          |
| visionOS 2.4             | xros2.4              | 16.3          |
| Simulator - visionOS 1.2 | xrsimulator1.2       | 15.4          |
| Simulator - visionOS 2.0 | xrsimulator2.0       | 16.0          |
| Simulator - visionOS 2.1 | xrsimulator2.1       | 16.1          |
| Simulator - visionOS 2.2 | xrsimulator2.2       | 16.2          |
| Simulator - visionOS 2.4 | xrsimulator2.4       | 16.3          |
| DriverKit 23.5           | driverkit23.5        | 15.4          |
| DriverKit 24.0           | driverkit24.0        | 16.0          |
| DriverKit 24.1           | driverkit24.1        | 16.1          |
| DriverKit 24.2           | driverkit24.2        | 16.2          |
| DriverKit 24.4           | driverkit24.4        | 16.3          |

#### Installed Simulators
| OS           | Simulators                                                                                                                                                                                                                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 17.5     | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                            |
| iOS 18.0     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                            |
| iOS 18.1     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                                   |
| iOS 18.2     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                                   |
| iOS 18.3     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad (A16)<br>iPad Air 11-inch (M2)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M2)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                     |
| iOS 18.4     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad (A16)<br>iPad Air 11-inch (M2)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M2)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                     |
| tvOS 17.5    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 18.0    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 18.1    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 18.2    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 18.4    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| watchOS 10.5 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 11.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                         |
| watchOS 11.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                         |
| watchOS 11.2 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                         |
| watchOS 11.4 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                         |
| visionOS 1.2 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                       |
| visionOS 2.0 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                       |
| visionOS 2.1 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                       |
| visionOS 2.2 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                       |
| visionOS 2.3 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                       |
| visionOS 2.4 | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                       |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                     |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                                                                                                                                        |
| Android Emulator           | 35.4.9                                                                                                                                                                                                                                                                                      |
| Android SDK Build-tools    | 36.0.0<br>35.0.0 35.0.1                                                                                                                                                                                                                                                                     |
| Android SDK Platforms      | android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1) |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                                                                                      |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                      |
| CMake                      | 3.31.5                                                                                                                                                                                                                                                                                      |
| Google Play services       | 49                                                                                                                                                                                                                                                                                          |
| Google Repository          | 58                                                                                                                                                                                                                                                                                          |
| NDK                        | 26.3.11579264<br>27.2.12479018 (default)<br>28.1.13356709                                                                                                                                                                                                                                   |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/28.1.13356709 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

