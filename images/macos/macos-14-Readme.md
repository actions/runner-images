| Announcements |
|-|
| [[macOS] Go version 1.21.* will be removed from all macOS images on May 12, 2025.](https://github.com/actions/runner-images/issues/12032) |
| [[macOS 14] Xcode Command Line Tool version will be downgraded to 15.3.0 on macOS14 images](https://github.com/actions/runner-images/issues/11969) |
***
# macOS 14
- OS Version: macOS 14.7.5 (23H527)
- Kernel Version: Darwin 23.6.0
- Image Version: 20250421.1108

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.408, 9.0.102, 9.0.203
- Bash 3.2.57(1)-release
- Clang/LLVM 15.0.0
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 12 (Homebrew GCC 12.4.0) - available by `gcc-12` alias
- GCC 13 (Homebrew GCC 13.3.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.2.0_1) - available by `gcc-14` alias
- GNU Fortran 12 (Homebrew GCC 12.4.0) - available by `gfortran-12` alias
- GNU Fortran 13 (Homebrew GCC 13.3.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.2.0_1) - available by `gfortran-14` alias
- Kotlin 2.1.10-release-473
- Mono 6.12.0.188
- Node.js 20.19.0
- Perl 5.40.2
- PHP 8.4.6
- Python3 3.13.3
- Ruby 3.3.8

### Package Management
- Bundler 2.6.8
- Carthage 0.40.0
- CocoaPods 1.16.2
- Composer 2.8.8
- Homebrew 4.4.31
- NPM 10.8.2
- NuGet 6.3.1.1
- Pip3 25.0.1 (python 3.13)
- Pipx 1.7.1
- RubyGems 3.6.8
- Vcpkg 2025 (build from commit e0b65b8cca)
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
- Curl 8.13.0
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
- Xcode Command Line Tools 16.2.0.0.1.1733547573
- Xcodes 1.6.0

### Linters
- SwiftLint 0.59.1

### Browsers
- Safari 18.4 (19621.1.15.111.1)
- SafariDriver 18.4 (19621.1.15.111.1)
- Google Chrome 135.0.7049.96
- Google Chrome for Testing 135.0.7049.95
- ChromeDriver 135.0.7049.95
- Microsoft Edge 135.0.3179.85
- Microsoft Edge WebDriver 135.0.3179.85
- Mozilla Firefox 137.0.2
- geckodriver 0.36.0
- Selenium server 4.29.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.452+9            | JAVA_HOME_8_X64      |
| 11.0.27+6            | JAVA_HOME_11_X64     |
| 17.0.15+6            | JAVA_HOME_17_X64     |
| 21.0.7+6.0 (default) | JAVA_HOME_21_X64     |

### Cached Tools

#### Ruby
- 3.1.7
- 3.2.8
- 3.3.8
- 3.4.3

#### Python
- 3.9.22
- 3.10.17
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
| OS           | Simulators                                                                                                                                                                                                                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 17.0     | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                   |
| iOS 17.2     | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                   |
| iOS 17.4     | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                     |
| iOS 17.5     | iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                            |
| iOS 18.1     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                                   |
| iOS 18.2     | iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                                                   |
| tvOS 17.0    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 17.2    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 17.4    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 17.5    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 18.1    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| tvOS 18.2    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                    |
| watchOS 10.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.2 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.4 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.5 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                           |
| watchOS 11.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                         |
| watchOS 11.2 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Ultra 2 (49mm)                                                                                                                                                                                         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                           |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 11.0                                                                                                                                                                                                                                                                                                              |
| Android Emulator           | 35.4.9                                                                                                                                                                                                                                                                                                            |
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

#### Environment variables
| Name              | Value                                                                                     |
| ----------------- | ----------------------------------------------------------------------------------------- |
| PARALLELS_DMG_URL | https://download.parallels.com/desktop/v20/20.3.0-55895/ParallelsDesktop-20.3.0-55895.dmg |

##### Notes
```
If you want to use Parallels Desktop you should download a package from URL stored in
PARALLELS_DMG_URL environment variable. A system extension is allowed for this version.
```

