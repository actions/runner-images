| Announcements |
|-|
| [macOS 26 (Tahoe) is now generally available in GitHub Actions](https://github.com/actions/runner-images/issues/13739) |
| [[macOS] The macOS 14 Sonoma based runner images will begin deprecation on July 6th and will be fully unsupported by November 2nd for GitHub Actions and Azure DevOps](https://github.com/actions/runner-images/issues/13518) |
***
# macOS 26
- OS Version: macOS 26.3.1 (25D2128)
- Kernel Version: Darwin 25.3.0
- Image Version: 20260324.0226.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.419, 9.0.102, 9.0.203, 9.0.312, 10.0.103, 10.0.201
- Bash 3.2.57(1)-release
- Clang/LLVM 17.0.0
- Clang/LLVM (Homebrew) 20.1.8 - available on `$(brew --prefix llvm@20)/bin/clang`
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.3.0) - available by `gcc-14` alias
- GCC 15 (Homebrew GCC 15.2.0_1) - available by `gcc-15` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.3.0) - available by `gfortran-14` alias
- GNU Fortran 15 (Homebrew GCC 15.2.0_1) - available by `gfortran-15` alias
- Kotlin 2.3.20-release-208
- Node.js 24.14.0
- Perl 5.42.1
- PHP 8.5.4
- Python3 3.14.3
- Ruby 3.4.9

### Package Management
- Bundler 4.0.8
- Carthage 0.40.0
- CocoaPods 1.16.2
- Composer 2.9.5
- Homebrew 5.1.1
- NPM 11.9.0
- Pip3 26.0 (python 3.14)
- Pipx 1.11.0
- RubyGems 4.0.8
- Vcpkg 2026 (build from commit ed8445dd2a)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.14
- Gradle 9.4.1

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.32.2
- bazel 9.0.1
- bazelisk 1.28.1
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.19.0
- Git 2.53.0
- Git LFS 3.7.1
- GitHub CLI 2.88.1
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.5.18
- jq 1.8.1
- OpenSSL 3.6.1 27 Jan 2026 (Library: OpenSSL 3.6.1 27 Jan 2026)
- Packer 1.15.0
- pkgconf 2.5.1
- Unxip 3.3
- yq 4.52.4
- zstd 1.5.7
- Ninja 1.13.2

### Tools
- AWS CLI 2.34.15
- AWS SAM CLI 1.156.0
- AWS Session Manager CLI 1.2.792.0
- Azure CLI 2.84.0
- Azure CLI (azure-devops) 1.0.2
- Bicep CLI 0.41.2
- Cmake 4.3.0
- CodeQL Action Bundle 2.24.3
- Fastlane 2.232.2
- SwiftFormat 0.60.1
- Xcbeautify 3.1.4
- Xcode Command Line Tools 26.3.0.0.1.1771626560
- Xcodes 1.6.2

### Linters
- SwiftLint 0.63.2

### Browsers
- Safari 26.3.1 (21623.2.7.11.7)
- SafariDriver 26.3.1 (21623.2.7.11.7)
- Google Chrome 146.0.7680.165
- Google Chrome for Testing 146.0.7680.165
- ChromeDriver 146.0.7680.165
- Microsoft Edge 146.0.3856.72
- Microsoft Edge WebDriver 146.0.3856.72
- Mozilla Firefox 149.0
- geckodriver 0.36.0
- Selenium server 4.41.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version               | Environment Variable |
| --------------------- | -------------------- |
| 11.0.30+7             | JAVA_HOME_11_X64     |
| 17.0.18+8             | JAVA_HOME_17_X64     |
| 21.0.10+7.0 (default) | JAVA_HOME_21_X64     |
| 25.0.2+10.0           | JAVA_HOME_25_X64     |

### Cached Tools

#### Ruby
- 3.2.10
- 3.3.10
- 3.4.9
- 4.0.2

#### Python
- 3.11.9
- 3.12.10
- 3.13.12
- 3.14.3

#### Node.js
- 20.20.1
- 22.22.1
- 24.14.0

#### Go
- 1.23.12
- 1.24.13
- 1.25.8

### Rust Tools
- Cargo 1.94.0
- Rust 1.94.0
- Rustdoc 1.94.0
- Rustup 1.29.0

#### Packages
- Clippy 0.1.94
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.14

#### PowerShell Modules
- Az: 14.6.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.25.0

### Xcode
| Version        | Build  | Path                                           | Symlinks                                                       |
| -------------- | ------ | ---------------------------------------------- | -------------------------------------------------------------- |
| 26.4           | 17E192 | /Applications/Xcode_26.4_Release_Candidate.app | /Applications/Xcode_26.4.0.app<br>/Applications/Xcode_26.4.app |
| 26.3           | 17C529 | /Applications/Xcode_26.3.app                   | /Applications/Xcode_26.3.0.app                                 |
| 26.2 (default) | 17C52  | /Applications/Xcode_26.2.app                   | /Applications/Xcode_26.2.0.app<br>/Applications/Xcode.app      |
| 26.1.1         | 17B100 | /Applications/Xcode_26.1.1.app                 | /Applications/Xcode_26.1.app                                   |
| 26.0.1         | 17A400 | /Applications/Xcode_26.0.1.app                 | /Applications/Xcode_26.0.app                                   |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 26.0                | macosx26.0           | 26.0.1        |
| macOS 26.1                | macosx26.1           | 26.1.1        |
| macOS 26.2                | macosx26.2           | 26.2, 26.3    |
| macOS 26.4                | macosx26.4           | 26.4          |
| iOS 26.0                  | iphoneos26.0         | 26.0.1        |
| iOS 26.1                  | iphoneos26.1         | 26.1.1        |
| iOS 26.2                  | iphoneos26.2         | 26.2, 26.3    |
| iOS 26.4                  | iphoneos26.4         | 26.4          |
| Simulator - iOS 26.0      | iphonesimulator26.0  | 26.0.1        |
| Simulator - iOS 26.1      | iphonesimulator26.1  | 26.1.1        |
| Simulator - iOS 26.2      | iphonesimulator26.2  | 26.2, 26.3    |
| Simulator - iOS 26.4      | iphonesimulator26.4  | 26.4          |
| tvOS 26.0                 | appletvos26.0        | 26.0.1        |
| tvOS 26.1                 | appletvos26.1        | 26.1.1        |
| tvOS 26.2                 | appletvos26.2        | 26.2, 26.3    |
| tvOS 26.4                 | appletvos26.4        | 26.4          |
| Simulator - tvOS 26.0     | appletvsimulator26.0 | 26.0.1        |
| Simulator - tvOS 26.1     | appletvsimulator26.1 | 26.1.1        |
| Simulator - tvOS 26.2     | appletvsimulator26.2 | 26.2, 26.3    |
| Simulator - tvOS 26.4     | appletvsimulator26.4 | 26.4          |
| watchOS 26.0              | watchos26.0          | 26.0.1        |
| watchOS 26.1              | watchos26.1          | 26.1.1        |
| watchOS 26.2              | watchos26.2          | 26.2, 26.3    |
| watchOS 26.4              | watchos26.4          | 26.4          |
| Simulator - watchOS 26.0  | watchsimulator26.0   | 26.0.1        |
| Simulator - watchOS 26.1  | watchsimulator26.1   | 26.1.1        |
| Simulator - watchOS 26.2  | watchsimulator26.2   | 26.2, 26.3    |
| Simulator - watchOS 26.4  | watchsimulator26.4   | 26.4          |
| visionOS 26.0             | xros26.0             | 26.0.1        |
| visionOS 26.1             | xros26.1             | 26.1.1        |
| visionOS 26.2             | xros26.2             | 26.2, 26.3    |
| visionOS 26.4             | xros26.4             | 26.4          |
| Simulator - visionOS 26.0 | xrsimulator26.0      | 26.0.1        |
| Simulator - visionOS 26.1 | xrsimulator26.1      | 26.1.1        |
| Simulator - visionOS 26.2 | xrsimulator26.2      | 26.2, 26.3    |
| Simulator - visionOS 26.4 | xrsimulator26.4      | 26.4          |
| DriverKit 25.0            | driverkit25.0        | 26.0.1        |
| DriverKit 25.1            | driverkit25.1        | 26.1.1        |
| DriverKit 25.2            | driverkit25.2        | 26.2, 26.3    |
| DriverKit 25.4            | driverkit25.4        | 26.4          |

#### Installed Simulators
| Name         | OS     | Simulators                                                                                                                                                                                                                                                             |
| ------------ | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 26.0     | 26.0.1 | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M4)<br>iPad Pro 13-inch (M5) |
| iOS 26.1     | 26.1   | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5)                                                   |
| iOS 26.2     | 26.2   | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5)                                                   |
| tvOS 26.0    | 26.0   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                    |
| tvOS 26.1    | 26.1   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                    |
| tvOS 26.2    | 26.2   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                    |
| watchOS 26.0 | 26.0   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                                                                       |
| watchOS 26.1 | 26.1   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                                                                       |
| watchOS 26.2 | 26.2   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                                                                       |

### Android
| Package Name               | Version                                                                                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                             |
| Android Emulator           | 36.4.10                                                                                                                                                                          |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1                                                                                                                                                   |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2) |
| Android SDK Platform-Tools | 37.0.0                                                                                                                                                                           |
| Android Support Repository | 47.0.0                                                                                                                                                                           |
| CMake                      | 3.31.5<br>4.1.2                                                                                                                                                                  |
| Google Play services       | 49                                                                                                                                                                               |
| Google Repository          | 58                                                                                                                                                                               |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                        |

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

