| Announcements |
|-|
| [[macOS] Xcode 27 is now available as a public preview](https://github.com/actions/runner-images/issues/14404) |
| [[macOS] Default Xcode on macOS 26 Tahoe will be set to Xcode 26.6 on 2026.07.21](https://github.com/actions/runner-images/issues/14344) |
| [[macOS] The macOS 14 Sonoma based runner images will begin deprecation on July 6th and will be fully unsupported by November 2nd for GitHub Actions and Azure DevOps](https://github.com/actions/runner-images/issues/13518) |
***
# macOS 26
- OS Version: macOS 26.6.1 (25G76)
- Kernel Version: Darwin 25.6.0
- Image Version: 20260824.0517.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.424, 9.0.102, 9.0.203, 9.0.317, 10.0.103, 10.0.203, 10.0.302, 10.0.400
- Bash 3.2.57(1)-release
- Clang/LLVM 21.0.0
- Clang/LLVM (Homebrew) 20.1.8 - available on `$(brew --prefix llvm@20)/bin/clang`
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.4.0) - available by `gcc-14` alias
- GCC 15 (Homebrew GCC 15.3.0) - available by `gcc-15` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.4.0) - available by `gfortran-14` alias
- GNU Fortran 15 (Homebrew GCC 15.3.0) - available by `gfortran-15` alias
- Kotlin 2.4.10-release-377
- Node.js 24.19.0
- Perl 5.44.0
- PHP 8.5.9
- Python3 3.14.7
- Ruby 3.4.10

### Package Management
- Bundler 4.0.19
- Carthage 0.40.0
- CocoaPods 1.17.0
- Composer 2.10.2
- Homebrew 6.0.18
- NPM 11.17.0
- Pip3 26.2.1 (python 3.14)
- Pipx 1.16.7
- RubyGems 4.0.19
- Vcpkg 2026 (build from commit 127402f1c7)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.17
- Apache Maven 3.9.16
- Gradle 9.7.1

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.32.7
- bazel 9.2.0
- bazelisk 1.29.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.21.0
- Git 2.55.0
- Git LFS 3.7.1
- GitHub CLI 2.98.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.5.21
- jq 1.8.2
- OpenSSL 3.6.3 9 Jun 2026 (Library: OpenSSL 3.6.3 9 Jun 2026)
- Packer 1.15.4
- pkgconf 3.0.5
- Unxip 3.3
- yq 4.53.6
- zstd 1.5.7
- Ninja 1.13.2

### Tools
- AWS CLI 2.36.29
- AWS SAM CLI 1.165.0
- AWS Session Manager CLI 1.2.835.0
- Azure CLI 2.89.1
- Azure CLI (azure-devops) 1.0.6
- Bicep CLI 0.46.1
- Cmake 4.4.2
- CodeQL Action Bundle 2.26.3
- Fastlane 2.238.0
- SwiftFormat 0.62.1
- Xcbeautify 3.2.1
- Xcode Command Line Tools 26.6.0.0.1781586589
- Xcodes 2.0.3

### Linters
- SwiftLint 0.65.1

### Browsers
- Safari 26.6 (21624.4.5.11.5)
- SafariDriver 26.6 (21624.4.5.11.5)
- Google Chrome 151.0.7922.174
- Google Chrome for Testing 151.0.7922.138
- ChromeDriver 151.0.7922.138
- Microsoft Edge 151.0.4129.101
- Microsoft Edge WebDriver 151.0.4129.101
- Mozilla Firefox 154.0
- geckodriver 0.37.1
- Selenium server 4.47.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version                 | Environment Variable |
| ----------------------- | -------------------- |
| 11.0.32+9               | JAVA_HOME_11_X64     |
| 17.0.20+101             | JAVA_HOME_17_X64     |
| 21.0.12+101.0 (default) | JAVA_HOME_21_X64     |
| 25.0.4+101.0            | JAVA_HOME_25_X64     |

### Cached Tools

#### Ruby
- 3.2.11
- 3.3.12
- 3.4.10
- 4.0.6

#### Python
- 3.11.9
- 3.12.10
- 3.13.15
- 3.14.7

#### Node.js
- 22.23.2
- 24.19.0

#### Go
- 1.24.13
- 1.25.14
- 1.26.7

### Rust Tools
- Cargo 1.98.0
- Rust 1.98.0
- Rustdoc 1.98.0
- Rustup 1.29.0

#### Packages
- Clippy 0.1.98
- Rustfmt 1.9.0-stable

### PowerShell Tools
- PowerShell 7.6.4

#### PowerShell Modules
- Az: 15.6.1
- Pester: 5.9.0
- PSScriptAnalyzer: 1.25.0

### Xcode
| Version        | Build  | Path                           | Symlinks                                                  |
| -------------- | ------ | ------------------------------ | --------------------------------------------------------- |
| 26.6 (default) | 17F113 | /Applications/Xcode_26.6.app   | /Applications/Xcode_26.6.0.app<br>/Applications/Xcode.app |
| 26.5           | 17F42  | /Applications/Xcode_26.5.app   | /Applications/Xcode_26.5.0.app                            |
| 26.4.1         | 17E202 | /Applications/Xcode_26.4.1.app | /Applications/Xcode_26.4.app                              |
| 26.3           | 17C529 | /Applications/Xcode_26.3.app   | /Applications/Xcode_26.3.0.app                            |
| 26.2           | 17C52  | /Applications/Xcode_26.2.app   | /Applications/Xcode_26.2.0.app                            |
| 26.1.1         | 17B100 | /Applications/Xcode_26.1.1.app | /Applications/Xcode_26.1.app                              |
| 26.0.1         | 17A400 | /Applications/Xcode_26.0.1.app | /Applications/Xcode_26.0.app                              |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 26.0                | macosx26.0           | 26.0.1        |
| macOS 26.1                | macosx26.1           | 26.1.1        |
| macOS 26.2                | macosx26.2           | 26.2, 26.3    |
| macOS 26.4                | macosx26.4           | 26.4.1        |
| macOS 26.5                | macosx26.5           | 26.5, 26.6    |
| iOS 26.0                  | iphoneos26.0         | 26.0.1        |
| iOS 26.1                  | iphoneos26.1         | 26.1.1        |
| iOS 26.2                  | iphoneos26.2         | 26.2, 26.3    |
| iOS 26.4                  | iphoneos26.4         | 26.4.1        |
| iOS 26.5                  | iphoneos26.5         | 26.5, 26.6    |
| Simulator - iOS 26.0      | iphonesimulator26.0  | 26.0.1        |
| Simulator - iOS 26.1      | iphonesimulator26.1  | 26.1.1        |
| Simulator - iOS 26.2      | iphonesimulator26.2  | 26.2, 26.3    |
| Simulator - iOS 26.4      | iphonesimulator26.4  | 26.4.1        |
| Simulator - iOS 26.5      | iphonesimulator26.5  | 26.5, 26.6    |
| tvOS 26.0                 | appletvos26.0        | 26.0.1        |
| tvOS 26.1                 | appletvos26.1        | 26.1.1        |
| tvOS 26.2                 | appletvos26.2        | 26.2, 26.3    |
| tvOS 26.4                 | appletvos26.4        | 26.4.1        |
| tvOS 26.5                 | appletvos26.5        | 26.5, 26.6    |
| Simulator - tvOS 26.0     | appletvsimulator26.0 | 26.0.1        |
| Simulator - tvOS 26.1     | appletvsimulator26.1 | 26.1.1        |
| Simulator - tvOS 26.2     | appletvsimulator26.2 | 26.2, 26.3    |
| Simulator - tvOS 26.4     | appletvsimulator26.4 | 26.4.1        |
| Simulator - tvOS 26.5     | appletvsimulator26.5 | 26.5, 26.6    |
| watchOS 26.0              | watchos26.0          | 26.0.1        |
| watchOS 26.1              | watchos26.1          | 26.1.1        |
| watchOS 26.2              | watchos26.2          | 26.2, 26.3    |
| watchOS 26.4              | watchos26.4          | 26.4.1        |
| watchOS 26.5              | watchos26.5          | 26.5, 26.6    |
| Simulator - watchOS 26.0  | watchsimulator26.0   | 26.0.1        |
| Simulator - watchOS 26.1  | watchsimulator26.1   | 26.1.1        |
| Simulator - watchOS 26.2  | watchsimulator26.2   | 26.2, 26.3    |
| Simulator - watchOS 26.4  | watchsimulator26.4   | 26.4.1        |
| Simulator - watchOS 26.5  | watchsimulator26.5   | 26.5, 26.6    |
| visionOS 26.0             | xros26.0             | 26.0.1        |
| visionOS 26.1             | xros26.1             | 26.1.1        |
| visionOS 26.2             | xros26.2             | 26.2, 26.3    |
| visionOS 26.4             | xros26.4             | 26.4.1        |
| visionOS 26.5             | xros26.5             | 26.5, 26.6    |
| Simulator - visionOS 26.0 | xrsimulator26.0      | 26.0.1        |
| Simulator - visionOS 26.1 | xrsimulator26.1      | 26.1.1        |
| Simulator - visionOS 26.2 | xrsimulator26.2      | 26.2, 26.3    |
| Simulator - visionOS 26.4 | xrsimulator26.4      | 26.4.1        |
| Simulator - visionOS 26.5 | xrsimulator26.5      | 26.5, 26.6    |
| DriverKit 25.0            | driverkit25.0        | 26.0.1        |
| DriverKit 25.1            | driverkit25.1        | 26.1.1        |
| DriverKit 25.2            | driverkit25.2        | 26.2, 26.3    |
| DriverKit 25.4            | driverkit25.4        | 26.4.1        |
| DriverKit 25.5            | driverkit25.5        | 26.5, 26.6    |

#### Installed Simulators
| Name         | OS     | Simulators                                                                                                                                                                                                           |
| ------------ | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 26.2     | 26.2   | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5) |
| iOS 26.4     | 26.4.1 | iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone 17e<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M4)<br>iPad Air 13-inch (M4)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5) |
| iOS 26.5     | 26.5   | iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone 17e<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M4)<br>iPad Air 13-inch (M4)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5) |
| tvOS 26.2    | 26.2   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                  |
| tvOS 26.4    | 26.4   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                  |
| tvOS 26.5    | 26.5   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                  |
| watchOS 26.2 | 26.2   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                     |
| watchOS 26.4 | 26.4   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                     |
| watchOS 26.5 | 26.5   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                     |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                    |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                                                                                                                                                                       |
| Android Emulator           | 37.1.11                                                                                                                                                                                                                                                                                                                    |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1                                                                                                                                                                                                                                                                                   |
| Android SDK Platforms      | android-37.2-beta3 (rev 3)<br>android-37.2-beta2 (rev 2)<br>android-37.2-beta1 (rev 1)<br>android-37.1 (rev 1)<br>android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2) |
| Android SDK Platform-Tools | 37.0.1                                                                                                                                                                                                                                                                                                                     |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                     |
| CMake                      | 3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                            |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                         |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                         |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                                  |

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
- Tcl/Tk 8.6.18

