---
title: GitHub Hosted Github Mojave 10.15 VM Image Updates
description: Software used on build machines
date: Week 51
---

#### Xcode 11.1 set by default

## Operating System

- OS X 10.15.1 (19B88) **Catalina**

## Installed Software

### Language and Runtime

- Java 1.7 : OpenJDK Runtime Environment (Zulu 7.34.0.5-CA-macosx) (build 1.7.0_242-b7)
- Java 1.8 : OpenJDK Runtime Environment (Zulu 8.42.0.23-CA-macosx) (build 1.8.0_232-b18) (default)
- Java 11 : OpenJDK Runtime Environment Zulu11.35+15-CA (build 11.0.5+10-LTS)
- Java 12 : OpenJDK Runtime Environment Zulu12.3+11-CA (build 12.0.2+3)
- Java 13 : OpenJDK Runtime Environment Zulu13.28+11-CA (build 13.0.1+10-MTS)
- Node.js v12.13.1
- NVM 0.33.11
- NVM - Installed node versions:
  v6.17.1  *
  v8.16.2  *
  v10.17.0 *
  v12.13.1 *
  v13.3.0  *
- PowerShell 6.2.3
- Python 2.7.17
- Python 3.7.5
- Ruby -2.6.5p114
- .NET SDK 2.0.0 3.0.100 3.0.101
- Go 1.13.4

### Package Management

- Bundler 2.0.2
- Carthage 0.34.0
- CocoaPods 1.8.4
- Homebrew 2.2.0
- NPM 6.12.1
- Yarn 1.19.2
- NuGet 5.3.1.6268
- pip 19.3.1
- Miniconda 4.7.12

### Project Management

- Apache Maven 3.6.3
- Gradle 6.0.1

### Utilities

- curl 7.67.0 (x86_64-apple-darwin19.0.0) libcurl/7.67.0 SecureTransport zlib/1.2.11
- Git 2.24.0
- Git LFS: git-lfs/2.8.0 (GitHub; darwin amd64; go 1.12.7)
- GNU Wget 1.20.3
- Subversion (SVN) 1.13.0
- GNU parallel 20191122

### Tools

- fastlane 2.137.0
- App Center CLI 2.3.2
- Azure-Cli 2.0.77

### Pre-cached tools

- Python
  - 2.7.16
  - 3.5.7
  - 3.6.9
  - 3.7.4
  - 3.8.0
  - pypy2
  - pypy3
- Ruby
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


### Xcode Support Tools

- Nomad CLI 3.0.6
- Nomad CLI IPA 0.14.3
- xcpretty 0.3.0
- xctool 0.3.6
- xcversion 2.6.3

### Installed SDKs

| SDK                       | SDK name    |Xcode Version |
|---------------------------|-------------|--------------|
| macOS 10.15               | macosx10.15 | 11.0, 11.1, 11.2, 11.2.1 |
| iOS 13.0                  | iphoneos13.0 | 11.0        |
| iOS 13.1                  | iphoneos13.1 | 11.1        |
| iOS 13.2                  | iphoneos13.2 | 11.2, 11.2.1        |
| iOS Simulator 13.0        | iphonesimulator13.0 | 11.0     |
| iOS Simulator 13.1        | iphonesimulator13.1 | 11.1     |
| iOS Simulator 13.2        | iphonesimulator13.2 | 11.2, 11.2.1     |
| tvOS 13.0                 | appletvos13.0 | 11.0, 11.1     |
| tvOS 13.2                 | appletvos13.2 | 11.2, 11.2.1   |
| tvOS Simulator 13.0       | appletvsimulator13.0 | 11.0, 11.1 |
| tvOS Simulator 13.2       | appletvsimulator13.2 | 11.2, 11.2.1    |
| watchOS 6.0               | watchos6.0 | 11.0, 11.1    |
| watchOS 6.1               | watchos6.1 | 11.2, 11.2.1  |
| watchOS Simulator 6.0     | watchsimulator6.0 | 11.0, 11.1    |
| watchOS Simulator 6.1     | watchsimulator6.1 | 11.2, 11.2.1  |
| DriverKit 19.0            | driverkit.macosx19.0 | 11.0, 11.1, 11.2, 11.2.1 |

### Installed Simulators

#### Runtimes

| OS      | Xcode Version                   | Simulators |
|---------|---------------------------------|------------|
| iOS 13.0 (17A577a) | 11         | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) |
| iOS 13.1 (17A844) | 11.1        | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) |
| iOS 13.2 (17B102) | 11.2, 11.2.1     | iPhone 8<br>iPhone 8 Plus<br>iPhone 11<br>iPhone 11 Pro<br>iPhone 11 Pro Max<br>iPad Pro (9.7-inch)<br>iPad (7th generation)<br>iPad Pro<br>iPad Pro (12.9-inch) (3rd generation)<br>iPad Air (3rd generation) |
| tvOS 11.4 (15L576)<br>tvOS 12.0 (16J5283n)<br>tvOS 12.1 (16J602)<br>tvOS 12.2 (16L225)<br>tvOS 12.4 (16M567)<br>tvOS 13.0 (17J559)<br>tvOS 13.2 (17K90) | 11.0, 11.1<br>11.2, 11.2.1        | Apple TV<br>Apple TV 4K<br>Apple TV 4K (at 1080p) |
| watchOS 6.0 (17R566)<br><br>watchOS 6.1 (17S80) | 11.0<br>11.1<br>11.2, 11.2.1     | Apple Watch Series 4 40mm<br>Apple Watch Series 4 44mm<br>Apple Watch Series 5 40mm<br>Apple Watch Series 5 44mm |


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
| android-24            | Android SDK Platform 24, Revision 2       |
| android-25            | Android SDK Platform 25, Revision 3       |
| android-26            | Android SDK Platform 26, Revision 2       |
| android-27            | Android SDK Platform 27, Revision 3       |
| android-28            | Android SDK Platform 28, Revision 6       |
| android-29            | Android SDK Platform 29, Revision 4       |

### Android SDK Build-tools

| Package name          | Description                               |
|-----------------------|-------------------------------------------|
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
| cmake                 | 3.15.5                                    |
| lldb                  | 2.3.3614996                               |
| ndk-bundle            | 18.1.5063045                              |
| ProGuard              | 5.3.3                                     |
| Android Emulator      | 29.2.11                                   |

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

### Xamarin.iOS SDK

- 13.6.0.12
- 13.4.0.2

### Xamarin.Android SDK

- 10.0.6.2
- 10.0.3.0

### Xamarin.Mac SDK

- 6.6.0.12
- 6.4.0.2

### Unit Test Framework

- NUnit: 3.6.1
