| Announcements |
|-|
| [[all OSs] Android NDK 21 will be replaced in favor of 25 on August, 1st](https://github.com/actions/runner-images/issues/5930) |
| [The macOS 10.15 Actions runner image will begin deprecation on 5/31/22 and will be fully unsupported by 8/30/22 in GitHub and by 9/30/22 in ADO](https://github.com/actions/runner-images/issues/5583) |
***
# macOS 11.6 info
- System Version: macOS 11.6.8 (20G730)
- Kernel Version: Darwin 20.6.0
- Image Version: 20220815.1

## Installed Software
### Language and Runtime
- .NET SDK 3.1.101 3.1.201 3.1.302 3.1.422 5.0.102 5.0.202 5.0.302 5.0.408 6.0.400
- Bash 3.2.57(1)-release
- Clang/LLVM 13.0.0 is default
- Clang/LLVM 14.0.6 is available on `'$(brew --prefix llvm@14)/bin/clang'`
- gcc-9 (Homebrew GCC 9.5.0) 9.5.0 - available by `gcc-9` alias
- gcc-10 (Homebrew GCC 10.4.0) 10.4.0 - available by `gcc-10` alias
- gcc-11 (Homebrew GCC 11.3.0) 11.3.0 - available by `gcc-11` alias
- GNU Fortran (Homebrew GCC 9.5.0) 9.5.0 - available by `gfortran-9` alias
- GNU Fortran (Homebrew GCC 10.4.0) 10.4.0 - available by `gfortran-10` alias
- GNU Fortran (Homebrew GCC 11.3.0) 11.3.0 - available by `gfortran-11` alias
- Go 1.17.13
- julia 1.7.3
- Kotlin 1.7.10-release-333
- MSBuild 16.10.1.31401 (from /Library/Frameworks/Mono.framework/Versions/6.12.0/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node.js v16.16.0
- NVM 0.39.1
- NVM - Cached node versions: v12.22.12 v14.20.0 v16.16.0
- Perl 5.34.0
- PHP 8.1.9
- Python 2.7.18
- Python 3.10.6
- R 4.2.1
- Ruby 2.7.6p219

### Package Management
- Bundler version 2.3.20
- Carthage 0.38.0
- CocoaPods 1.11.3
- Composer 2.3.10
- Homebrew 3.5.9
- Miniconda 4.12.0
- NPM 8.11.0
- NuGet 6.2.1.2
- Pip 20.3.4 (python 2.7)
- Pip 22.2.2 (python 3.10)
- Pipx 1.1.0
- RubyGems 3.3.20
- Vcpkg 2022 (build from master \<acc3bcf76>)
- Yarn 1.22.19

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/local/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Apache Ant(TM) 1.10.12
- Apache Maven 3.8.6
- Gradle 7.5.1
- Sbt 1.7.1

### Utilities
- 7-Zip 17.04
- aria2 1.36.0
- azcopy 10.16.0
- bazel 5.2.0
- bazelisk 1.12.0
- bsdtar 3.3.2 - available by 'tar' alias
- Curl 7.84.0
- Git 2.37.2
- Git LFS: 3.2.0
- GitHub CLI: 2.14.4
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.3
- gpg (GnuPG) 2.3.7
- helm v3.9.3+g414ff28
- Hub CLI: 2.14.2
- ImageMagick 7.1.0-45
- jq 1.6
- mongo v5.0.10
- mongod v5.0.10
- Newman 5.3.2
- OpenSSL 1.1.1q  5 Jul 2022 `(/usr/local/opt/openssl@1.1 -> ../Cellar/openssl@1.1/1.1.1q)`
- Packer 1.8.3
- PostgreSQL 14.4
- psql (PostgreSQL) 14.4
- Sox 14.4.2
- Subversion (SVN) 1.14.2
- Switchaudio-osx 1.1.0
- yq (https://github.com/mikefarah/yq/) version 4.27.2
- zstd 1.5.2

### Tools
- Aliyun CLI 3.0.124
- App Center CLI 2.11.0
- AWS CLI 2.7.23
- AWS SAM CLI 1.54.0
- AWS Session Manager CLI 1.2.339.0
- Azure CLI (azure-devops) 0.25.0
- Azure CLI 2.39.0
- Bicep CLI 0.9.1
- Cabal 3.6.2.0
- Cmake 3.24.0
- CodeQL Action Bundle 2.10.2
- Fastlane 2.209.0
- GHC 9.4.1
- GHCup 0.1.18.0
- Jazzy 0.14.2
- Stack 2.7.5
- SwiftFormat 0.49.16
- Swig 4.0.2
- Xcode Command Line Tools 13.2.0.0.1.1638488800

### Linters
- SwiftLint 0.48.0
- yamllint 1.27.1

### Browsers
- Safari 15.6 (16613.3.9.1.7)
- SafariDriver 15.6 (16613.3.9.1.7)
- Google Chrome 104.0.5112.79 
- ChromeDriver 104.0.5112.79
- Microsoft Edge 104.0.1293.54 
- Microsoft Edge WebDriver 104.0.1293.54
- Mozilla Firefox 103.0.2
- geckodriver 0.31.0
- Selenium server 4.4.0

#### Environment variables
| Name            | Value                                          |
| --------------- | ---------------------------------------------- |
| CHROMEWEBDRIVER | /usr/local/Caskroom/chromedriver/104.0.5112.79 |
| EDGEWEBDRIVER   | /usr/local/share/edge_driver                   |
| GECKOWEBDRIVER  | /usr/local/opt/geckodriver/bin                 |

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.345+1 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.16+8           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 17.0.4+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 22.2.0 | GRAALVM_11_ROOT       |

### Cached Tools
#### Ruby
- 2.4.10
- 2.5.9
- 2.6.10
- 2.7.6
- 3.0.4
- 3.1.2

#### Python
- 3.7.13
- 3.8.13
- 3.9.13
- 3.10.6

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.7.13 [PyPy 7.3.9]
- 3.8.13 [PyPy 7.3.9]
- 3.9.12 [PyPy 7.3.9]

#### Node.js
- 12.22.12
- 14.20.0
- 16.16.0

#### Go
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.17.13 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.5  | x64          | GOROOT_1_18_X64      |
| 1.19.0  | x64          | GOROOT_1_19_X64      |

### Rust Tools
- Cargo 1.63.0
- Rust 1.63.0
- Rustdoc 1.63.0
- Rustup 1.25.1

#### Packages
- Bindgen 0.60.1
- Cargo-audit 0.17.0
- Cargo-outdated 0.11.1
- Cbindgen 0.24.3
- Clippy 0.1.63
- Rustfmt 1.5.1-stable

### PowerShell Tools
- PowerShell 7.2.6

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| Az               | 8.2.0   |
| MarkdownPS       | 1.9     |
| Pester           | 5.3.3   |
| PSScriptAnalyzer | 1.20.0  |

### Web Servers
| Name  | Version | ConfigFile                      | ServiceStatus | ListenPort |
| ----- | ------- | ------------------------------- | ------------- | ---------- |
| httpd | 2.4.54  | /usr/local/etc/httpd/httpd.conf | none          | 80         |
| nginx | 1.23.1  | /usr/local/etc/nginx/nginx.conf | none          | 80         |

### Xamarin
#### Visual Studio for Mac
| Version        | Build       | Path                                 |
| -------------- | ----------- | ------------------------------------ |
| 2019           | 8.10.25.2   | /Applications/Visual Studio 2019.app |
| 2022 (default) | 17.3.0.2102 | /Applications/Visual Studio.app      |

##### Notes:
```
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
```

#### Xamarin bundles
| symlink           | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ----------------- | ------------ | ----------- | ----------- | --------------- |
| 6_12_16           | 6.12         | 15.8        | 8.8         | 12.2            |
| 6_12_15           | 6.12         | 15.8        | 8.8         | 12.1            |
| 6_12_14           | 6.12         | 15.8        | 8.8         | 12.0            |
| 6_12_13           | 6.12         | 15.6        | 8.6         | 12.0            |
| 6_12_12 (default) | 6.12         | 15.4        | 8.4         | 12.0            |
| 6_12_11           | 6.12         | 15.2        | 8.2         | 12.0            |
| 6_12_10           | 6.12         | 15.0        | 7.14        | 11.3            |
| 6_12_9            | 6.12         | 14.20       | 7.14        | 11.3            |
| 6_12_8            | 6.12         | 14.16       | 7.10        | 11.2            |
| 6_12_7            | 6.12         | 14.14       | 7.8         | 11.2            |
| 6_12_6            | 6.12         | 14.10       | 7.4         | 11.1            |
| 6_12_5            | 6.12         | 14.8        | 7.2         | 11.1            |
| 6_12_4            | 6.12         | 14.6        | 7.0         | 11.1            |
| 6_12_3            | 6.12         | 14.4        | 6.22        | 11.1            |
| 6_12_2            | 6.12         | 14.2        | 6.20        | 11.0            |
| 6_12_1            | 6.12         | 14.0        | 6.20        | 11.0            |
| 6_12_0            | 6.12         | 13.20       | 6.20        | 11.0            |

#### Unit Test Framework
- NUnit 3.6.1

### Xcode
| Version          | Build    | Path                           |
| ---------------- | -------- | ------------------------------ |
| 13.2.1 (default) | 13C100   | /Applications/Xcode_13.2.1.app |
| 13.1             | 13A1030d | /Applications/Xcode_13.1.app   |
| 13.0             | 13A233   | /Applications/Xcode_13.0.app   |
| 12.5.1           | 12E507   | /Applications/Xcode_12.5.1.app |
| 12.4             | 12D4e    | /Applications/Xcode_12.4.app   |
| 11.7             | 11E801a  | /Applications/Xcode_11.7.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.1
- Nomad CLI 0.0.2
- Nomad shenzhen CLI 0.14.3

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version |
| ----------------------- | -------------------- | ------------- |
| macOS 10.15             | macosx10.15          | 11.7          |
| macOS 11.1              | macosx11.1           | 12.4          |
| macOS 11.3              | macosx11.3           | 12.5.1, 13.0  |
| macOS 12.0              | macosx12.0           | 13.1          |
| macOS 12.1              | macosx12.1           | 13.2.1        |
| iOS 13.7                | iphoneos13.7         | 11.7          |
| iOS 14.4                | iphoneos14.4         | 12.4          |
| iOS 14.5                | iphoneos14.5         | 12.5.1        |
| iOS 15.0                | iphoneos15.0         | 13.0, 13.1    |
| iOS 15.2                | iphoneos15.2         | 13.2.1        |
| Simulator - iOS 13.7    | iphonesimulator13.7  | 11.7          |
| Simulator - iOS 14.4    | iphonesimulator14.4  | 12.4          |
| Simulator - iOS 14.5    | iphonesimulator14.5  | 12.5.1        |
| Simulator - iOS 15.0    | iphonesimulator15.0  | 13.0, 13.1    |
| Simulator - iOS 15.2    | iphonesimulator15.2  | 13.2.1        |
| tvOS 13.4               | appletvos13.4        | 11.7          |
| tvOS 14.3               | appletvos14.3        | 12.4          |
| tvOS 14.5               | appletvos14.5        | 12.5.1        |
| tvOS 15.0               | appletvos15.0        | 13.0, 13.1    |
| tvOS 15.2               | appletvos15.2        | 13.2.1        |
| Simulator - tvOS 13.4   | appletvsimulator13.4 | 11.7          |
| Simulator - tvOS 14.3   | appletvsimulator14.3 | 12.4          |
| Simulator - tvOS 14.5   | appletvsimulator14.5 | 12.5.1        |
| Simulator - tvOS 15.0   | appletvsimulator15.0 | 13.0, 13.1    |
| Simulator - tvOS 15.2   | appletvsimulator15.2 | 13.2.1        |
| watchOS 6.2             | watchos6.2           | 11.7          |
| watchOS 7.2             | watchos7.2           | 12.4          |
| watchOS 7.4             | watchos7.4           | 12.5.1        |
| watchOS 8.0             | watchos8.0           | 13.0, 13.1    |
| watchOS 8.3             | watchos8.3           | 13.2.1        |
| Simulator - watchOS 6.2 | watchsimulator6.2    | 11.7          |
| Simulator - watchOS 7.2 | watchsimulator7.2    | 12.4          |
| Simulator - watchOS 7.4 | watchsimulator7.4    | 12.5.1        |
| Simulator - watchOS 8.0 | watchsimulator8.0    | 13.0, 13.1    |
| Simulator - watchOS 8.3 | watchsimulator8.3    | 13.2.1        |
| DriverKit 19.0          | driverkit.macosx19.0 | 11.7          |
| DriverKit 20.2          | driverkit.macosx20.2 | 12.4          |
| DriverKit 20.4          | driverkit.macosx20.4 | 12.5.1, 13.0  |
| DriverKit 21.0.1        | driverkit21.0.1      | 13.1          |
| DriverKit 21.2          | driverkit21.2        | 13.2.1        |

#### Installed Simulators
| OS          | Xcode Version | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ----------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 13.7    | 11.7          | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad Air (3rd generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                                                                                                                                                                                       |
| iOS 14.4    | 12.4          | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (9.7-inch)                                                                                                                                                                                                             |
| iOS 14.5    | 12.5.1        | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                                                                                             |
| iOS 15.0    | 13.0<br>13.1  | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad (9th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| iOS 15.2    | 13.2.1        | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (7th generation)<br>iPad (8th generation)<br>iPad (9th generation)<br>iPad Air (3rd generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (2nd generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (4th generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| tvOS 13.4   | 11.7          | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| tvOS 14.3   | 12.4          | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| tvOS 14.5   | 12.5.1        | Apple TV<br>Apple TV 4K<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| tvOS 15.0   | 13.0<br>13.1  | Apple TV<br>Apple TV 4K<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| tvOS 15.2   | 13.2.1        | Apple TV<br>Apple TV 4K<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| watchOS 6.2 | 11.7          | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| watchOS 7.2 | 12.4          | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| watchOS 7.4 | 12.5.1        | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| watchOS 8.0 | 13.0<br>13.1  | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                                                          |
| watchOS 8.3 | 13.2.1        | Apple Watch Series 4 - 40mm<br>Apple Watch Series 4 - 44mm<br>Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                                                          |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.3.10                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.10.2<br>3.18.1<br>3.22.1                                                                                                                             |
| Google Play services       | 49                                                                                                                                                     |
| Google Repository          | 58                                                                                                                                                     |
| NDK                        | 23.2.8568313<br>24.0.8215888<br>25.0.8775105 (default)                                                                                                 |
| SDK Patch Applier v4       | 1                                                                                                                                                      |

#### Environment variables
| Name                    | Value                                              |
| ----------------------- | -------------------------------------------------- |
| ANDROID_HOME            | /Users/runner/Library/Android/sdk                  |
| ANDROID_NDK             | /Users/runner/Library/Android/sdk/ndk/25.0.8775105 |
| ANDROID_NDK_HOME        | /Users/runner/Library/Android/sdk/ndk/25.0.8775105 |
| ANDROID_NDK_LATEST_HOME | /Users/runner/Library/Android/sdk/ndk/25.0.8775105 |
| ANDROID_NDK_ROOT        | /Users/runner/Library/Android/sdk/ndk/25.0.8775105 |
| ANDROID_SDK_ROOT        | /Users/runner/Library/Android/sdk                  |

### Miscellaneous
- libXext 1.3.4
- libXft 2.3.4
- Tcl/Tk 8.6.12
- Zlib 1.2.12



