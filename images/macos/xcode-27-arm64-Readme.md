| Announcements |
|-|
| [[macOS] The default OpenSSL version will be updated from 3 to 4 on macOS 26 and Xcode 27](https://github.com/actions/runner-images/issues/14856) |
| [[macOS] Xcode 27 is now available as a public preview](https://github.com/actions/runner-images/issues/14404) |
| [[macOS] The macOS 14 Sonoma based runner images will begin deprecation on July 6th and will be fully unsupported by November 2nd for GitHub Actions and Azure DevOps](https://github.com/actions/runner-images/issues/13518) |
***
# macOS 27
- OS Version: macOS 27.0.1 (26A434)
- Kernel Version: Darwin 27.0.0
- Image Version: 20261019.0289.1

## Installed Software

### Language and Runtime
- .NET Core SDK: 8.0.101, 8.0.204, 8.0.303, 8.0.426, 9.0.102, 9.0.203, 9.0.319, 10.0.103, 10.0.203, 10.0.302, 10.0.402
- Bash 3.2.57(1)-release
- Clang/LLVM 21.0.0
- Clang/LLVM (Homebrew) 20.1.8 - available on `$(brew --prefix llvm@20)/bin/clang`
- GCC 13 (Homebrew GCC 13.4.0) - available by `gcc-13` alias
- GCC 14 (Homebrew GCC 14.4.0) - available by `gcc-14` alias
- GCC 15 (Homebrew GCC 15.3.0) - available by `gcc-15` alias
- GNU Fortran 13 (Homebrew GCC 13.4.0) - available by `gfortran-13` alias
- GNU Fortran 14 (Homebrew GCC 14.4.0) - available by `gfortran-14` alias
- GNU Fortran 15 (Homebrew GCC 15.3.0) - available by `gfortran-15` alias
- Kotlin 2.4.21
- Node.js 24.22.0
- Perl 5.44.0
- Python3 3.15.0
- Ruby 3.4.11

### Package Management
- Bundler 4.0.23
- Carthage 0.40.0
- CocoaPods 1.17.0
- Homebrew 7.0.9
- NPM 11.19.1
- Pip3 26.2.1 (python 3.15)
- Pipx 1.18.3
- RubyGems 4.0.23
- Vcpkg 2026 (build from commit 664933b8d3)
- Yarn 1.22.22

### Project Management
- Apache Ant 1.10.18
- Apache Maven 3.10.0
- Gradle 9.8.1

### Utilities
- 7-Zip 17.05
- aria2 1.37.0
- azcopy 10.32.8
- bazel 9.3.0
- bazelisk 1.29.0
- bsdtar 3.5.3 - available by 'tar' alias
- Curl 8.7.1
- Git 2.56.0
- Git LFS 3.8.0
- GitHub CLI 2.102.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.5.24
- jq 1.8.2
- OpenSSL 3.5.9 29 Sep 2026 (Library: OpenSSL 3.5.9 29 Sep 2026)
- OpenSSL (openssl@4) 4.0.3 29 Sep 2026 (Library: OpenSSL 4.0.3 29 Sep 2026) - available on `/opt/homebrew/opt/openssl@4/bin/openssl`
- Packer 1.16.1
- pkgconf 3.0.9
- Unxip 3.3
- yq 4.54.1
- zstd 1.5.7
- Ninja 1.13.2

### Tools
- AWS CLI 2.38.1
- AWS SAM CLI 1.169.0
- AWS Session Manager CLI 1.2.835.0
- Azure CLI 2.91.0
- Azure CLI (azure-devops) 1.0.9
- Bicep CLI 0.48.1
- Cmake 4.4.4
- CodeQL Action Bundle 2.27.2
- Fastlane 2.241.1
- SwiftFormat 0.64.0
- Xcbeautify 3.2.1
- Xcode Command Line Tools 27.0.0.0.1788430756
- Xcodes 2.1.0

### Browsers
- Safari 27.0.1 (22625.1.29.11.28)
- SafariDriver 27.0.1 (22625.1.29.11.28)
- Google Chrome 155.0.8059.85
- Google Chrome for Testing 155.0.8059.84
- ChromeDriver 155.0.8059.84
- Microsoft Edge 155.0.4283.62
- Microsoft Edge WebDriver 155.0.4283.62
- Mozilla Firefox 158.0
- geckodriver 0.37.1
- Selenium server 4.51.0

#### Environment variables
| Name            | Value                                   |
| --------------- | --------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/share/chromedriver-mac-arm64 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver            |
| GECKOWEBDRIVER  | /opt/homebrew/opt/geckodriver/bin       |

### Java
| Version                 | Environment Variable |
| ----------------------- | -------------------- |
| 11.0.32+101             | JAVA_HOME_11_arm64   |
| 17.0.20+101             | JAVA_HOME_17_arm64   |
| 21.0.12+101.0 (default) | JAVA_HOME_21_arm64   |
| 25.0.4+101.0            | JAVA_HOME_25_arm64   |

### Cached Tools

#### Ruby
- 3.2.11
- 3.3.12
- 3.4.11
- 4.0.7

#### Python
- 3.11.9
- 3.12.10
- 3.13.16
- 3.14.8

#### Node.js
- 22.23.3
- 24.22.0

#### Go
- 1.24.13
- 1.25.14
- 1.26.9

### Rust Tools
- Cargo 1.99.1
- Rust 1.99.1
- Rustdoc 1.99.1
- Rustup 1.29.0

#### Packages
- Clippy 0.1.99
- Rustfmt 1.10.0-stable

### PowerShell Tools
- PowerShell 7.6.7

#### PowerShell Modules
- Az: 15.6.1
- Pester: 5.9.0
- PSScriptAnalyzer: 1.25.0

### Xcode
| Version        | Build    | Path                                           | Symlinks                                                                                  |
| -------------- | -------- | ---------------------------------------------- | ----------------------------------------------------------------------------------------- |
| 27.2 (beta)    | 27B5038j | /Applications/Xcode_27.2_beta_3.app            | /Applications/Xcode_27.2.0.app<br>/Applications/Xcode_27.2.app                            |
| 27.1           | 27A9275  | /Applications/Xcode_27.1_Release_Candidate.app | /Applications/Xcode_27.1.0.app<br>/Applications/Xcode_27.1.app                            |
| 27.0 (default) | 27A266a  | /Applications/Xcode_27.app                     | /Applications/Xcode_27.0.0.app<br>/Applications/Xcode_27.0.app<br>/Applications/Xcode.app |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 27.0                | macosx27.0           | 27.0, 27.1    |
| macOS 27.2                | macosx27.2           | 27.2          |
| iOS 27.0                  | iphoneos27.0         | 27.0          |
| iOS 27.1                  | iphoneos27.1         | 27.1          |
| iOS 27.2                  | iphoneos27.2         | 27.2          |
| Simulator - iOS 27.0      | iphonesimulator27.0  | 27.0          |
| Simulator - iOS 27.1      | iphonesimulator27.1  | 27.1          |
| Simulator - iOS 27.2      | iphonesimulator27.2  | 27.2          |
| tvOS 27.0                 | appletvos27.0        | 27.0, 27.1    |
| tvOS 27.2                 | appletvos27.2        | 27.2          |
| Simulator - tvOS 27.0     | appletvsimulator27.0 | 27.0, 27.1    |
| Simulator - tvOS 27.2     | appletvsimulator27.2 | 27.2          |
| watchOS 27.0              | watchos27.0          | 27.0, 27.1    |
| watchOS 27.2              | watchos27.2          | 27.2          |
| Simulator - watchOS 27.0  | watchsimulator27.0   | 27.0, 27.1    |
| Simulator - watchOS 27.2  | watchsimulator27.2   | 27.2          |
| visionOS 27.0             | xros27.0             | 27.0, 27.1    |
| visionOS 27.2             | xros27.2             | 27.2          |
| Simulator - visionOS 27.0 | xrsimulator27.0      | 27.0, 27.1    |
| Simulator - visionOS 27.2 | xrsimulator27.2      | 27.2          |
| DriverKit 27.0            | driverkit27.0        | 27.0, 27.1    |
| DriverKit 27.2            | driverkit27.2        | 27.2          |

#### Installed Simulators
| Name          | OS   | Simulators                                                                                                                                                                                                           |
| ------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 27.0      | 27.0 | iPhone 17<br>iPhone 17e<br>iPhone 18 Pro<br>iPhone 18 Pro Max<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M4)<br>iPad Air 13-inch (M4)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5) |
| tvOS 27.0     | 27.0 | Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                              |
| watchOS 27.0  | 27.0 | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 12 (42mm)<br>Apple Watch Series 12 (46mm)<br>Apple Watch Ultra 4 (49mm)                                                                     |
| visionOS 27.0 | 27.0 | Apple Vision Pro                                                                                                                                                                                                     |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                                                                                                                                                                                               |
| Android Emulator           | 37.2.12                                                                                                                                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1                                                                                                                                                                                                                                                                                                           |
| Android SDK Platforms      | android-37.2-beta3 (rev 3)<br>android-37.2-beta2 (rev 2)<br>android-37.2-beta1 (rev 1)<br>android-37.2 (rev 1)<br>android-37.1 (rev 1)<br>android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2) |
| Android SDK Platform-Tools | 37.0.1                                                                                                                                                                                                                                                                                                                                             |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                                                                                             |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                             |
| CMake                      | 3.31.5<br>4.1.2                                                                                                                                                                                                                                                                                                                                    |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                 |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                 |
| NDK                        | 27.3.13750724 (default)<br>28.2.13676358<br>29.0.14206865                                                                                                                                                                                                                                                                                          |

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

