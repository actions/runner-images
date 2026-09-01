| Announcements |
|-|
| [[macOS] Xcode 27 is now available as a public preview](https://github.com/actions/runner-images/issues/14404) |
| [[macOS] Default Xcode on macOS 26 Tahoe will be set to Xcode 26.6 on 2026.07.21](https://github.com/actions/runner-images/issues/14344) |
| [[macOS] The macOS 14 Sonoma based runner images will begin deprecation on July 6th and will be fully unsupported by November 2nd for GitHub Actions and Azure DevOps](https://github.com/actions/runner-images/issues/13518) |
***
# macOS 26
- OS Version: macOS 26.5.2 (25F84)
- Kernel Version: Darwin 25.5.0
- Image Version: 20260831.0151.1

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
- Node.js 24.20.0
- Perl 5.44.0
- Python3 3.14.7
- Ruby 3.4.10

### Package Management
- Bundler 4.0.19
- Carthage 0.40.0
- CocoaPods 1.17.0
- Homebrew 6.0.20
- NPM 11.19.0
- Pip3 26.2.1 (python 3.14)
- Pipx 1.16.7
- RubyGems 4.0.19
- Vcpkg 2026 (build from commit b70085cf11)
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
- Curl 8.7.1
- Git 2.55.0
- Git LFS 3.8.0
- GitHub CLI 2.98.0
- GNU Tar 1.35 - available by 'gtar' alias
- GNU Wget 1.25.0
- gpg (GnuPG) 2.5.21
- jq 1.8.2
- OpenSSL 3.6.3 9 Jun 2026 (Library: OpenSSL 3.6.3 9 Jun 2026)
- Packer 1.16.0
- pkgconf 3.0.6
- Unxip 3.3
- yq 4.53.6
- zstd 1.5.7
- Ninja 1.13.2

### Tools
- AWS CLI 2.36.34
- AWS SAM CLI 1.165.0
- AWS Session Manager CLI 1.2.835.0
- Azure CLI 2.89.1
- Azure CLI (azure-devops) 1.0.7
- Bicep CLI 0.46.1
- Cmake 4.4.3
- CodeQL Action Bundle 2.26.4
- Fastlane 2.238.0
- SwiftFormat 0.63.0
- Xcbeautify 3.2.1
- Xcode Command Line Tools 26.6.0.0.1781586589
- Xcodes 2.0.3

### Browsers
- Safari 26.5.2 (21624.2.5.11.8)
- SafariDriver 26.5.2 (21624.2.5.11.8)
- Google Chrome 152.0.7977.65
- Google Chrome for Testing 152.0.7977.64
- ChromeDriver 152.0.7977.64
- Microsoft Edge 152.0.4191.53
- Microsoft Edge WebDriver 152.0.4191.53
- Mozilla Firefox 154.0.1
- geckodriver 0.37.1
- Selenium server 4.48.0

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
- 3.4.10
- 4.0.6

#### Python
- 3.11.9
- 3.12.10
- 3.13.15
- 3.14.7

#### Node.js
- 22.23.2
- 24.20.0

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
| Version               | Build    | Path                              | Symlinks                                                                                  |
| --------------------- | -------- | --------------------------------- | ----------------------------------------------------------------------------------------- |
| 27.0 (beta) (default) | 27A5252f | /Applications/Xcode_27_beta_6.app | /Applications/Xcode_27.0.0.app<br>/Applications/Xcode_27.0.app<br>/Applications/Xcode.app |

#### Installed SDKs
| SDK                       | SDK Name             | Xcode Version |
| ------------------------- | -------------------- | ------------- |
| macOS 27.0                | macosx27.0           | 27.0          |
| iOS 27.0                  | iphoneos27.0         | 27.0          |
| Simulator - iOS 27.0      | iphonesimulator27.0  | 27.0          |
| tvOS 27.0                 | appletvos27.0        | 27.0          |
| Simulator - tvOS 27.0     | appletvsimulator27.0 | 27.0          |
| watchOS 27.0              | watchos27.0          | 27.0          |
| Simulator - watchOS 27.0  | watchsimulator27.0   | 27.0          |
| visionOS 27.0             | xros27.0             | 27.0          |
| Simulator - visionOS 27.0 | xrsimulator27.0      | 27.0          |
| DriverKit 27.0            | driverkit27.0        | 27.0          |

#### Installed Simulators
| Name          | OS   | Simulators                                                                                                                                                                                                           |
| ------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 27.0      | 27.0 | iPhone 17<br>iPhone 17 Pro<br>iPhone 17 Pro Max<br>iPhone 17e<br>iPhone Air<br>iPad (A16)<br>iPad Air 11-inch (M4)<br>iPad Air 13-inch (M4)<br>iPad mini (A17 Pro)<br>iPad Pro 11-inch (M5)<br>iPad Pro 13-inch (M5) |
| tvOS 27.0     | 27.0 | Apple TV 4K (3rd generation)<br>Apple TV 4K (3rd generation) (at 1080p)                                                                                                                                              |
| watchOS 27.0  | 27.0 | Apple Watch SE 3 (40mm)<br>Apple Watch SE 3 (44mm)<br>Apple Watch Series 11 (42mm)<br>Apple Watch Series 11 (46mm)<br>Apple Watch Ultra 3 (49mm)                                                                     |
| visionOS 27.0 | 27.0 | Apple Vision Pro                                                                                                                                                                                                     |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 16.0                                                                                                                                                                                                                                                                                                                                               |
| Android Emulator           | 37.1.11                                                                                                                                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 37.0.0<br>36.0.0 36.1.0<br>35.0.0 35.0.1                                                                                                                                                                                                                                                                                                           |
| Android SDK Platforms      | android-37.2-beta3 (rev 3)<br>android-37.2-beta2 (rev 2)<br>android-37.2-beta1 (rev 1)<br>android-37.2 (rev 1)<br>android-37.1 (rev 1)<br>android-37.0 (rev 2)<br>android-36.1 (rev 1)<br>android-36-ext19 (rev 1)<br>android-36-ext18 (rev 1)<br>android-36 (rev 2)<br>android-35-ext15 (rev 1)<br>android-35-ext14 (rev 1)<br>android-35 (rev 2) |
| Android SDK Platform-Tools | 37.0.1                                                                                                                                                                                                                                                                                                                                             |
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

