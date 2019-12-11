# Azure Pipelines hosted macOS image

The following software is installed on machines in the Azure Pipelines **macOS-10.14** VM image ('Hosted macOS' pool).

#### Xcode 11.1 set by default

## Operating System

- OS X 10.14.6 (18G1012) **Mojave**

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
- .NET Core SDK 1.0.1 1.0.4 1.1.10 1.1.11 1.1.12 1.1.13 1.1.4 1.1.5 1.1.7 1.1.8 1.1.9 2.0.0 2.0.3 2.1.100 2.1.101 2.1.102 2.1.103 2.1.104 2.1.105 2.1.2 2.1.200 2.1.201 2.1.202 2.1.300 2.1.301 2.1.302 2.1.4 2.1.400 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.2.100 2.2.101 2.2.102 2.2.103 2.2.104 2.2.105
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

- curl 7.67.0 (x86_64-apple-darwin17.7.0) libcurl/7.67.0 SecureTransport zlib/1.2.11)
- Git 2.24.0
- Git LFS 2.8.0
- GNU Wget 1.20.3 built on darwin18.7.0
- Subversion (SVN) 1.13.0
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

| Version                | Build   | Path                             |
|------------------------|---------|----------------------------------|
| 11.3_beta              | 11C24b  | /Applications/Xcode_11.3_beta.app|
| 11.2.1                 | 11B53   | /Applications/Xcode_11.2.1.app   |
| 11.2                   | 11B52   | /Applications/Xcode_11.2.app     |
| 11.1                   | 11A1027 | /Applications/Xcode_11.1.app     |
| 11.0                   | 11A420a | /Applications/Xcode_11.app       |
| 10.3                   | 10G8    | /Applications/Xcode_10.3.app     |
| 10.2.1                 | 10E1001 | /Applications/Xcode_10.2.1.app   |
| 10.2                   | 10E125  | /Applications/Xcode_10.2.app     |
| 10.1                   | 10B61   | /Applications/Xcode_10.1.app     |
| 10.0                   | 10A255  | /Applications/Xcode_10.app       |
| 9.4.1                  | 9F2000  | /Applications/Xcode_9.4.1.app    |

### Xcode Support Tools

- Nomad CLI 3.0.6
- Nomad CLI IPA 0.14.3
- xcpretty 0.3.0
- xctool 0.3.6
- xcversion 2.6.3

### Installed SDKs

| SDK                       | SDK name    |Xcode Version |
|---------------------------|-------------|--------------|
| macOS 10.13               | macosx10.13 | 9.4.1        |
| macOS 10.14               | macosx10.14 | 10.0, 10.1, 10.2, 10.2.1, 10.3, 11.3_beta |
| macOS 10.15               | macosx10.15 | 11.0, 11.1, 11.2, 11.2.1, 11.3_beta |
| iOS 11.4                  | iphoneos11.4 | 9.4.1       |
| iOS 12.0                  | iphoneos12.0 | 10.0        |
| iOS 12.1                  | iphoneos12.1 | 10.1        |
| iOS 12.2                  | iphoneos12.2 | 10.2, 10.2.1|
| iOS 12.4                  | iphoneos12.4 | 10.3        |
| iOS 13.0                  | iphoneos13.0 | 11.0        |
| iOS 13.1                  | iphoneos13.1 | 11.1        |
| iOS 13.2                  | iphoneos13.2 | 11.2, 11.2.1, 11.3_beta |
| iOS Simulator 11.4        | iphonesimulator11.4 | 9.4.1    |
| iOS Simulator 12.0        | iphonesimulator12.0 | 10.0     |
| iOS Simulator 12.1        | iphonesimulator12.1 | 10.1     |
| iOS Simulator 12.2        | iphonesimulator12.2 | 10.2, 10.2.1 |
| iOS Simulator 12.4        | iphonesimulator12.4 | 10.3     |
| iOS Simulator 13.0        | iphonesimulator13.0 | 11.0     |
| iOS Simulator 13.1        | iphonesimulator13.1 | 11.1     |
| iOS Simulator 13.2        | iphonesimulator13.2 | 11.2, 11.2.1, 11.3_beta |
| tvOS 11.4                 | appletvos11.4 | 9.4.1          |
| tvOS 12.0                 | appletvos12.0 | 10.0           |
| tvOS 12.1                 | appletvos12.1 | 10.1           |
| tvOS 12.2                 | appletvos12.2 | 10.2, 10.2.1   |
| tvOS 12.4                 | appletvos12.4 | 10.3           |
| tvOS 13.0                 | appletvos13.0 | 11.0, 11.1     |
| tvOS 13.2                 | appletvos13.2 | 11.2, 11.2.1, 11.3_beta |
| tvOS Simulator 11.4       | appletvsimulator11.4 | 9.4.1   |
| tvOS Simulator 12.0       | appletvsimulator12.0 | 10.0    |
| tvOS Simulator 12.1       | appletvsimulator12.1 | 10.1    |
| tvOS Simulator 12.2       | appletvsimulator12.2 | 10.2, 10.2.1 |
| tvOS Simulator 12.4       | appletvsimulator12.4 | 10.3    |
| tvOS Simulator 13.0       | appletvsimulator13.0 | 11.0, 11.1 |
| tvOS Simulator 13.2       | appletvsimulator13.2 | 11.2, 11.2.1, 11.3_beta |
| watchOS 4.3               | watchos4.3 | 9.4.1         |
| watchOS 5.0               | watchos5.0 | 10.0          |
| watchOS 5.1               | watchos5.1 | 10.1          |
| watchOS 5.2               | watchos5.2 | 10.2, 10.2.1  |
| watchOS 5.3               | watchos5.3 | 10.3          |
| watchOS 6.0               | watchos6.0 | 11.0, 11.1    |
| watchOS 6.1               | watchos6.1 | 11.2, 11.2.1, 11.3_beta |
| watchOS Simulator 4.3     | watchsimulator4.3 | 9.4.1         |
| watchOS Simulator 5.0     | watchsimulator5.0 | 10.0          |
| watchOS Simulator 5.1     | watchsimulator5.1 | 10.1          |
| watchOS Simulator 5.2     | watchsimulator5.2 | 10.2, 10.2.1  |
| watchOS Simulator 5.3     | watchsimulator5.3 | 10.3          |
| watchOS Simulator 6.0     | watchsimulator6.0 | 11.0, 11.1    |
| watchOS Simulator 6.1     | watchsimulator6.1 | 11.2, 11.2.1, 11.3_beta |
| DriverKit 19.0            | driverkit.macosx19.0 | 11.0, 11.1, 11.2, 11.2.1, 11.3_beta |


### Installed Simulators

#### Runtimes

| OS      | Xcode Version                   | Simulators |
|---------|---------------------------------|------------|
| iOS 8.4 (12H141) | 9.4.1, 10.0, 10.1, 10.2, 10.2.1, 11, 11.1, 11.2 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPad 2<br>iPad Retina<br>iPad Air |
| iOS 9.0 (13A344) | 9.4.1, 10.0, 10.1, 10.2, 10.2.1, 11, 11.1, 11.2 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Retina<br>iPad Air<br>iPad Air 2 |
| iOS 9.1 (13B143)<br>iOS 9.2 (13C75)<br>iOS 9.3 (13E233) | 9.4.1, 10.0, 10.1, 10.2, 10.2.1, 11, 11.1, 11.2 | iPhone 4s<br>iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPad 2<br>iPad Retina<br>iPad Air<br>iPad Air 2<br>iPad Pro |
| iOS 10.0 (14A345) | 9.4.1, 10.0, 10.1, 10.2, 10.2.1, 11, 11.1, 11.2 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (9.7 inch)<br>iPad Pro (12.9 inch) |
| iOS 10.1 (14B72)<br>iOS 10.2 (14C89) | 9.4.1, 10.0, 10.1, 10.2, 10.2.1, 11, 11.1, 11.2 | iPhone 5<br>iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPad Air<br>iPad Air 2<br>iPad Pro (9.7 inch)<br>iPad Pro (12.9 inch) |
| iOS 11.4 (15F79) | 9.4.1 | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPhone 8<br>iPhone 8 Plus<br>iPhone X<br>iPad Air<br>iPad Air 2<br>iPad (5th generation)<br>iPad Pro (9.7-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (10.5-inch) |
| iOS 12.0 (16A5288q) | 10.0 | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPhone 8<br>iPhone 8 Plus<br>iPhone X<br>iPhone XR<br>iPhone XS<br>iPhone XS Max<br>iPad Air<br>iPad Air 2<br>iPad (5th generation)<br>iPad Pro (9.7-inch)<br>iPad Pro (10.5-inch)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad (6th generation) |
| iOS 12.1 (16B91) | 10.1 | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPhone 8<br>iPhone 8 Plus<br>iPhone X<br>iPhone X<br>iPhone XS<br>iPhone XS Max<br>iPhone XR<br>iPad Air<br>iPad Air 2<br>iPad (5th generation)<br>iPad Pro (9.7-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (10.5-inch)<br>iPad (6th generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation) |
| iOS 12.2 (16E226)<br>iOS 12.4 (16G73) | 10.2, 10.2.1<br>10.3  | iPhone 5s<br>iPhone 6<br>iPhone 6 Plus<br>iPhone 6s<br>iPhone 6s Plus<br>iPhone 7<br>iPhone 7 Plus<br>iPhone SE<br>iPhone 8<br>iPhone 8 Plus<br>iPhone X<br>iPhone X<br>iPhone XS<br>iPhone XS Max<br>iPhone XR<br>iPad Air<br>iPad Air 2<br>iPad Air (3rd generation)<br>iPad mini 2<br>iPad mini 3<br>iPad mini 4<br>iPad mini (5th generation)<br>iPad (5th generation)<br>iPad Pro (9.7-inch)<br>iPad Pro (12.9-inch)<br>iPad Pro (12.9-inch) (2nd generation)<br>iPad Pro (10.5-inch)<br>iPad (6th generation)<br>iPad Pro (11-inch)<br>iPad Pro (12.9-inch) (3rd generation) |
| iOS 13.0 (17A577a) | 11         | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) |
| iOS 13.1 (17A844) | 11.1        | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) |
| iOS 13.2 (17B102) | 11.2, 11.2.1     | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad (7th generation)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) |
| iOS 13.3 (17C5032d) | 11.2 11.2.1 11.3_beta | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad (7th generation)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) | 																																																																 
| tvOS 11.4 (15L576)<br>tvOS 12.0 (16J5283n)<br>tvOS 12.1 (16J602)<br>tvOS 12.2 (16L225)<br>tvOS 12.4 (16M567)<br>tvOS 13.0 (17J559)<br>tvOS 13.2 (17K90) | 9.4.1<br>10.0<br>10.1<br>10.2, 10.2.1<br>10.3<br>11.0, 11.1<br>11.2, 11.2.1, 11.3_beta         | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p) |
| watchOS 4.3 (15T212) | 9.4.1        | Apple Watch 38mm<br>Apple Watch 42mm<br>Apple Watch Series 2 38mm<br>Apple Watch Series 2 42mm<br>Apple Watch Series 3 38mm<br>Apple Watch Series 3 42mm |
| watchOS 5.0 (16R5283q)<br>watchOS 5.1 (16R591)<br>watchOS 5.2 (16T224)<br>watchOS 5.3 (16U567) | 10.0<br>10.1<br>10.2, 10.2.1<br>10.3      | Apple Watch Series 2 38mm<br>Apple Watch Series 2 42mm<br>Apple Watch Series 3 38mm<br>Apple Watch Series 3 42mm<br>Apple Watch Series 4 40mm<br>Apple Watch Series 4 44mm |
| watchOS 6.0 (17R566)<br><br>watchOS 6.1 (17S80) | 11.0<br>11.1<br>11.2, 11.2.1, 11.3_beta    | Apple Watch Series 4 40mm<br>Apple Watch Series 4 44mm<br>Apple Watch Series 5 40mm<br>Apple Watch Series 5 44mm |


#### How to install additional simulators?
Image contains only default simulators for each Xcode version. To install a specific simulator for all Xcode version, use xcversion tool:
```
xcversion simulators --install='iOS 8.4'
```
**!** - The installation of some simulators may cause compatibility issues.

### Device Pairs

| Watch                       | Phone             |
|-----------------------------|-------------------|
| Apple Watch - 38mm          | iPhone 6s         |
| Apple Watch - 42mm          | iPhone 6s Plus    |
| Apple Watch Series 2 - 38mm | iPhone 7          |
| Apple Watch Series 2 - 42mm | iPhone 7 Plus     |
| Apple Watch Series 3 - 38mm | iPhone 8          |
| Apple Watch Series 3 - 42mm | iPhone 8 Plus     |
| Apple Watch Series 4 - 40mm | iPhone XS         |
| Apple Watch Series 4 - 44mm | iPhone XS Max     |
| Apple Watch Series 5 - 40mm | iPhone 11 Pro     |
| Apple Watch Series 5 - 44mm | iPhone 11 Pro Max |

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
| lldb                  | 2.3.3614996                               |
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
| Hardware_Accelerated_Execution_Manager | Intel x86 Emulator Accelerator 7.3.2 |

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
- 12.10.0.157
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
- 5.10.0.157
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
