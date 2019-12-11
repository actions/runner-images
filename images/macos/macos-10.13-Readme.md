# Azure Pipelines hosted macOS image

The following software is installed on machines in the Azure Pipelines **macOS-10.13** VM image ('Hosted macOS High Sierra' pool).

#### Xcode 10.1 set by default

## Operating System

- OS X 10.13.6 (17G9016) **High Sierra**

## Installed Software

### Language and Runtime

- Java 1.7: OpenJDK Runtime Environment (Zulu 7.34.0.5-CA-macosx) (build 1.7.0_242-b7)
- Java 1.8: OpenJDK Runtime Environment (Zulu 8.42.0.23-CA-macosx) (build 1.8.0_232-b18) (default)
- Java 11: OpenJDK Runtime Environment Zulu11.35+15-CA (build 11.0.5+10-LTS)
- Java 12: OpenJDK Runtime Environment Zulu12.3+11-CA (build 12.0.2+3)
- Java 13: OpenJDK Runtime Environment Zulu13.28+11-CA (build 13.0.1+10-MTS)
- Node.js 6.17.0
- NVM 0.33.11
- NVM - Installed node versions:
	v6.17.1
	v8.16.2
	v10.17.0
	v12.13.1
	v13.2.0
- PowerShell 6.2.3
- Python 2.7.17
- Python 3.7.5
- Ruby 2.6.5p114
- .NET Core SDK 1.0.1, 1.0.4, 1.1.4, 1.1.5, 1.1.7, 1.1.8, 1.1.9, 1.1.10, 1.1.11, 1.1.12, 1.1.13, 2.0.0, 2.0.3, 2.1.100, 2.1.101, 2.1.102, 2.1.103, 2.1.104, 2.1.105, 2.1.503, 2.1.504, 2.1.505, 2.1.2, 2.1.200, 2.1.201, 2.1.300, 2.1.301, 2.1.4, 2.1.400, 2.1.401 2.1.402 2.1.502, 2.1.504, 2.2.101, 2.2.102, 2.2.103, 2.2.104, 2.2.105
- Go 1.13.4

### Package Management

- Bundler 2.0.2
- Carthage 0.34.0
- CocoaPods 1.8.4
- Homebrew 2.2.0
- NPM 3.10.10
- Yarn 1.19.2
- NuGet 4.7.0.5148
- pip 19.3.1(python 2.7)
- pip 19.3.1(python 3.7)
- Miniconda 4.7.12

### Project Management

- Apache Maven 3.6.3
- Gradle 6.0.1

### Utilities

- curl 7.67.0 (x86_64-apple-darwin17.7.0) libcurl/7.67.0 SecureTransport zlib/1.2.11
- Git 2.24.0
- Git LFS 2.8.0
- GNU Wget 1.20.3
- Subversion (SVN) 1.12.2
- GNU parallel 20191122

### Tools

- fastlane 2.137.0
- App Center CLI 1.2.2
- Azure-CLI 2.0.77

### Pre-cached tools
- Python (available through the [Use Python Version](https://go.microsoft.com/fwlink/?linkid=871498) task)
  - 2.7.16
  - 3.5.7
  - 3.6.9
  - 3.7.5
  - 3.8.0
  - pypy2
  - pypy3
- Ruby (available through the [Use Ruby Version](https://go.microsoft.com/fwlink/?linkid=2005989) task)
  - 2.4.6
  - 2.5.5
  - 2.6.3

### Xcode
| Version                | Build   | Path                          |
|------------------------|---------|-------------------------------|
| 10.1                   | 10B61   | /Applications/Xcode_10.1.app  |
| 10.0                   | 10A255  | /Applications/Xcode_10.app    |
| 9.4.1                  | 9F2000  | /Applications/Xcode_9.4.1.app |
| 9.4                    | 9F1027a | /Applications/Xcode_9.4.app   |
| 9.3.1                  | 9E501   | /Applications/Xcode_9.3.1.app |
| 9.3                    | 9E145   | /Applications/Xcode_9.3.app   |
| 9.2                    | 9C40b   | /Applications/Xcode_9.2.app   |
| 9.1                    | 9B55    | /Applications/Xcode_9.1.app   |
| 9.0.1                  | 9A1004  | /Applications/Xcode_9.0.1.app |
| 9.0                    | 9A235   | /Applications/Xcode_9.app     |
| 8.3.3                  | 8E3004b | /Applications/Xcode_8.3.3.app |

### Xcode Support Tools

- Nomad CLI 3.0.6
- Nomad CLI IPA 0.14.3
- xcpretty 0.3.0
- xctool 0.3.5
- xcversion 2.6.2

### Installed SDKs
| SDK                       | SDK name    | Xcode Version |
|---------------------------|-------------|---------------|
| macOS 10.12               | macosx10.12 | 8.3.3 |
| macOS 10.13               | macosx10.13 | 9.0, 9.0.1, 9.1, 9.2, 9.3, 9.3.1, 9.4, 9.4.1 |
| macOS 10.14               | macosx10.14 | 10, 10.1 |
| iOS 10.3                  | iphoneos10.3 | 8.3.3 |
| iOS 11.0                  | iphoneos11.0 | 9.0, 9.0.1 |
| iOS 11.1                  | iphoneos11.1 | 9.1 |
| iOS 11.2                  | iphoneos11.2 | 9.2 |
| iOS 11.3                  | iphoneos11.3 | 9.3, 9.3.1 |
| iOS 11.4                  | iphoneos11.4 | 9.4, 9.4.1 |
| iOS 12.0                  | iphoneos12.0 | 10 |
| iOS 12.1                  | iphoneos12.1 | 10.1 |
| iOS Simulator 10.3        | iphonesimulator10.3 | 8.3.3 |
| iOS Simulator 11.0        | iphonesimulator11.0 | 9.0, 9.0.1 |
| iOS Simulator 11.1        | iphonesimulator11.1 | 9.1 |
| iOS Simulator 11.2        | iphonesimulator11.2 | 9.2 |
| iOS Simulator 11.3        | iphonesimulator11.3 | 9.3, 9.3.1 |
| iOS Simulator 11.4        | iphonesimulator11.4 | 9.4, 9.4.1 |
| iOS Simulator 12.0        | iphonesimulator12.0 | 10 |
| iOS Simulator 12.1        | iphonesimulator12.1 | 10.1 |
| tvOS 10.2                 | appletvos10.2 | 8.3.3 |
| tvOS 11.0                 | appletvos11.0 | 9.0, 9.0.1 |
| tvOS 11.1                 | appletvos11.1 | 9.1 |
| tvOS 11.2                 | appletvos11.2 | 9.2 |
| tvOS 11.3                 | appletvos11.3 | 9.3, 9.3.1 |
| tvOS 11.4                 | appletvos11.4 | 9.4, 9.4.1 |
| tvOS 12.0                 | appletvos12.0 | 10 |
| tvOS 12.1                 | appletvos12.1 | 10.1 |
| tvOS Simulator 10.2       | appletvsimulator10.2 | 8.3.3 |
| tvOS Simulator 11.0       | appletvsimulator11.0 | 9.0, 9.0.1 |
| tvOS Simulator 11.1       | appletvsimulator11.1 | 9.1 |
| tvOS Simulator 11.2       | appletvsimulator11.2 | 9.2 |
| tvOS Simulator 11.3       | appletvsimulator11.3 | 9.3, 9.3.1 |
| tvOS Simulator 11.4       | appletvsimulator11.4 | 9.4, 9.4.1 |
| tvOS Simulator 12.0       | appletvsimulator12.0 | 10 |
| tvOS Simulator 12.1       | appletvsimulator12.1 | 10.1 |
| watchOS 3.2               | watchos3.2 | 8.3.3 |
| watchOS 4.0               | watchos4.0 | 9.0, 9.0.1 |
| watchOS 4.1               | watchos4.1 | 9.1 |
| watchOS 4.2               | watchos4.2 | 9.2 |
| watchOS 4.3               | watchos4.3 | 9.3, 9.3.1, 9.4, 9.4.1 |
| watchOS 5.0               | watchos5.0 | 10.0 |
| watchOS 5.1               | watchos5.1 | 10.1 |
| watchOS Simulator 3.2     | watchsimulator3.2 | 8.3.3 |
| watchOS Simulator 4.0     | watchsimulator4.0 | 9.0, 9.0.1 |
| watchOS Simulator 4.1     | watchsimulator4.1 | 9.1 |
| watchOS Simulator 4.2     | watchsimulator4.2 | 9.2 |
| watchOS Simulator 4.3     | watchsimulator4.3 | 9.3, 9.3.1, 9.4, 9.4.1 |
| watchOS Simulator 5.0     | watchsimulator5.0 | 10.0 |
| watchOS Simulator 5.1     | watchsimulator5.1 | 10.1 |

### Installed Simulators

#### Runtimes

| OS      | Xcode Version                   | Simulators |
|---------|---------------------------------|------------|
| iOS 8.4 (12H141) | 8.3.3, 9.0, 9.0.1, 9.1, 9.2, 9.3, 9.3.1, 9.4, 9.4.1, 10.0, 10.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPad 2<br>iPad Retina<br>iPad Air |
| iOS 9.0 (13A344) | 8.3.3, 9.0, 9.0.1, 9.1, 9.2, 9.3, 9.3.1, 9.4, 9.4.1, 10.0, 10.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Retina<br>iPad Air<br>iPad Air 2 |
| iOS 9.1 (13B143)<br>iOS 9.2 (13C75)<br>iOS 9.3 (13E233) | 8.3.3, 9.0, 9.0.1, 9.1, 9.2, 9.3, 9.3.1, 9.4, 9.4.1, 10.0, 10.1 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Retina<br>iPad Air<br>iPad Air 2<br>iPad Pro |
| iOS 10.0 (14A345) | 8.3.3, 9.0, 9.0.1, 9.1, 9.2, 9.3, 9.3.1, 9.4, 9.4.1, 10.0, 10.1 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (9.7 inch)<br>iPad Pro (12.9 inch) |
| iOS 10.1 (14B72)<br>iOS 10.2 (14C89) | 8.3.3, 9.0, 9.0.1, 9.1, 9.2, 9.3, 9.3.1, 9.4, 9.4.1, 10.0, 10.1 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (9.7 inch)<br>iPad Pro (12.9 inch) |
| iOS 10.3 (14E8301) | 8.3.3 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (9.7 inch)<br>iPad Pro (12.9 inch)<br>iPad (5th generation)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (10.5-inch) |
| iOS 11.0 (15A372) | 9.0 | iPhone 5s <br> iPhone 6 <br> iPhone 6 Plus <br> iPhone 6s <br> iPhone 6s Plus <br> iPhone 7 <br> iPhone 7 Plus <br> iPhone 8 <br> iPhone 8 Plus <br> iPhone SE <br> iPhone X <br> iPad Air <br> iPad Air 2 <br> iPad (5th generation) <br> iPad Pro (9.7-inch) <br> iPad Pro (12.9-inch) <br> iPad Pro (12.9-inch) (2nd generation) <br> iPad Pro (10.5-inch) |
| iOS 11.0 (15A8401) | 9.0.1 | iPhone 5s <br> iPhone 6 <br> iPhone 6 Plus <br> iPhone 6s <br> iPhone 6s Plus <br> iPhone 7 <br> iPhone 7 Plus <br> iPhone 8 <br> iPhone 8 Plus <br> iPhone SE <br> iPhone X <br> iPad Air <br> iPad Air 2 <br> iPad (5th generation) <br> iPad Pro (9.7-inch) <br> iPad Pro (12.9-inch) <br> iPad Pro (12.9-inch) (2nd generation) <br> iPad Pro (10.5-inch) |
| iOS 11.1 (15B87) | 9.1 | iPhone 5s <br> iPhone 6 <br> iPhone 6 Plus <br> iPhone 6s <br> iPhone 6s Plus <br> iPhone 7 <br> iPhone 7 Plus <br> iPhone 8 <br> iPhone 8 Plus <br> iPhone SE <br> iPhone X <br> iPad Air <br> iPad Air 2 <br> iPad (5th generation) <br> iPad Pro (9.7-inch) <br> iPad Pro (12.9-inch) <br> iPad Pro (12.9-inch) (2nd generation) <br> iPad Pro (10.5-inch) |
| iOS 11.2 (15C107) | 9.2 | iPhone 5s <br> iPhone 6 <br> iPhone 6 Plus <br> iPhone 6s <br> iPhone 6s Plus <br> iPhone 7 <br> iPhone 7 Plus <br> iPhone 8 <br> iPhone 8 Plus <br> iPhone SE <br> iPhone X <br> iPad Air <br> iPad Air 2 <br> iPad (5th generation) <br> iPad Pro (9.7-inch) <br> iPad Pro (12.9-inch) <br> iPad Pro (12.9-inch) (2nd generation) <br> iPad Pro (10.5-inch) |
| iOS 11.3 (15E217) | 9.3, 9.3.1 | iPhone 5s <br> iPhone 6 <br> iPhone 6 Plus <br> iPhone 6s <br> iPhone 6s Plus <br> iPhone 7 <br> iPhone 7 Plus <br> iPhone 8 <br> iPhone 8 Plus <br> iPhone SE <br> iPhone X <br> iPad Air <br> iPad Air 2 <br> iPad (5th generation) <br> iPad Pro (9.7-inch) <br> iPad Pro (12.9-inch) <br> iPad Pro (12.9-inch) (2nd generation) <br> iPad Pro (10.5-inch) |
| iOS 11.4 (15F79) | 9.4, 9.4.1 | iPhone 5s <br> iPhone 6 <br> iPhone 6 Plus <br> iPhone 6s <br> iPhone 6s Plus <br> iPhone 7 <br> iPhone 7 Plus <br> iPhone 8 <br> iPhone 8 Plus <br> iPhone SE <br> iPhone X <br> iPad Air <br> iPad Air 2 <br> iPad (5th generation) <br> iPad Pro (9.7-inch) <br> iPad Pro (12.9-inch) <br> iPad Pro (12.9-inch) (2nd generation) <br> iPad Pro (10.5-inch) |
| iOS 12.0 (16A366) | 10.0 | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPhone 8<br>iPhone 8 Plus<br>iPhone X<br>iPhone XR<br>iPhone XS<br>iPhone XS Max<br>iPad Air<br>iPad Air 2<br>iPad (5th generation)<br>iPad Pro (9.7-inch)<br>iPad Pro (10.5-inch)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad (6th generation) |
| iOS 12.1 (16B91) | 10.1 | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPhone 8<br>iPhone 8 Plus<br>iPhone X<br>iPhone X<br>iPhone XS<br>iPhone XS Max<br>iPhone XR<br>iPad Air<br>iPad Air 2<br>iPad (5th generation)<br>iPad Pro (9.7-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (10.5-inch)<br>iPad (6th generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation) |
| tvOS 10.2 (14W260) | 8.3.3 | Apple TV 1080p |
| tvOS 11.0 (15J380) | 9.0, 9.0.1 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| tvOS 11.1 (15J580) | 9.1 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| tvOS 11.2 (15K104) | 9.2 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| tvOS 11.3 (15L211) | 9.3, 9.3.1 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| tvOS 11.4 (15L576) | 9.4, 9.4.1 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| tvOS 12.0 (16J364) | 10.0 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| tvOS 12.1 (16J602) | 10.1 | Apple TV <br> Apple TV 4K <br> Apple TV 4K (at 1080p) |
| watchOS 3.2 (14V243) | 8.3.3 | Apple Watch - 38mm <br> Apple Watch - 42mm <br> Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm |
| watchOS 4.0 (15R372) | 9.0, 9.0.1 | Apple Watch - 38mm <br> Apple Watch - 42mm <br> Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm <br> Apple Watch Series 3 - 38mm <br> Apple Watch Series 3 - 42mm |
| watchOS 4.1 (15R844) | 9.1 | Apple Watch - 38mm <br> Apple Watch - 42mm <br> Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm <br> Apple Watch Series 3 - 38mm <br> Apple Watch Series 3 - 42mm |
| watchOS 4.2 (15S100) | 9.2 | Apple Watch - 38mm <br> Apple Watch - 42mm <br> Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm <br> Apple Watch Series 3 - 38mm <br> Apple Watch Series 3 - 42mm |
| watchOS 4.3 (15T212) | 9.3, 9.3.1, 9.4, 9.4.1 | Apple Watch - 38mm <br> Apple Watch - 42mm <br> Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm <br> Apple Watch Series 3 - 38mm <br> Apple Watch Series 3 - 42mm |
| watchOS 5.0 (16R363) | 10.0 | Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm <br> Apple Watch Series 3 - 38mm <br> Apple Watch Series 3 - 42mm <br> Apple Watch Series 4 - 40mm <br> Apple Watch Series 4 - 44mm |
| watchOS 5.1 (16R591) | 10.1 | Apple Watch Series 2 - 38mm <br> Apple Watch Series 2 - 42mm <br> Apple Watch Series 3 - 38mm <br> Apple Watch Series 3 - 42mm <br> Apple Watch Series 4 - 40mm <br> Apple Watch Series 4 - 44mm |

#### How to install additional simulators?
Image contains only default simulators for each Xcode version. To install a specific simulator for all Xcode version, use xcversion tool:
```
xcversion simulators --install='iOS 8.4'
```
**!** - The installation of some simulators may cause compatibility issues.

### Device Pairs

| Watch                       | Phone          |
|-----------------------------|----------------|
| Apple Watch - 38mm          | iPhone 6s      |
| Apple Watch - 42mm          | iPhone 6s Plus |
| Apple Watch Series 2 - 38mm | iPhone 7       |
| Apple Watch Series 2 - 42mm | iPhone 7 Plus  |
| Apple Watch Series 3 - 38mm | iPhone 8       |
| Apple Watch Series 3 - 42mm | iPhone 8 Plus  |
| Apple Watch Series 4 - 40mm | iPhone XS      |
| Apple Watch Series 4 - 44mm | iPhone XS Max  |

## Android

### Android SDK Tools

| Package name          | Description                                 |
|-----------------------|---------------------------------------------|
| tools                 | Android SDK Tools, revision 26.1.1          |

### Android SDK Platform-tools

| Package name          | Description                                 |
|-----------------------|---------------------------------------------|
| platform-tools        | Android SDK Platform-tools, revision 29.0.5 |

### Android SDK Platforms

| Package name          | Description                               |
|-----------------------|-------------------------------------------|
| android-15            | Android SDK Platform 15, Revision 5       |
| android-16            | Android SDK Platform 16, Revision 5       |
| android-17            | Android SDK Platform 17, Revision 3       |
| android-18            | Android SDK Platform 18, Revision 3       |
| android-19            | Android SDK Platform 19, Revision 4       |
| android-20            | Android SDK Platform 20, Revision 2       |
| android-21            | Android SDK Platform 21, Revision 2       |
| android-22            | Android SDK Platform 22, Revision 2       |
| android-23            | Android SDK Platform 23, Revision 3       |
| android-24            | Android SDK Platform 24, Revision 2       |
| android-25            | Android SDK Platform 25, Revision 3       |
| android-26            | Android SDK Platform 26, Revision 2       |
| android-27            | Android SDK Platform 27, Revision 3       |
| android-28            | Android SDK Platform 28, Revision 6       |
| android-29            | Android SDK Platform 29, Revision 3       |

### Android SDK Build-tools

| Package name          | Description                               |
|-----------------------|-------------------------------------------|
| build-tools-19.1.0    | Android SDK Build-tools, Revision 19.1.0  |
| build-tools-20.0.0    | Android SDK Build-tools, Revision 20.0.0  |
| build-tools-21.1.2    | Android SDK Build-tools, Revision 21.1.2  |
| build-tools-22.0.1    | Android SDK Build-tools, Revision 22.0.1  |
| build-tools-23.0.1    | Android SDK Build-tools, Revision 23.0.1  |
| build-tools-23.0.2    | Android SDK Build-tools, Revision 23.0.2  |
| build-tools-23.0.3    | Android SDK Build-tools, Revision 23.0.3  |
| build-tools-24.0.0    | Android SDK Build-tools, Revision 24.0.0  |
| build-tools-24.0.1    | Android SDK Build-tools, Revision 24.0.1  |
| build-tools-24.0.2    | Android SDK Build-tools, Revision 24.0.2  |
| build-tools-24.0.3    | Android SDK Build-tools, Revision 24.0.3  |
| build-tools-25.0.0    | Android SDK Build-tools, Revision 25.0.0  |
| build-tools-25.0.1    | Android SDK Build-tools, Revision 25.0.1  |
| build-tools-25.0.2    | Android SDK Build-tools, Revision 25.0.2  |
| build-tools-25.0.3    | Android SDK Build-tools, Revision 25.0.3  |
| build-tools-26.0.0    | Android SDK Build-tools, Revision 26.0.0  |
| build-tools-26.0.1    | Android SDK Build-tools, Revision 26.0.1  |
| build-tools-26.0.2    | Android SDK Build-tools, Revision 26.0.2  |
| build-tools-26.0.3    | Android SDK Build-tools, Revision 26.0.3  |
| build-tools-27.0.0    | Android SDK Build-tools, Revision 27.0.0  |
| build-tools-27.0.1    | Android SDK Build-tools, Revision 27.0.1  |
| build-tools-27.0.2    | Android SDK Build-tools, Revision 27.0.2  |
| build-tools-27.0.3    | Android SDK Build-tools, Revision 27.0.3  |
| build-tools-28.0.0    | Android SDK Build-tools, Revision 28.0.0  |
| build-tools-28.0.1    | Android SDK Build-tools, Revision 28.0.1  |
| build-tools-28.0.2    | Android SDK Build-tools, Revision 28.0.2  |
| build-tools-28.0.3    | Android SDK Build-tools, Revision 28.0.3  |
| build-tools-29.0.0    | Android SDK Build-tools, Revision 29.0.0  |
| build-tools-29.0.1    | Android SDK Build-tools, Revision 29.0.1  |
| build-tools-29.0.2    | Android SDK Build-tools, Revision 29.0.2  |

### Utils

| Package name          | Description                               |
|-----------------------|-------------------------------------------|
| cmake                 | 3.6.4111459                               |
| lldb                  | 3.1.4508709                               |
| ndk-bundle            | 18.1.5063045                              |
| ProGuard              | 5.3.3                                     |
| Android Emulator      | 29.2.1                                    |

### Google APIs

| Package name          | Description                               |
|-----------------------|-------------------------------------------|
| google_apis-google-21 | Google APIs, Android API 21, revision 1   |
| google_apis-google-22 | Google APIs, Android API 22, revision 1   |
| google_apis-google-23 | Google APIs, Android API 23, revision 1   |
| google_apis-google-24 | Google APIs, Android API 24, revision 1   |

### Extra packages

| Package name                      | Description                              |
|-----------------------------------|------------------------------------------|
| extra-android-m2repository        | Android Support Repository, revision 47  |
| extra-google-google_play_services | Google Play services, revision 49        |
| extra-google-m2repository         | Google Repository, revision 58           |
| Hardware_Accelerated_Execution_Manager | Intel x86 Emulator Accelerator 7.5.1     |

## Xamarin

### Visual Studio for Mac

- 8.3.10.2

### Mono

- 6.4.0
- 6.0.0
- 5.18.1
- 5.16.1
- 5.12.0
- 5.10.1
- 5.8.1
- 5.8.0
- 5.4.1.7
- 5.4.0.201
- 5.2.0.224
- 5.0.1.1
- 4.8.1.0

### Xamarin.iOS SDK

- 13.6.0.12
- 13.4.0.2
- 13.2.0.47
- 12.14.0.114
- 12.8.0.2
- 12.6.0.25
- 12.2.1.16
- 12.2.1.11
- 12.0.0.15
- 11.14.0.13
- 11.12.0.4
- 11.9.1.24
- 11.8.0.20
- 11.6.1.4
- 11.2.0.11
- 11.0.0.0
- 10.10.0.36
- 10.6.0.10


### Xamarin.Android SDK

- 10.0.6.2
- 10.0.3.0
- 9.4.1.0
- 9.3.0-23
- 9.2.3-0
- 9.1.8-0
- 9.0.0-20
- 9.0.0-18
- 8.3.3-2
- 8.2.0-16
- 8.2.0-15
- 8.1.5-0
- 8.0.0-33
- 7.4.5-1
- 7.3.1-2
- 7.1.0-43

### Xamarin.Mac SDK

- 6.6.0.12
- 6.4.0.2
- 6.2.0.47
- 5.16.1.24
- 5.8.0.0
- 5.6.0.25
- 5.3.1.28
- 5.2.1.16
- 5.2.1.9
- 4.6.0.13
- 4.4.1.193
- 4.2.1.28
- 4.2.0.20
- 4.0.0.216
- 3.8.0.49
- 3.6.3.3
- 3.4.0.36
- 3.0.0.398

### Unit Test Framework

- NUnit: 3.6.1
