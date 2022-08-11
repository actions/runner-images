| Announcements |
|-|
| [[All OSs] Go version 1.16 will be removed on August, 15th](https://github.com/actions/runner-images/issues/6024) |
| ['virtual-environments' repository name will be changed to 'runner-images' on August, 8th](https://github.com/actions/runner-images/issues/5967) |
| [[all OSs] Android NDK 21 will be replaced in favor of 25 on August, 1st](https://github.com/actions/runner-images/issues/5930) |
| [The macOS 10.15 Actions runner image will begin deprecation on 5/31/22 and will be fully unsupported by 8/30/22 in GitHub and by 9/30/22 in ADO](https://github.com/actions/runner-images/issues/5583) |
***
# macOS 12.5 info
- System Version: macOS 12.5 (21G72)
- Kernel Version: Darwin 21.6.0
- Image Version: 20220809.1

## Installed Software
### Language and Runtime
- .NET SDK 3.1.101 3.1.201 3.1.302 3.1.421 5.0.102 5.0.202 5.0.302 5.0.408 6.0.302
- Bash 3.2.57(1)-release
- Clang/LLVM 13.1.6 is default
- Clang/LLVM 14.0.6 is available on `'$(brew --prefix llvm@14)/bin/clang'`
- gcc-11 (Homebrew GCC 11.3.0) 11.3.0 - available by `gcc-11` alias
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
- Python 3.9.13
- R 4.2.1
- Ruby 3.0.4p208

### Package Management
- Bundler version 2.3.19
- Carthage 0.38.0
- CocoaPods 1.11.3
- Composer 2.3.10
- Homebrew 3.5.8
- Miniconda 4.12.0
- NPM 8.11.0
- NuGet 6.2.1.2
- Pip 20.3.4 (python 2.7)
- Pip 22.2.1 (python 3.9)
- Pipx 1.1.0
- RubyGems 3.3.19
- Vcpkg 2022 (build from master \<a0454d6e1>)
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
- bsdtar 3.5.1 - available by 'tar' alias
- Curl 7.84.0
- Git 2.37.1
- Git LFS: 3.2.0
- GitHub CLI: 2.14.3
- GNU Tar 1.34 - available by 'gtar' alias
- GNU Wget 1.21.3
- gpg (GnuPG) 2.3.7
- Hub CLI: 2.14.2
- ImageMagick 7.1.0-45
- jq 1.6
- mongo v5.0.10
- mongod v5.0.10
- OpenSSL 1.1.1q  5 Jul 2022 `(/usr/local/opt/openssl@1.1 -> ../Cellar/openssl@1.1/1.1.1q)`
- Packer 1.8.3
- PostgreSQL 14.4
- psql (PostgreSQL) 14.4
- Sox 14.4.2
- Subversion (SVN) 1.14.2
- Switchaudio-osx 1.1.0
- Vagrant 2.2.19
- VirtualBox 6.1.36r152435
- yq (https://github.com/mikefarah/yq/) version 4.27.2
- zstd 1.5.2

### Tools
- App Center CLI 2.11.0
- AWS CLI 2.7.21
- AWS SAM CLI 1.53.0
- AWS Session Manager CLI 1.2.339.0
- Azure CLI (azure-devops) 0.25.0
- Azure CLI 2.39.0
- Bicep CLI 0.9.1
- Cabal 3.6.2.0
- Cmake 3.24.0
- Fastlane 2.208.0
- GHC 9.4.1
- GHCup 0.1.18.0
- Jazzy 0.14.2
- Stack 2.7.5
- SwiftFormat 0.49.14
- Swig 4.0.2
- Xcode Command Line Tools 13.4.0.0.1.1651278267

### Linters
- SwiftLint 0.48.0
- yamllint 1.27.1

### Browsers
- Safari 15.6 (17613.3.9.1.5)
- SafariDriver 15.6 (17613.3.9.1.5)
- Google Chrome 104.0.5112.79 
- ChromeDriver 104.0.5112.79
- Microsoft Edge 104.0.1293.47 
- Microsoft Edge WebDriver 104.0.1293.47
- Mozilla Firefox 103.0.1
- geckodriver 0.31.0
- Selenium server 4.3.0

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
| 1.16.15 | x64          | GOROOT_1_16_X64      |
| 1.17.13 (Default) | x64          | GOROOT_1_17_X64      |
| 1.18.5  | x64          | GOROOT_1_18_X64      |
| 1.19.0  | x64          | GOROOT_1_19_X64      |

### Rust Tools
- Cargo 1.62.1
- Rust 1.62.1
- Rustdoc 1.62.1
- Rustup 1.25.1

#### Packages
- Bindgen 0.60.1
- Cargo-audit 0.17.0
- Cargo-outdated 0.11.1
- Cbindgen 0.24.3
- Clippy 0.1.62
- Rustfmt 1.4.38-stable

### PowerShell Tools
- PowerShell 7.2.5

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
| Version        | Build     | Path                                 |
| -------------- | --------- | ------------------------------------ |
| 2019           | 8.10.25.2 | /Applications/Visual Studio 2019.app |
| 2022 (default) | 17.0.7.7  | /Applications/Visual Studio.app      |

##### Notes:
```
To use Visual Studio 2019 by default rename the app:
mv "/Applications/Visual Studio.app" "/Applications/Visual Studio 2022.app"
mv "/Applications/Visual Studio 2019.app" "/Applications/Visual Studio.app"
```

#### Xamarin bundles
| symlink           | Xamarin.Mono | Xamarin.iOS | Xamarin.Mac | Xamarin.Android |
| ----------------- | ------------ | ----------- | ----------- | --------------- |
| 6_12_17 (default) | 6.12         | 15.10       | 8.10        | 12.2            |
| 6_12_16           | 6.12         | 15.8        | 8.8         | 12.2            |
| 6_12_15           | 6.12         | 15.8        | 8.8         | 12.1            |
| 6_12_14           | 6.12         | 15.8        | 8.8         | 12.0            |
| 6_12_13           | 6.12         | 15.6        | 8.6         | 12.0            |
| 6_12_12           | 6.12         | 15.4        | 8.4         | 12.0            |
| 6_12_11           | 6.12         | 15.2        | 8.2         | 12.0            |
| 6_12_10           | 6.12         | 15.0        | 7.14        | 11.3            |

#### Unit Test Framework
- NUnit 3.6.1

### Xcode
| Version          | Build    | Path                           |
| ---------------- | -------- | ------------------------------ |
| 14.0 (beta)      | 14A5294e | /Applications/Xcode_14.0.app   |
| 13.4.1 (default) | 13F100   | /Applications/Xcode_13.4.1.app |
| 13.4             | 13F17a   | /Applications/Xcode_13.4.app   |
| 13.3.1           | 13E500a  | /Applications/Xcode_13.3.1.app |
| 13.2.1           | 13C100   | /Applications/Xcode_13.2.1.app |
| 13.1             | 13A1030d | /Applications/Xcode_13.1.app   |

#### Xcode Support Tools
- xcpretty 0.3.0
- xcversion 2.8.1

#### Installed SDKs
| SDK                     | SDK Name             | Xcode Version        |
| ----------------------- | -------------------- | -------------------- |
| macOS 12.0              | macosx12.0           | 13.1                 |
| macOS 12.1              | macosx12.1           | 13.2.1               |
| macOS 12.3              | macosx12.3           | 13.3.1, 13.4, 13.4.1 |
| macOS 13.0              | macosx13.0           | 14.0                 |
| iOS 15.0                | iphoneos15.0         | 13.1                 |
| iOS 15.2                | iphoneos15.2         | 13.2.1               |
| iOS 15.4                | iphoneos15.4         | 13.3.1               |
| iOS 15.5                | iphoneos15.5         | 13.4, 13.4.1         |
| iOS 16.0                | iphoneos16.0         | 14.0                 |
| Simulator - iOS 15.0    | iphonesimulator15.0  | 13.1                 |
| Simulator - iOS 15.2    | iphonesimulator15.2  | 13.2.1               |
| Simulator - iOS 15.4    | iphonesimulator15.4  | 13.3.1               |
| Simulator - iOS 15.5    | iphonesimulator15.5  | 13.4, 13.4.1         |
| Simulator - iOS 16.0    | iphonesimulator16.0  | 14.0                 |
| tvOS 15.0               | appletvos15.0        | 13.1                 |
| tvOS 15.2               | appletvos15.2        | 13.2.1               |
| tvOS 15.4               | appletvos15.4        | 13.3.1, 13.4, 13.4.1 |
| tvOS 16.0               | appletvos16.0        | 14.0                 |
| Simulator - tvOS 15.0   | appletvsimulator15.0 | 13.1                 |
| Simulator - tvOS 15.2   | appletvsimulator15.2 | 13.2.1               |
| Simulator - tvOS 15.4   | appletvsimulator15.4 | 13.3.1, 13.4, 13.4.1 |
| Simulator - tvOS 16.0   | appletvsimulator16.0 | 14.0                 |
| watchOS 8.0             | watchos8.0           | 13.1                 |
| watchOS 8.3             | watchos8.3           | 13.2.1               |
| watchOS 8.5             | watchos8.5           | 13.3.1, 13.4, 13.4.1 |
| watchOS 9.0             | watchos9.0           | 14.0                 |
| Simulator - watchOS 8.0 | watchsimulator8.0    | 13.1                 |
| Simulator - watchOS 8.3 | watchsimulator8.3    | 13.2.1               |
| Simulator - watchOS 8.5 | watchsimulator8.5    | 13.3.1, 13.4, 13.4.1 |
| Simulator - watchOS 9.0 | watchsimulator9.0    | 14.0                 |
| DriverKit 21.0.1        | driverkit21.0.1      | 13.1                 |
| DriverKit 21.2          | driverkit21.2        | 13.2.1               |
| DriverKit 21.4          | driverkit21.4        | 13.3.1, 13.4, 13.4.1 |
| DriverKit 22.0          | driverkit22.0        | 14.0                 |

#### Installed Simulators
| OS          | Xcode Version            | Simulators                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ----------- | ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| iOS 15.0    | 13.1                     | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                            |
| iOS 15.2    | 13.2.1                   | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                                            |
| iOS 15.4    | 13.3.1                   | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| iOS 15.5    | 13.4<br>13.4.1           | iPod touch (7th generation)<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch) |
| iOS 16.0    | 14.0                     | iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPhone 12<br>iPhone 12 mini<br>iPhone 12 Pro<br>iPhone 12 Pro Max<br>iPhone 13<br>iPhone 13 mini<br>iPhone 13 Pro<br>iPhone 13 Pro Max<br>iPhone 8<br>iPhone 8 Plus<br>iPhone SE (2nd generation)<br>iPhone SE (3rd generation)<br>iPad (9th generation)<br>iPad Air (4th generation)<br>iPad Air (5th generation)<br>iPad mini (6th generation)<br>iPad Pro (11-inch) (3rd generation)<br>iPad Pro (12.9-inch) (5th generation)<br>iPad Pro (9.7-inch)                                |
| tvOS 15.0   | 13.1                     | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 15.2   | 13.2.1                   | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| tvOS 15.4   | 13.3.1<br>13.4<br>13.4.1 | Apple TV<br>Apple TV 4K (2nd generation)<br>Apple TV 4K (at 1080p) (2nd generation)                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| watchOS 8.0 | 13.1                     | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 8.3 | 13.2.1                   | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                    |
| watchOS 8.5 | 13.3.1<br>13.4<br>13.4.1 | Apple Watch Series 5 - 40mm<br>Apple Watch Series 5 - 44mm<br>Apple Watch Series 6 - 40mm<br>Apple Watch Series 6 - 44mm<br>Apple Watch Series 7 - 41mm<br>Apple Watch Series 7 - 45mm                                                                                                                                                                                                                                                                                                                                                    |

### Android
| Package Name               | Version                                                                                                                                                |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 7.0                                                                                                                                                    |
| Android Emulator           | 31.2.10                                                                                                                                                |
| Android SDK Build-tools    | 33.0.0<br>32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platforms      | android-33 (rev 2)<br>android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3) |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                 |
| Android Support Repository | 47.0.0                                                                                                                                                 |
| CMake                      | 3.18.1<br>3.22.1                                                                                                                                       |
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



