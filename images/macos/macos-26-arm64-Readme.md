| Announcements |
|-|
| [[macOS] The macOS 13 Ventura based runner images will begin deprecation on September 22nd and will be fully unsupported by December 4th for GitHub and ADO](https://github.com/actions/runner-images/issues/13046) |
| [[macOS] The additional macOS 15 Sonoma Intel-based image will be available in GitHub Actions](https://github.com/actions/runner-images/issues/13045) |
| [macOS 26 (Tahoe) is now available as a public beta in GitHub Actions](https://github.com/actions/runner-images/issues/13008) |
| [[macOS] Deprecation of 4 tools on November 3rd.](https://github.com/actions/runner-images/issues/12873) |
***
# macOS 26
- OS Version: macOS 26.0.1 (25A362)
- Kernel Version: Darwin 25.0.0
- Image Version: 20251014.0041

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.414, 9.0.102, 9.0.203, 9.0.305
- Bash 3.2.57(1)-release
- Clang/LLVM 17.0.0
- Clang/LLVM (Homebrew) 20.1.8 - available on `$(brew --prefix llvm@20)/bin/clang`
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.3.0) - available by `gcc-14` alias
- GCC 15 (Homebrew GCC 15.2.0) - available by `gcc-15` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.3.0) - available by `gfortran-14` alias
- GNU Fortran 15 (Homebrew GCC 15.2.0) - available by `gfortran-15` alias
- Kotlin 2.2.20-release-333
- Node.js 24.10.0
- Perl 5.40.2
- Python3 3.14.0
- Ruby 3.4.7

### Package Management
- Bundler 2.7.2
- Carthage 0.40.0
- CocoaPods 1.16.2
- Homebrew 4.6.17
- NPM 11.6.0
- Pip3 25.2 (python 3.14)
- Pipx 1.8.0
- RubyGems 3.7.2
- Vcpkg 2025 (build from commit 69a6e3311f)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.11
- Gradle 9.1.0

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.30.1
- bazel 8.4.2
- bazelisk 1.27.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.50.1
- Git LFS 3.7.0
- GitHub CLI 2.81.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.4.8
- jq 1.8.1
- OpenSSL 3.6.0 1 Oct 2025 (Library: OpenSSL 3.6.0 1 Oct 2025)
- Packer 1.14.2
- pkgconf 2.5.1
- Unxip 3.2
- yq 4.48.1
- zstd 1.5.7
- Ninja 1.13.1

### Tools
- AWS CLI 2.31.14
- AWS SAM CLI 1.144.0
- AWS Session Manager CLI 1.2.707.0
- Azure CLI 2.78.0
- Azure CLI (azure-devops) 1.0.2
- Bicep CLI 0.38.33
- Cmake 4.1.2
- CodeQL Action Bundle 2.23.2
- Fastlane 2.228.0
- SwiftFormat 0.58.3
- Xcbeautify 2.30.1
- Xcode Command Line Tools 26.0.0.0.1.1757719676
- Xcodes 1.6.2

### Browsers
- Safari 26.0.1 (21622.1.22.11.15)
- SafariDriver 26.0.1 (21622.1.22.11.15)
- Google Chrome 141.0.7390.77
- Google Chrome for Testing 141.0.7390.76
- ChromeDriver 141.0.7390.76
- Microsoft Edge 141.0.3537.71
- Microsoft Edge WebDriver 141.0.3537.71
- Mozilla Firefox 144.0
- geckodriver 0.36.0
- Selenium server 4.36.0

#### Environment variables
| Name            | Value                                   |
| --------------- | --------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-arm64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver            |
| GECKOWEBDRIVER  | /opt/homebrew/opt/geckodriver/bin       |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 11.0.28+6            | JAVA_HOME_11_arm64   |
| 17.0.16+8            | JAVA_HOME_17_arm64   |
| 21.0.8+9.0 (default) | JAVA_HOME_21_arm64   |
| 25.0.0+36.0          | JAVA_HOME_25_arm64   |

### Cached Tools

#### Ruby
- 3.2.9
- 3.3.9
- 3.4.7

#### Python
- 3.11.9
- 3.12.10
- 3.13.8

#### Node.js
- 20.19.5
- 22.20.0
- 24.10.0

#### Go
- 1.23.12
- 1.24.9
- 1.25.3

### Rust Tools
- Cargo 1.90.0
- Rust 1.90.0
- Rustdoc 1.90.0
- Rustup 1.28.2

#### Packages
- Clippy 0.1.90
- Rustfmt 1.8.0-stable

### PowerShell Tools
- PowerShell 7.4.12

#### PowerShell Modules
- Az: 14.3.0
- Pester: 5.7.1
- PSScriptAnalyzer: 1.24.0

### Xcode
| Version          | Build    | Path                                | Symlinks                                                       |
| ---------------- | -------- | ----------------------------------- | -------------------------------------------------------------- |
| 26.1 (beta)      | 17B5035f | /Applications/Xcode_26.1_beta_2.app | /Applications/Xcode_26.1.0.app<br>/Applications/Xcode_26.1.app |
| 26.0.1 (default) | 17A400   | /Applications/Xcode_26.0.1.app      | /Applications/Xcode_26.0.app<br>/Applications/Xcode.app        |
| 16.4             | 16F6     | /Applications/Xcode_16.4.app        | /Applications/Xcode_16.4.0.app                                 |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 15.5                | macosx15.5           | 16.4          |
| macOS 26.0                | macosx26.0           | 26.0.1        |
| macOS 26.1                | macosx26.1           | 26.1          |
| iOS 18.5                  | iphoneos18.5         | 16.4          |
| iOS 26.0                  | iphoneos26.0         | 26.0.1        |
| iOS 26.1                  | iphoneos26.1         | 26.1          |
| Simulator - iOS 18.5      | iphonesimulator18.5  | 16.4          |
| Simulator - iOS 26.0      | iphonesimulator26.0  | 26.0.1        |
| Simulator - iOS 26.1      | iphonesimulator26.1  | 26.1          |
| tvOS 18.5                 | appletvos18.5        | 16.4          |
| tvOS 26.0                 | appletvos26.0        | 26.0.1        |
| tvOS 26.1                 | appletvos26.1        | 26.1          |
| Simulator - tvOS 18.5     | appletvsimulator18.5 | 16.4          |
| Simulator - tvOS 26.0     | appletvsimulator26.0 | 26.0.1        |
| Simulator - tvOS 26.1     | appletvsimulator26.1 | 26.1          |
| watchOS 11.5              | watchos11.5          | 16.4          |
| watchOS 26.0              | watchos26.0          | 26.0.1        |
| watchOS 26.1              | watchos26.1          | 26.1          |
| Simulator - watchOS 11.5  | watchsimulator11.5   | 16.4          |
| Simulator - watchOS 26.0  | watchsimulator26.0   | 26.0.1        |
| Simulator - watchOS 26.1  | watchsimulator26.1   | 26.1          |
| visionOS 2.5              | xros2.5              | 16.4          |
| visionOS 26.0             | xros26.0             | 26.0.1        |
| visionOS 26.1             | xros26.1             | 26.1          |
| Simulator - visionOS 2.5  | xrsimulator2.5       | 16.4          |
| Simulator - visionOS 26.0 | xrsimulator26.0      | 26.0.1        |
| Simulator - visionOS 26.1 | xrsimulator26.1      | 26.1          |
| DriverKit 24.5            | driverkit24.5        | 16.4          |
| DriverKit 25.0            | driverkit25.0        | 26.0.1        |
| DriverKit 25.1            | driverkit25.1        | 26.1          |

#### Installed Simulators
| OS            | Simulators                                                                                                                                                                                                               |
| ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| iOS 18.5      | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| iOS 18.6      | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone 16e<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| iOS 26.0      | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)     |
| iOS 26.1      | iPhone 16e<br>iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M3)<br>iPad Air 13-inch (M3)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)     |
| tvOS 18.5     | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                      |
| tvOS 26.0     | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                      |
| tvOS 26.1     | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                      |
| watchOS 11.5  | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                           |
| watchOS 26.0  | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                         |
| watchOS 26.1  | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                         |
| visionOS 2.5  | Apple Vision Pro                                                                                                                                                                                                         |
| visionOS 26.0 | Apple Vision Pro                                                                                                                                                                                                         |
| visionOS 26.1 | Apple Vision Pro                                                                                                                                                                                                         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                               |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                                                                                                                                                                                                  |
| Android Emulator           | 36.2.12                                                                                                                                                                                                                                                                                                                                               |
| Android SDK Build-tools    | 36.0.0 36.1.0<br>35.0.0 35.0.1                                                                                                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1) |
| Android SDK Platform-Tools | 36.0.0                                                                                                                                                                                                                                                                                                                                                |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                |
| CMake                      | 3.31.5                                                                                                                                                                                                                                                                                                                                                |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                    |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                    |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358                                                                                                                                                                                                                                                                                                              |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/27.3.13750724 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/28.2.13676358 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/27.3.13750724 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

