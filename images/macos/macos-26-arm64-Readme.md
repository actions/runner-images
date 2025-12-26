| Announcements |
|-|
| [[macOS] Deprecation of Xcode 16.3 and older runtimes on macOS 15 on January 12th, 2026.](https://github.com/actions/runner-images/issues/13392) |
| [[macOS] The macOS 13 Ventura based runner images will begin deprecation on September 22nd and will be fully unsupported by December 4th for GitHub and ADO](https://github.com/actions/runner-images/issues/13046) |
| [[macOS] The additional macOS 15 Sonoma Intel-based image will be available in GitHub Actions](https://github.com/actions/runner-images/issues/13045) |
| [macOS 26 (Tahoe) is now available as a public beta in GitHub Actions](https://github.com/actions/runner-images/issues/13008) |
***
# macOS 26
- OS Version: macOS 26.0.1 (25A362)
- Kernel Version: Darwin 25.0.0
- Image Version: 20251216.0100.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.416, 9.0.102, 9.0.203, 9.0.308, 10.0.101
- Bash 3.2.57(1)-release
- Clang/LLVM 17.0.0
- Clang/LLVM (Homebrew) 20.1.8 - available on `$(brew --prefix llvm@20)/bin/clang`
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.3.0) - available by `gcc-14` alias
- GCC 15 (Homebrew GCC 15.2.0) - available by `gcc-15` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.3.0) - available by `gfortran-14` alias
- GNU Fortran 15 (Homebrew GCC 15.2.0) - available by `gfortran-15` alias
- Kotlin 2.2.21-release-469
- Node.js 24.12.0
- Perl 5.40.2
- Python3 3.14.2
- Ruby 3.4.7

### Package Management
- Bundler 4.0.1
- Carthage 0.40.0
- CocoaPods 1.16.2
- Homebrew 5.0.5
- NPM 11.6.2
- Pip3 25.3 (python 3.14)
- Pipx 1.8.0
- RubyGems 4.0.1
- Vcpkg 2025 (build from commit 2b6a882f61)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.11
- Gradle 9.2.1

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.31.0
- bazel 8.5.0
- bazelisk 1.27.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.50.1
- Git LFS 3.7.1
- GitHub CLI 2.83.2
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.4.8
- jq 1.8.1
- OpenSSL 3.6.0 1 Oct 2025 (Library: OpenSSL 3.6.0 1 Oct 2025)
- Packer 1.14.3
- pkgconf 2.5.1
- Unxip 3.2
- yq 4.50.1
- zstd 1.5.7
- Ninja 1.13.2

### Tools
- AWS CLI 2.32.17
- AWS SAM CLI 1.149.0
- AWS Session Manager CLI 1.2.764.0
- Azure CLI 2.81.0
- Azure CLI (azure-devops) 1.0.2
- Bicep CLI 0.39.26
- Cmake 4.2.1
- CodeQL Action Bundle 2.23.8
- Fastlane 2.229.1
- SwiftFormat 0.58.7
- Xcbeautify 3.1.2
- Xcode Command Line Tools 26.2.0.0.1.1764812424
- Xcodes 1.6.2

### Browsers
- Safari 26.0.1 (21622.1.22.11.15)
- SafariDriver 26.0.1 (21622.1.22.11.15)
- Google Chrome 143.0.7499.110
- Google Chrome for Testing 143.0.7499.42
- ChromeDriver 143.0.7499.42
- Microsoft Edge 143.0.3650.80
- Microsoft Edge WebDriver 143.0.3650.80
- Mozilla Firefox 146.0
- geckodriver 0.36.0
- Selenium server 4.38.0

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
- 3.2.9
- 3.3.10
- 3.4.7

#### Python
- 3.11.9
- 3.12.10
- 3.13.11
- 3.14.2

#### Node.js
- 20.19.6
- 22.21.1
- 24.12.0

#### Go
- 1.23.12
- 1.24.11
- 1.25.5

### Rust Tools
- Cargo 1.92.0
- Rust 1.92.0
- Rustdoc 1.92.0
- Rustup 1.28.2

#### Packages
- Clippy 0.1.92
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.13

#### PowerShell Modules
- Az: 14.3.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Xcode
| Version          | Build  | Path                           | Symlinks                                                |
| ---------------- | ------ | ------------------------------ | ------------------------------------------------------- |
| 26.2             | 17C52  | /Applications/Xcode_26.2.app   | /Applications/Xcode_26.2.0.app                          |
| 26.1.1           | 17B100 | /Applications/Xcode_26.1.1.app | /Applications/Xcode_26.1.app                            |
| 26.0.1 (default) | 17A400 | /Applications/Xcode_26.0.1.app | /Applications/Xcode_26.0.app<br>/Applications/Xcode.app |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 26.0                | macosx26.0           | 26.0.1        |
| macOS 26.1                | macosx26.1           | 26.1.1        |
| macOS 26.2                | macosx26.2           | 26.2          |
| iOS 26.0                  | iphoneos26.0         | 26.0.1        |
| iOS 26.1                  | iphoneos26.1         | 26.1.1        |
| iOS 26.2                  | iphoneos26.2         | 26.2          |
| Simulator - iOS 26.0      | iphonesimulator26.0  | 26.0.1        |
| Simulator - iOS 26.1      | iphonesimulator26.1  | 26.1.1        |
| Simulator - iOS 26.2      | iphonesimulator26.2  | 26.2          |
| tvOS 26.0                 | appletvos26.0        | 26.0.1        |
| tvOS 26.1                 | appletvos26.1        | 26.1.1        |
| tvOS 26.2                 | appletvos26.2        | 26.2          |
| Simulator - tvOS 26.0     | appletvsimulator26.0 | 26.0.1        |
| Simulator - tvOS 26.1     | appletvsimulator26.1 | 26.1.1        |
| Simulator - tvOS 26.2     | appletvsimulator26.2 | 26.2          |
| watchOS 26.0              | watchos26.0          | 26.0.1        |
| watchOS 26.1              | watchos26.1          | 26.1.1        |
| watchOS 26.2              | watchos26.2          | 26.2          |
| Simulator - watchOS 26.0  | watchsimulator26.0   | 26.0.1        |
| Simulator - watchOS 26.1  | watchsimulator26.1   | 26.1.1        |
| Simulator - watchOS 26.2  | watchsimulator26.2   | 26.2          |
| visionOS 26.0             | xros26.0             | 26.0.1        |
| visionOS 26.1             | xros26.1             | 26.1.1        |
| visionOS 26.2             | xros26.2             | 26.2          |
| Simulator - visionOS 26.0 | xrsimulator26.0      | 26.0.1        |
| Simulator - visionOS 26.1 | xrsimulator26.1      | 26.1.1        |
| Simulator - visionOS 26.2 | xrsimulator26.2      | 26.2          |
| DriverKit 25.0            | driverkit25.0        | 26.0.1        |
| DriverKit 25.1            | driverkit25.1        | 26.1.1        |
| DriverKit 25.2            | driverkit25.2        | 26.2          |

#### Installed Simulators
| Name          | OS     | Simulators                                                                                                                                                                                                                                                             |
| ------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 26.0      | 26.0.1 | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M4)<br>iPad Pro 13-inch (M5) |
| iOS 26.1      | 26.1   | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5)                                                   |
| iOS 26.2      | 26.2   | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5)                                                   |
| tvOS 26.0     | 26.0   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                    |
| tvOS 26.1     | 26.1   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                    |
| tvOS 26.2     | 26.2   | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                    |
| watchOS 26.0  | 26.0   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                                                                       |
| watchOS 26.1  | 26.1   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                                                                       |
| watchOS 26.2  | 26.2   | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                                                                       |
| visionOS 26.0 | 26.0   | Apple Vision Pro                                                                                                                                                                                                                                                       |
| visionOS 26.1 | 26.1   | Apple Vision Pro                                                                                                                                                                                                                                                       |
| visionOS 26.2 | 26.2   | Apple Vision Pro                                                                                                                                                                                                                                                       |

### Android
| Package Name               | Version                                                                                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                             |
| Android Emulator           | 36.3.10                                                                                                                                                                          |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1                                                                                                                                                   |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2) |
| Android SDK Platform-Tools | 36.0.0                                                                                                                                                                           |
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

