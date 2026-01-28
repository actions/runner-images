| Announcements |
|-|
| [[macOS] Deprecation of simulator runtimes for Xcode 26.0.1 on macOS 15 on January 26th](https://github.com/actions/runner-images/issues/13570) |
| [[macOS] Default Xcode on macOS 26 Tahoe will be set to Xcode 26.2 on January 26th](https://github.com/actions/runner-images/issues/13519) |
| [[macOS] The macOS 14 Sonoma based runner images will begin deprecation on July 6th and will be fully unsupported by November 2nd for GitHub Actions and Azure DevOps](https://github.com/actions/runner-images/issues/13518) |
| [[all OSs] Updating Azure PowerShell Module version to 14.6.0 on January 26th, 2026.](https://github.com/actions/runner-images/issues/13473) |
| [macOS 26 (Tahoe) is now available as a public beta in GitHub Actions](https://github.com/actions/runner-images/issues/13008) |
***
# macOS 14
- OS Version: macOS 14.8.3 (23J220)
- Kernel Version: Darwin 23.6.0
- Image Version: 20260126.0100.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.417, 9.0.102, 9.0.203, 9.0.310, 10.0.102
- Bash 3.2.57(1)-release
- Clang/LLVM 15.0.0
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.3.0) - available by `gcc-14` alias
- GCC 15 (Homebrew GCC 15.2.0) - available by `gcc-15` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.3.0) - available by `gfortran-14` alias
- GNU Fortran 15 (Homebrew GCC 15.2.0) - available by `gfortran-15` alias
- Kotlin 2.3.0-release-356
- Mono 6.12.0.188
- Node.js 20.19.6
- Perl 5.42.0
- Python3 3.14.2
- Ruby 3.3.10

### Package Management
- Bundler 4.0.4
- Carthage 0.40.0
- CocoaPods 1.16.2
- Homebrew 5.0.11
- NPM 10.8.2
- NuGet 6.3.1.1
- Pip3 25.3 (python 3.14)
- Pipx 1.8.0
- RubyGems 4.0.4
- Vcpkg 2025 (build from commit 6d332a018c)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.12
- Gradle 9.3.0

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.31.1
- bazel 9.0.0
- bazelisk 1.28.1
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.52.0
- Git LFS 3.7.1
- GitHub CLI 2.86.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.4.9
- jq 1.8.1
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.14.3
- pkgconf 2.5.1
- Unxip 3.3
- yq 4.50.1
- zstd 1.5.7
- Ninja 1.13.2

### Tools
- AWS CLI 2.33.6
- AWS SAM CLI 1.152.0
- AWS Session Manager CLI 1.2.764.0
- Azure CLI 2.82.0
- Azure CLI (azure-devops) 1.0.2
- Bicep CLI 0.39.26
- Cmake 4.2.2
- CodeQL Action Bundle 2.23.9
- Fastlane 2.231.1
- SwiftFormat 0.58.7
- Xcbeautify 3.1.3
- Xcode Command Line Tools 16.2.0.0.1.1733547573
- Xcodes 1.6.2

### Browsers
- Safari 26.2 (19623.1.14.18.4)
- SafariDriver 26.2 (19623.1.14.18.4)
- Google Chrome 144.0.7559.97
- Google Chrome for Testing 144.0.7559.96
- ChromeDriver 144.0.7559.96
- Microsoft Edge 144.0.3719.92
- Microsoft Edge WebDriver 144.0.3719.92
- Mozilla Firefox 147.0.1
- geckodriver 0.36.0
- Selenium server 4.40.0

#### Environment variables
| Name            | Value                                   |
| --------------- | --------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-arm64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver            |
| GECKOWEBDRIVER  | /opt/homebrew/opt/geckodriver/bin       |

### Java
| Version               | Environment Variable |
| --------------------- | -------------------- |
| 11.0.29+7             | JAVA_HOME_11_arm64   |
| 17.0.17+10            | JAVA_HOME_17_arm64   |
| 21.0.9+10.0 (default) | JAVA_HOME_21_arm64   |
| 25.0.1+8.0            | JAVA_HOME_25_arm64   |

### Cached Tools

#### Ruby
- 3.2.10
- 3.3.10
- 3.4.8
- 4.0.1

#### Python
- 3.11.9
- 3.12.10
- 3.13.11
- 3.14.2

#### Node.js
- 20.20.0
- 22.22.0
- 24.13.0

#### Go
- 1.22.12
- 1.23.12
- 1.24.12
- 1.25.6

### Rust Tools
- Cargo 1.93.0
- Rust 1.93.0
- Rustdoc 1.93.0
- Rustup 1.28.2

#### Packages
- Clippy 0.1.93
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.13

#### PowerShell Modules
- Az: 14.6.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Xcode
| Version        | Build    | Path                           | Symlinks                                                  |
| -------------- | -------- | ------------------------------ | --------------------------------------------------------- |
| 16.2           | 16C5032a | /Applications/Xcode_16.2.app   | /Applications/Xcode_16.2.0.app                            |
| 16.1           | 16B40    | /Applications/Xcode_16.1.app   | /Applications/Xcode_16.1.0.app                            |
| 15.4 (default) | 15F31d   | /Applications/Xcode_15.4.app   | /Applications/Xcode_15.4.0.app<br>/Applications/Xcode.app |
| 15.3           | 15E204a  | /Applications/Xcode_15.3.app   | /Applications/Xcode_15.3.0.app                            |
| 15.2           | 15C500b  | /Applications/Xcode_15.2.app   | /Applications/Xcode_15.2.0.app                            |
| 15.1           | 15C65    | /Applications/Xcode_15.1.app   | /Applications/Xcode_15.1.0.app                            |
| 15.0.1         | 15A507   | /Applications/Xcode_15.0.1.app | /Applications/Xcode_15.0.app                              |

#### Installed SDKs
| SDK                      | SDK Name             | Xcode Version |
| ------------------------ | -------------------- | ------------- |
| macOS 14.0               | macosx14.0           | 15.0.1        |
| macOS 14.2               | macosx14.2           | 15.1, 15.2    |
| macOS 14.4               | macosx14.4           | 15.3          |
| macOS 14.5               | macosx14.5           | 15.4          |
| macOS 15.1               | macosx15.1           | 16.1          |
| macOS 15.2               | macosx15.2           | 16.2          |
| iOS 17.0                 | iphoneos17.0         | 15.0.1        |
| iOS 17.2                 | iphoneos17.2         | 15.1, 15.2    |
| iOS 17.4                 | iphoneos17.4         | 15.3          |
| iOS 17.5                 | iphoneos17.5         | 15.4          |
| iOS 18.1                 | iphoneos18.1         | 16.1          |
| iOS 18.2                 | iphoneos18.2         | 16.2          |
| Simulator - iOS 17.0     | iphonesimulator17.0  | 15.0.1        |
| Simulator - iOS 17.2     | iphonesimulator17.2  | 15.1, 15.2    |
| Simulator - iOS 17.4     | iphonesimulator17.4  | 15.3          |
| Simulator - iOS 17.5     | iphonesimulator17.5  | 15.4          |
| Simulator - iOS 18.1     | iphonesimulator18.1  | 16.1          |
| Simulator - iOS 18.2     | iphonesimulator18.2  | 16.2          |
| tvOS 17.0                | appletvos17.0        | 15.0.1        |
| tvOS 17.2                | appletvos17.2        | 15.1, 15.2    |
| tvOS 17.4                | appletvos17.4        | 15.3          |
| tvOS 17.5                | appletvos17.5        | 15.4          |
| tvOS 18.1                | appletvos18.1        | 16.1          |
| tvOS 18.2                | appletvos18.2        | 16.2          |
| Simulator - tvOS 17.0    | appletvsimulator17.0 | 15.0.1        |
| Simulator - tvOS 17.2    | appletvsimulator17.2 | 15.1, 15.2    |
| Simulator - tvOS 17.4    | appletvsimulator17.4 | 15.3          |
| Simulator - tvOS 17.5    | appletvsimulator17.5 | 15.4          |
| Simulator - tvOS 18.1    | appletvsimulator18.1 | 16.1          |
| Simulator - tvOS 18.2    | appletvsimulator18.2 | 16.2          |
| watchOS 10.0             | watchos10.0          | 15.0.1        |
| watchOS 10.2             | watchos10.2          | 15.1, 15.2    |
| watchOS 10.4             | watchos10.4          | 15.3          |
| watchOS 10.5             | watchos10.5          | 15.4          |
| watchOS 11.1             | watchos11.1          | 16.1          |
| watchOS 11.2             | watchos11.2          | 16.2          |
| Simulator - watchOS 10.0 | watchsimulator10.0   | 15.0.1        |
| Simulator - watchOS 10.2 | watchsimulator10.2   | 15.1, 15.2    |
| Simulator - watchOS 10.4 | watchsimulator10.4   | 15.3          |
| Simulator - watchOS 10.5 | watchsimulator10.5   | 15.4          |
| Simulator - watchOS 11.1 | watchsimulator11.1   | 16.1          |
| Simulator - watchOS 11.2 | watchsimulator11.2   | 16.2          |
| visionOS 1.0             | xros1.0              | 15.2          |
| visionOS 1.1             | xros1.1              | 15.3          |
| visionOS 1.2             | xros1.2              | 15.4          |
| visionOS 2.1             | xros2.1              | 16.1          |
| visionOS 2.2             | xros2.2              | 16.2          |
| Simulator - visionOS 1.0 | xrsimulator1.0       | 15.2          |
| Simulator - visionOS 1.1 | xrsimulator1.1       | 15.3          |
| Simulator - visionOS 1.2 | xrsimulator1.2       | 15.4          |
| Simulator - visionOS 2.1 | xrsimulator2.1       | 16.1          |
| Simulator - visionOS 2.2 | xrsimulator2.2       | 16.2          |
| DriverKit 23.0           | driverkit23.0        | 15.0.1        |
| DriverKit 23.2           | driverkit23.2        | 15.1, 15.2    |
| DriverKit 23.4           | driverkit23.4        | 15.3          |
| DriverKit 23.5           | driverkit23.5        | 15.4          |
| DriverKit 24.1           | driverkit24.1        | 16.1          |
| DriverKit 24.2           | driverkit24.2        | 16.2          |

#### Installed Simulators
| Name         | OS     | Simulators                                                                                                                                                                                                                                                                                                                                                               |
| ------------ | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| iOS 17.0     | 17.0.1 | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                     |
| iOS 17.2     | 17.2   | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                     |
| iOS 17.4     | 17.4   | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| iOS 17.5     | 17.5   | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                              |
| iOS 18.1     | 18.1   | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                                     |
| iOS 18.2     | 18.2   | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                                     |
| tvOS 17.0    | 17.0   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                      |
| tvOS 17.2    | 17.2   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                      |
| tvOS 17.4    | 17.4   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                      |
| tvOS 17.5    | 17.5   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                      |
| tvOS 18.1    | 18.1   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                      |
| tvOS 18.2    | 18.2   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                      |
| watchOS 10.0 | 10.0   | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm)   |
| watchOS 10.2 | 10.2   | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm)   |
| watchOS 10.4 | 10.4   | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm)   |
| watchOS 10.5 | 10.5   | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm)   |
| watchOS 11.1 | 11.1   | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                           |
| watchOS 11.2 | 11.2   | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                           |
| visionOS 1.0 | 1.0    | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                         |
| visionOS 1.1 | 1.1    | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                         |
| visionOS 1.2 | 1.2    | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                         |
| visionOS 2.1 | 2.1    | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                         |
| visionOS 2.2 | 2.2    | Apple Vision Pro                                                                                                                                                                                                                                                                                                                                                         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 11.0                                                                                                                                                                                                                                                                                                                  |
| Android Emulator           | 36.3.10                                                                                                                                                                                                                                                                                                               |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1<br>34.0.0                                                                                                                                                                                                                                                                              |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3) |
| Android SDK Platform-Tools | 36.0.2                                                                                                                                                                                                                                                                                                                |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                |
| CMake                      | 3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                       |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                    |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                             |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/29.0.14206865 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/27.3.13750724 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

### Miscellaneous
- Tcl/Tk 8.6.17

