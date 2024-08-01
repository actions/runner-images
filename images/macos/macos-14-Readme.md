| Announcements |
|-|
| [[macOS] GCC 11 will be removed from all macOS images on August 12](https://github.com/actions/runner-images/issues/10213) |
***
# macOS 14
- OS Version: macOS 14.5 (23F79)
- Kernel Version: Darwin 23.5.0
- Image Version: 20240728.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 7.0.102, 7.0.202, 7.0.306, 7.0.410, 8.0.101, 8.0.204, 8.0.303
- Bash 3.2.57(1)-release
- Clang/LLVM 14.0.3
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 11 (Homebrew GCC 11.4.0) - available by `gcc-11` alias
- GCC 12 (Homebrew GCC 12.4.0) - available by `gcc-12` alias
- GCC 13 (Homebrew GCC 13.3.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.1.0_2) - available by `gcc-14` alias
- GNU Fortran 11 (Homebrew GCC 11.4.0) - available by `gfortran-11` alias
- GNU Fortran 12 (Homebrew GCC 12.4.0) - available by `gfortran-12` alias
- GNU Fortran 13 (Homebrew GCC 13.3.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.1.0_2) - available by `gfortran-14` alias
- Kotlin 2.0.0-release-341
- Mono 6.12.0.188
- Node.js 20.15.1
- Perl 5.38.2
- PHP 8.3.9
- Python3 3.12.4
- Ruby 3.0.7p220

### Package Management
- Bundler 2.5.16
- Carthage 0.39.1
- CocoaPods 1.15.2
- Composer 2.7.7
- Homebrew 4.3.10
- NPM 10.7.0
- NuGet 6.3.1.1
- Pip3 24.2 (python 3.12)
- Pipx 1.6.0
- RubyGems 3.5.16
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.14
- Apache Maven 3.9.8
- Gradle 8.9

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.25.1
- bazel 7.2.1
- bazelisk 1.20.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.9.0
- Git 2.45.2
- Git LFS 3.5.1
- GitHub CLI 2.53.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.24.5
- gpg (GnuPG) 2.4.5
- jq 1.7.1
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.9.4
- pkg-config 0.29.2
- yq 4.44.2
- zstd 1.5.6

### Tools
- AWS CLI 2.17.18
- AWS SAM CLI 1.120.0
- AWS Session Manager CLI 1.2.650.0
- Azure CLI 2.62.0
- Azure CLI (azure-devops) 1.0.1
- Bicep CLI 0.29.47
- Cmake 3.30.1
- CodeQL Action Bundle 2.18.1
- Fastlane 2.222.0
- SwiftFormat 0.54.2
- Xcbeautify 2.5.0
- Xcode Command Line Tools 15.3.0.0.1.1708646388
- Xcodes 1.5.0

### Linters
- SwiftLint 0.55.1

### Browsers
- Safari 17.5 (19618.2.12.11.6)
- SafariDriver 17.5 (19618.2.12.11.6)
- Google Chrome 127.0.6533.73
- Google Chrome for Testing 127.0.6533.72
- ChromeDriver 127.0.6533.72
- Microsoft Edge 127.0.2651.74
- Microsoft Edge WebDriver 127.0.2651.78
- Mozilla Firefox 128.0.3
- geckodriver 0.34.0
- Selenium server 4.23.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version              | Environment Variable |
| -------------------- | -------------------- |
| 8.0.422+5.1          | JAVA_HOME_8_X64      |
| 11.0.24+8            | JAVA_HOME_11_X64     |
| 17.0.12+7            | JAVA_HOME_17_X64     |
| 21.0.4+7.0 (default) | JAVA_HOME_21_X64     |

### Cached Tools

#### Ruby
- 3.0.7
- 3.1.6

#### Python
- 3.9.19
- 3.10.14
- 3.11.9
- 3.12.4

#### Node.js
- 18.20.4
- 20.16.0

#### Go
- 1.20.14
- 1.21.12
- 1.22.5

### Rust Tools
- Cargo 1.80.0
- Rust 1.80.0
- Rustdoc 1.80.0
- Rustup 1.27.1

#### Packages
- Clippy 0.1.80
- Rustfmt 1.7.0-stable

### PowerShell Tools
- PowerShell 7.4.4

#### PowerShell Modules
- Az: 12.1.0
- Pester: 5.6.1
- PSScriptAnalyzer: 1.22.0

### Xcode
| Version        | Build    | Path                              |
| -------------- | -------- | --------------------------------- |
| 16.0 (beta)    | 16A5211f | /Applications/Xcode_16_beta_4.app |
| 15.4 (default) | 15F31d   | /Applications/Xcode_15.4.app      |
| 15.3           | 15E204a  | /Applications/Xcode_15.3.app      |
| 15.2           | 15C500b  | /Applications/Xcode_15.2.app      |
| 15.1           | 15C65    | /Applications/Xcode_15.1.app      |
| 15.0.1         | 15A507   | /Applications/Xcode_15.0.1.app    |
| 14.3.1         | 14E300c  | /Applications/Xcode_14.3.1.app    |

#### Installed SDKs
| SDK                                                     | SDK Name                                      | Xcode Version |
| ------------------------------------------------------- | --------------------------------------------- | ------------- |
| macOS 13.3                                              | macosx13.3                                    | 14.3.1        |
| macOS 14.0                                              | macosx14.0                                    | 15.0.1        |
| macOS 14.2                                              | macosx14.2                                    | 15.1, 15.2    |
| macOS 14.4                                              | macosx14.4                                    | 15.3          |
| macOS 14.5                                              | macosx14.5                                    | 15.4          |
| macOS 15.0                                              | macosx15.0                                    | 16.0          |
| iOS 16.4                                                | iphoneos16.4                                  | 14.3.1        |
| iOS 17.0                                                | iphoneos17.0                                  | 15.0.1        |
| iOS 17.2                                                | iphoneos17.2                                  | 15.1, 15.2    |
| iOS 17.4                                                | iphoneos17.4                                  | 15.3          |
| iOS 17.5                                                | iphoneos17.5                                  | 15.4          |
| iOS 18.0                                                | iphoneos18.0                                  | 16.0          |
| Simulator - iOS 16.4                                    | iphonesimulator16.4                           | 14.3.1        |
| Simulator - iOS 17.0                                    | iphonesimulator17.0                           | 15.0.1        |
| Simulator - iOS 17.2                                    | iphonesimulator17.2                           | 15.1, 15.2    |
| Simulator - iOS 17.4                                    | iphonesimulator17.4                           | 15.3          |
| Simulator - iOS 17.5                                    | iphonesimulator17.5                           | 15.4          |
| Simulator - iOS 18.0                                    | iphonesimulator18.0                           | 16.0          |
| tvOS 16.4                                               | appletvos16.4                                 | 14.3.1        |
| tvOS 17.0                                               | appletvos17.0                                 | 15.0.1        |
| tvOS 17.2                                               | appletvos17.2                                 | 15.1, 15.2    |
| tvOS 17.4                                               | appletvos17.4                                 | 15.3          |
| tvOS 17.5                                               | appletvos17.5                                 | 15.4          |
| tvOS 18.0                                               | appletvos18.0                                 | 16.0          |
| Simulator - tvOS 16.4                                   | appletvsimulator16.4                          | 14.3.1        |
| Simulator - tvOS 17.0                                   | appletvsimulator17.0                          | 15.0.1        |
| Simulator - tvOS 17.2                                   | appletvsimulator17.2                          | 15.1, 15.2    |
| Simulator - tvOS 17.4                                   | appletvsimulator17.4                          | 15.3          |
| Simulator - tvOS 17.5                                   | appletvsimulator17.5                          | 15.4          |
| Simulator - tvOS 18.0                                   | appletvsimulator18.0                          | 16.0          |
| watchOS 9.4                                             | watchos9.4                                    | 14.3.1        |
| watchOS 10.0                                            | watchos10.0                                   | 15.0.1        |
| watchOS 10.2                                            | watchos10.2                                   | 15.1, 15.2    |
| watchOS 10.4                                            | watchos10.4                                   | 15.3          |
| watchOS 10.5                                            | watchos10.5                                   | 15.4          |
| watchOS 11.0                                            | watchos11.0                                   | 16.0          |
| Simulator - watchOS 9.4                                 | watchsimulator9.4                             | 14.3.1        |
| Simulator - watchOS 10.0                                | watchsimulator10.0                            | 15.0.1        |
| Simulator - watchOS 10.2                                | watchsimulator10.2                            | 15.1, 15.2    |
| Simulator - watchOS 10.4                                | watchsimulator10.4                            | 15.3          |
| Simulator - watchOS 10.5                                | watchsimulator10.5                            | 15.4          |
| Simulator - watchOS 11.0                                | watchsimulator11.0                            | 16.0          |
| visionOS 1.0                                            | xros1.0                                       | 15.2          |
| Simulator - visionOS 1.0                                | xrsimulator1.0                                | 15.2          |
| visionOS 1.1                                            | xros1.1                                       | 15.3          |
| Simulator - visionOS 1.1                                | xrsimulator1.1                                | 15.3          |
| Simulator - visionOS 1.2                                | xrsimulator1.2                                | 15.4          |
| visionOS 1.2                                            | xros1.2                                       | 15.4          |
| visionOS 2.0                                            | xros2.0                                       | 16.0          |
| Simulator - visionOS 2.0                                | xrsimulator2.0                                | 16.0          |
| Asset Runtime SDK for macOS hosts targeting watchOS 9.4 | assetruntime.host.macosx.target.watchos9.4    | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting tvOS 16.4   | assetruntime.host.macosx.target.appletvos16.4 | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting iOS 16.4    | assetruntime.host.macosx.target.iphoneos16.4  | 14.3.1        |
| DriverKit 22.4                                          | driverkit22.4                                 | 14.3.1        |
| DriverKit 23.0                                          | driverkit23.0                                 | 15.0.1        |
| DriverKit 23.2                                          | driverkit23.2                                 | 15.1, 15.2    |
| DriverKit 23.4                                          | driverkit23.4                                 | 15.3          |
| DriverKit 23.5                                          | driverkit23.5                                 | 15.4          |
| DriverKit 24.0                                          | driverkit24.0                                 | 16.0          |

#### Installed Simulators
| OS           | Xcode Version                                            | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ------------ | -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 16.4     | 14.3.1                                                   | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                             |
| iOS 17.0     | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                        |
| iOS 17.2     | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                        |
| iOS 17.4     | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                    |
| iOS 17.5     | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                    |
| tvOS 16.4    | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.0    | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.2    | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.4    | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| tvOS 17.5    | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                              |
| watchOS 9.4  | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                             |
| watchOS 10.0 | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.2 | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.4 | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |
| watchOS 10.5 | 14.3.1<br>15.0.1<br>15.1<br>15.2<br>15.3<br>15.4<br>16.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm) |

### Android
| Package Name               | Version                                                                                                                                                                     |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 11.0                                                                                                                                                                        |
| Android Emulator           | 34.2.16                                                                                                                                                                     |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.2 33.0.3                                                                                                                                           |
| Android SDK Platforms      | android-35 (rev 1)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3) |
| Android SDK Platform-Tools | 35.0.1                                                                                                                                                                      |
| Android Support Repository | 47.0.0                                                                                                                                                                      |
| CMake                      | 3.22.1                                                                                                                                                                      |
| Google Play services       | 49                                                                                                                                                                          |
| Google Repository          | 58                                                                                                                                                                          |
| NDK                        | 24.0.8215888<br>25.2.9519653<br>26.3.11579264 (default)                                                                                                                     |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

