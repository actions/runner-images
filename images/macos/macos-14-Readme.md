| Announcements |
|-|
| [[macOS] OpenSSL 1.1 will be removed  and  OpenSSL 3 will be the default for all macOS images from November 4](https://github.com/actions/runner-images/issues/10817) |
| [[macOS] Python 3.9 and 3.10 will be removed from macOS13 arm64 and  macOS14 arm64 on November 18.](https://github.com/actions/runner-images/issues/10812) |
| [[macOS] The macOS 12 Actions runner image will begin deprecation on 10/7/24 and will be fully unsupported by 12/3/24 for GitHub and ADO](https://github.com/actions/runner-images/issues/10721) |
| [[macOS] Support policy changes; Xcode 14 and 16 will be removed from macOS 14 on November 4](https://github.com/actions/runner-images/issues/10703) |
| [macOS 15 (Sequoia) is now available as a public beta in GitHub Actions](https://github.com/actions/runner-images/issues/10686) |
***
# macOS 14
- OS Version: macOS 14.7 (23H124)
- Kernel Version: Darwin 23.6.0
- Image Version: 20241022.254

## Installed Software

### Language and Runtime
- .NET Core SDK: 7.0.102, 7.0.202, 7.0.306, 7.0.410, 8.0.101, 8.0.204, 8.0.303, 8.0.403
- Bash 3.2.57(1)-release
- Clang/LLVM 14.0.3
- Clang/LLVM (Homebrew) 15.0.7 - available on `$(brew --prefix llvm@15)/bin/clang`
- GCC 12 (Homebrew GCC 12.4.0) - available by `gcc-12` alias
- GCC 13 (Homebrew GCC 13.3.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.2.0) - available by `gcc-14` alias
- GNU Fortran 12 (Homebrew GCC 12.4.0) - available by `gfortran-12` alias
- GNU Fortran 13 (Homebrew GCC 13.3.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.2.0) - available by `gfortran-14` alias
- Kotlin 2.0.21-release-482
- Mono 6.12.0.188
- Node.js 20.18.0
- Perl 5.40.0
- PHP 8.3.12
- Python3 3.13.0
- Ruby 3.0.7p220

### Package Management
- Bundler 2.5.22
- Carthage 0.40.0
- CocoaPods 1.15.2
- Composer 2.8.1
- Homebrew 4.4.2
- NPM 10.8.2
- NuGet 6.3.1.1
- Pip3 24.2 (python 3.13)
- Pipx 1.7.1
- RubyGems 3.5.22
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.15
- Apache Maven 3.9.9
- Gradle 8.10.2

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.26.0
- bazel 7.3.2
- bazelisk 1.22.1
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.10.1
- Git 2.47.0
- Git LFS 3.5.1
- GitHub CLI 2.59.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.24.5
- gpg (GnuPG) 2.4.5
- jq 1.7.1
- OpenSSL 1.1.1w  11 Sep 2023
- Packer 1.11.2
- pkg-config 0.29.2
- yq 4.44.3
- zstd 1.5.6

### Tools
- AWS CLI 2.18.11
- AWS SAM CLI 1.126.0
- AWS Session Manager CLI 1.2.677.0
- Azure CLI 2.65.0
- Azure CLI (azure-devops) 1.0.1
- Bicep CLI 0.30.23
- Cmake 3.30.5
- CodeQL Action Bundle 2.19.2
- Fastlane 2.225.0
- SwiftFormat 0.54.6
- Xcbeautify 2.14.1
- Xcode Command Line Tools 16.0.0.0.1.1724870825
- Xcodes 1.5.0

### Linters
- SwiftLint 0.57.0

### Browsers
- Safari 18.0.1 (19619.1.26.111.11)
- SafariDriver 18.0.1 (19619.1.26.111.11)
- Google Chrome 130.0.6723.59
- Google Chrome for Testing 130.0.6723.58
- ChromeDriver 130.0.6723.58
- Microsoft Edge 130.0.2849.46
- Microsoft Edge WebDriver 130.0.2849.50
- Mozilla Firefox 131.0.3
- geckodriver 0.35.0
- Selenium server 4.25.0

#### Environment variables
| Name            | Value                                 |
| --------------- | ------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-x64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver          |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin        |

### Java
| Version               | Environment Variable |
| --------------------- | -------------------- |
| 8.0.432+6             | JAVA_HOME_8_X64      |
| 11.0.25+9             | JAVA_HOME_11_X64     |
| 17.0.13+11            | JAVA_HOME_17_X64     |
| 21.0.5+11.0 (default) | JAVA_HOME_21_X64     |

### Cached Tools

#### Ruby
- 3.0.7
- 3.1.6
- 3.2.5
- 3.3.5

#### Python
- 3.9.20
- 3.10.15
- 3.11.9
- 3.12.7
- 3.13.0

#### Node.js
- 18.20.4
- 20.18.0
- 22.10.0

#### Go
- 1.21.13
- 1.22.8
- 1.23.2

### Rust Tools
- Cargo 1.82.0
- Rust 1.82.0
- Rustdoc 1.82.0
- Rustup 1.27.1

#### Packages
- Clippy 0.1.82
- Rustfmt 1.7.1-stable

### PowerShell Tools
- PowerShell 7.4.5

#### PowerShell Modules
- Az: 12.4.0
- Pester: 5.6.1
- PSScriptAnalyzer: 1.23.0

### Xcode
| Version        | Build   | Path                                           | Symlinks                                                       |
| -------------- | ------- | ---------------------------------------------- | -------------------------------------------------------------- |
| 16.1           | 16B40   | /Applications/Xcode_16.1_Release_Candidate.app | /Applications/Xcode_16.1.0.app<br>/Applications/Xcode_16.1.app |
| 16.0           | 16A242d | /Applications/Xcode_16.app                     | /Applications/Xcode_16.0.0.app<br>/Applications/Xcode_16.0.app |
| 15.4 (default) | 15F31d  | /Applications/Xcode_15.4.app                   | /Applications/Xcode_15.4.0.app<br>/Applications/Xcode.app      |
| 15.3           | 15E204a | /Applications/Xcode_15.3.app                   | /Applications/Xcode_15.3.0.app                                 |
| 15.2           | 15C500b | /Applications/Xcode_15.2.app                   | /Applications/Xcode_15.2.0.app                                 |
| 15.1           | 15C65   | /Applications/Xcode_15.1.app                   | /Applications/Xcode_15.1.0.app                                 |
| 15.0.1         | 15A507  | /Applications/Xcode_15.0.1.app                 | /Applications/Xcode_15.0.app                                   |
| 14.3.1         | 14E300c | /Applications/Xcode_14.3.1.app                 | /Applications/Xcode_14.3.app                                   |

#### Installed SDKs
| SDK                                                     | SDK Name                                      | Xcode Version |
| ------------------------------------------------------- | --------------------------------------------- | ------------- |
| macOS 13.3                                              | macosx13.3                                    | 14.3.1        |
| macOS 14.0                                              | macosx14.0                                    | 15.0.1        |
| macOS 14.2                                              | macosx14.2                                    | 15.1, 15.2    |
| macOS 14.4                                              | macosx14.4                                    | 15.3          |
| macOS 14.5                                              | macosx14.5                                    | 15.4          |
| macOS 15.0                                              | macosx15.0                                    | 16.0          |
| macOS 15.1                                              | macosx15.1                                    | 16.1          |
| iOS 16.4                                                | iphoneos16.4                                  | 14.3.1        |
| iOS 17.0                                                | iphoneos17.0                                  | 15.0.1        |
| iOS 17.2                                                | iphoneos17.2                                  | 15.1, 15.2    |
| iOS 17.4                                                | iphoneos17.4                                  | 15.3          |
| iOS 17.5                                                | iphoneos17.5                                  | 15.4          |
| iOS 18.0                                                | iphoneos18.0                                  | 16.0          |
| iOS 18.1                                                | iphoneos18.1                                  | 16.1          |
| Simulator - iOS 16.4                                    | iphonesimulator16.4                           | 14.3.1        |
| Simulator - iOS 17.0                                    | iphonesimulator17.0                           | 15.0.1        |
| Simulator - iOS 17.2                                    | iphonesimulator17.2                           | 15.1, 15.2    |
| Simulator - iOS 17.4                                    | iphonesimulator17.4                           | 15.3          |
| Simulator - iOS 17.5                                    | iphonesimulator17.5                           | 15.4          |
| Simulator - iOS 18.0                                    | iphonesimulator18.0                           | 16.0          |
| Simulator - iOS 18.1                                    | iphonesimulator18.1                           | 16.1          |
| tvOS 16.4                                               | appletvos16.4                                 | 14.3.1        |
| tvOS 17.0                                               | appletvos17.0                                 | 15.0.1        |
| tvOS 17.2                                               | appletvos17.2                                 | 15.1, 15.2    |
| tvOS 17.4                                               | appletvos17.4                                 | 15.3          |
| tvOS 17.5                                               | appletvos17.5                                 | 15.4          |
| tvOS 18.0                                               | appletvos18.0                                 | 16.0          |
| tvOS 18.1                                               | appletvos18.1                                 | 16.1          |
| Simulator - tvOS 16.4                                   | appletvsimulator16.4                          | 14.3.1        |
| Simulator - tvOS 17.0                                   | appletvsimulator17.0                          | 15.0.1        |
| Simulator - tvOS 17.2                                   | appletvsimulator17.2                          | 15.1, 15.2    |
| Simulator - tvOS 17.4                                   | appletvsimulator17.4                          | 15.3          |
| Simulator - tvOS 17.5                                   | appletvsimulator17.5                          | 15.4          |
| Simulator - tvOS 18.0                                   | appletvsimulator18.0                          | 16.0          |
| Simulator - tvOS 18.1                                   | appletvsimulator18.1                          | 16.1          |
| watchOS 9.4                                             | watchos9.4                                    | 14.3.1        |
| watchOS 10.0                                            | watchos10.0                                   | 15.0.1        |
| watchOS 10.2                                            | watchos10.2                                   | 15.1, 15.2    |
| watchOS 10.4                                            | watchos10.4                                   | 15.3          |
| watchOS 10.5                                            | watchos10.5                                   | 15.4          |
| watchOS 11.0                                            | watchos11.0                                   | 16.0          |
| watchOS 11.1                                            | watchos11.1                                   | 16.1          |
| Simulator - watchOS 9.4                                 | watchsimulator9.4                             | 14.3.1        |
| Simulator - watchOS 10.0                                | watchsimulator10.0                            | 15.0.1        |
| Simulator - watchOS 10.2                                | watchsimulator10.2                            | 15.1, 15.2    |
| Simulator - watchOS 10.4                                | watchsimulator10.4                            | 15.3          |
| Simulator - watchOS 10.5                                | watchsimulator10.5                            | 15.4          |
| Simulator - watchOS 11.0                                | watchsimulator11.0                            | 16.0          |
| Simulator - watchOS 11.1                                | watchsimulator11.1                            | 16.1          |
| Simulator - visionOS 1.0                                | xrsimulator1.0                                | 15.2          |
| visionOS 1.0                                            | xros1.0                                       | 15.2          |
| Simulator - visionOS 1.1                                | xrsimulator1.1                                | 15.3          |
| visionOS 1.1                                            | xros1.1                                       | 15.3          |
| visionOS 1.2                                            | xros1.2                                       | 15.4          |
| Simulator - visionOS 1.2                                | xrsimulator1.2                                | 15.4          |
| Simulator - visionOS 2.0                                | xrsimulator2.0                                | 16.0          |
| visionOS 2.0                                            | xros2.0                                       | 16.0          |
| visionOS 2.1                                            | xros2.1                                       | 16.1          |
| Simulator - visionOS 2.1                                | xrsimulator2.1                                | 16.1          |
| Asset Runtime SDK for macOS hosts targeting watchOS 9.4 | assetruntime.host.macosx.target.watchos9.4    | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting tvOS 16.4   | assetruntime.host.macosx.target.appletvos16.4 | 14.3.1        |
| Asset Runtime SDK for macOS hosts targeting iOS 16.4    | assetruntime.host.macosx.target.iphoneos16.4  | 14.3.1        |
| DriverKit 22.4                                          | driverkit22.4                                 | 14.3.1        |
| DriverKit 23.0                                          | driverkit23.0                                 | 15.0.1        |
| DriverKit 23.2                                          | driverkit23.2                                 | 15.1, 15.2    |
| DriverKit 23.4                                          | driverkit23.4                                 | 15.3          |
| DriverKit 23.5                                          | driverkit23.5                                 | 15.4          |
| DriverKit 24.0                                          | driverkit24.0                                 | 16.0          |
| DriverKit 24.1                                          | driverkit24.1                                 | 16.1          |

#### Installed Simulators
| OS           | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 16.4     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                                                                                                      |
| iOS 17.0     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                                 |
| iOS 17.2     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)                                                                                                                                                                                                 |
| iOS 17.4     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                             |
| iOS 17.5     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                                                                                             |
| iOS 18.0     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4)                        |
| iOS 18.1     | iPhone 14<br>iPhone 14 Plus<br>iPhone 14 Pro<br>iPhone 14 Pro Max<br>iPhone 15<br>iPhone 15 Plus<br>iPhone 15 Pro<br>iPhone 15 Pro Max<br>iPhone 16<br>iPhone 16 Plus<br>iPhone 16 Pro<br>iPhone 16 Pro Max<br>iPhone SE (3rd generation)<br>iPad (10th generation)<br>iPad Air (5th generation)<br>iPad Air 11-inch (M2)<br>iPad Air 13-inch (M2)<br>iPad mini (6th generation)<br>iPad mini (A17 Pro)<br>iPad Pro (11-inch) (4th generation)<br>iPad Pro (12.9-inch) (6th generation)<br>iPad Pro 11-inch (M4)<br>iPad Pro 13-inch (M4) |
| tvOS 16.4    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 17.0    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 17.2    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 17.4    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 17.5    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 18.0    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 18.1    | Apple TV<br>Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| watchOS 9.4  | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Ultra (49mm)                                                                                                                                                                      |
| watchOS 10.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm)                                                                          |
| watchOS 10.2 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm)                                                                          |
| watchOS 10.4 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm)                                                                          |
| watchOS 10.5 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm)                                                                          |
| watchOS 11.0 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm)          |
| watchOS 11.1 | Apple Watch SE (40mm) (2nd generation)<br>Apple Watch SE (44mm) (2nd generation)<br>Apple Watch Series 10 (42mm)<br>Apple Watch Series 10 (46mm)<br>Apple Watch Series 5 (40mm)<br>Apple Watch Series 5 (44mm)<br>Apple Watch Series 6 (40mm)<br>Apple Watch Series 6 (44mm)<br>Apple Watch Series 7 (41mm)<br>Apple Watch Series 7 (45mm)<br>Apple Watch Series 8 (41mm)<br>Apple Watch Series 8 (45mm)<br>Apple Watch Series 9 (41mm)<br>Apple Watch Series 9 (45mm)<br>Apple Watch Ultra (49mm)<br>Apple Watch Ultra 2 (49mm)          |

### Android
| Package Name               | Version                                                                                                                                                                                                                             |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 11.0                                                                                                                                                                                                                                |
| Android Emulator           | 35.2.10                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 35.0.0<br>34.0.0<br>33.0.2 33.0.3                                                                                                                                                                                                   |
| Android SDK Platforms      | android-35 (rev 1)<br>android-34-ext8 (rev 1)<br>android-34-ext12 (rev 1)<br>android-34-ext11 (rev 1)<br>android-34-ext10 (rev 1)<br>android-34 (rev 3)<br>android-33-ext5 (rev 1)<br>android-33-ext4 (rev 1)<br>android-33 (rev 3) |
| Android SDK Platform-Tools | 35.0.2                                                                                                                                                                                                                              |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                              |
| CMake                      | 3.22.1                                                                                                                                                                                                                              |
| Google Play services       | 49                                                                                                                                                                                                                                  |
| Google Repository          | 58                                                                                                                                                                                                                                  |
| NDK                        | 26.3.11579264 (default)<br>27.2.12479018                                                                                                                                                                                            |

#### Environment variables
| Name                    | Value                                               |
| ----------------------- | --------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                   |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/27.2.12479018 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/26.3.11579264 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                   |

### Miscellaneous
- Tcl/Tk 8.6.15

#### Environment variables
| Name              | Value                                                                                     |
| ----------------- | ----------------------------------------------------------------------------------------- |
| PARALLELS_DMG_URL | https://download.parallels.com/desktop/v20/20.1.0-55732/ParallelsDesktop-20.1.0-55732.dmg |

##### Notes
```
If you want to use Parallels Desktop you should download a package from URL stored in
PARALLELS_DMG_URL environment variable. A system extension is allowed for this version.
```

