| Announcements |
|-|
| [[Ubuntu] AzCopy 7 will be removed from Ubuntu images on March, 2](https://github.com/actions/virtual-environments/issues/2724) |
| [[ubuntu, windows] GOROOT environment variable will be removed on March, 1](https://github.com/actions/virtual-environments/issues/2683) |
| [[Ubuntu] Android SDK Platforms and Build-tools that are less than version 23 will be removed on March, 1](https://github.com/actions/virtual-environments/issues/2673) |
| [[Windows, Ubuntu] Boost 1.72.0 will be removed from images on March, 8](https://github.com/actions/virtual-environments/issues/2667) |
| [[Ubuntu, windows] M2_HOME variable will be removed on February, 15](https://github.com/actions/virtual-environments/issues/2600) |
| [[Ubuntu, macOS] .NET 3.0 will be removed from images on March, 1](https://github.com/actions/virtual-environments/issues/2558) |
| [Ubuntu-latest workflows will use Ubuntu-20.04](https://github.com/actions/virtual-environments/issues/1816) |
***
# Ubuntu 16.04.7 LTS
- Image Version: 20210219.1

## Installed Software
### Language and Runtime
- Bash 4.3.48(1)-release
- Clang 6.0.0, 8.0.0, 9.0.1
- Erlang 11.1.7
- GNU C++ 5.5.0, 7.5.0, 8.4.0, 9.3.0
- GNU Fortran 5.5.0, 8.4.0, 9.3.0
- Julia 1.5.3
- Mono 6.12.0.107
- Node 14.15.5
- Perl 5.22.1
- Python 2.7.12
- Python3 3.5.2
- Ruby 2.3.1p112
- Swift 5.3.3

### Package Management
- cpan 1.61
- Helm 3.5.2
- Homebrew 3.0.1
- Miniconda 4.9.2
- Npm 6.14.11
- Pip 8.1.1
- Pip3 8.1.1
- RubyGems 2.5.2
- Vcpkg  (build from master \<99dc49d>)
- Yarn 1.22.5

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.9.6
- Gradle 6.8.2
- Maven 3.6.3
- Sbt 1.4.7

### Tools
- 7-Zip 9.20
- Ansible 2.9.18
- apt-fast 1.9.10
- AzCopy10 10.8.0 (available by `azcopy10` alias)
- AzCopy7 7.3.0 (available by `azcopy` alias)
- Bazel 4.0.0
- Bazelisk 1.7.5
- binutils 2.26.1
- CMake 3.19.5
- CodeQL Action Bundle 2.4.2
- coreutils 8.25
- curl 7.47.0
- Docker Compose 1.28.4
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.3+azure
- Docker-Moby Server 20.10.3+azure
- Git 2.29.0
- Git LFS 2.13.2
- Git-ftp 1.0.2
- Haveged 1.9.1
- Heroku 7.47.13
- HHVM (HipHop VM) 4.56.2
- jq 1.5
- Kind 0.10.0
- Kubectl 1.19.0
- Kustomize 4.0.1
- Leiningen 2.9.5
- m4 1.4.17
- MediaInfo 0.7.82
- Mercurial 4.4.1
- Minikube 1.17.1
- Newman 5.2.2
- nvm 0.37.2
- Packer 1.7.0
- pass 1.6.5
- PhantomJS 2.1.1
- Pulumi 2.21.1
- R 4.0.4
- Sphinx Open Source Search Server 2.2.9
- SVN 1.9.3
- Swig 3.0.8
- Terraform 0.14.7
- unzip 6.00
- wget 1.17.1
- yamllint 1.2.1
- zip 3.0
- zstd 1.3.1

### CLI Tools
- Alibaba Cloud CLI 3.0.73
- AWS CLI 1.19.12
- AWS CLI Session manager plugin 1.2.54.0
- AWS SAM CLI 1.18.2
- Azure CLI (azure-cli) 2.19.1
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.6.1
- Google Cloud SDK 328.0.0
- Hub CLI 2.14.2
- Netlify CLI 3.8.4
- oc CLI 4.6.17
- ORAS CLI 0.10.0
- Vercel CLI 21.2.3

### Java
| Version             | Vendor       | Environment Variable |
| ------------------- | ------------ | -------------------- |
| 1.8.0_282 (default) | AdoptOpenJDK | JAVA_HOME_8_X64      |
| 11.0.10             | AdoptOpenJDK | JAVA_HOME_11_X64     |
| 12.0.2              | AdoptOpenJDK | JAVA_HOME_12_X64     |

### PHP
| Tool     | Version                                         |
| -------- | ----------------------------------------------- |
| PHP      | 5.6.40 7.0.33 7.1.33 7.2.34 7.3.27 7.4.15 8.0.2 |
| Composer | 2.0.9                                           |
| PHPUnit  | 8.5.14                                          |

### Haskell
- Cabal 3.2.0.0
- GHC 8.10.4
- GHCup 0.1.12
- Stack 2.5.1

### Rust Tools
- Cargo 1.50.0
- Rust 1.50.0
- Rustdoc 1.50.0
- Rustup 1.23.1

#### Packages
- Bindgen 0.57.0
- Cargo audit 0.13.1
- Cargo clippy 0.0.212
- Cargo outdated 0.9.14
- Cbindgen 0.17.0
- Rustfmt 1.4.30

### Browsers and Drivers
- Google Chrome 88.0.4324.182
- ChromeDriver 88.0.4324.96
- Mozilla Firefox 85.0.1
- Geckodriver 0.29.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.521 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 2.1.813 3.0.100 3.0.101 3.0.102 3.0.103 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.112 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 3.1.406 5.0.100 5.0.101 5.0.102 5.0.103

### Az Module
- 1.0.0 1.6.0 2.3.2 2.6.0 2.8.0 3.1.0 3.5.0 3.8.0 4.3.0 4.4.0 4.6.0 4.7.0

### Databases
- MongoDB 4.4.4
- Postgre SQL 13.2
- sqlite3 3.11.0

#### MySQL
- MySQL 5.7.33
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.7.0001.1

### Cached Tools
#### Boost
| Version | Architecture | Environment Variable |
| ------- | ------------ | -------------------- |
| 1.72.0  | x64          | BOOST_ROOT_1_72_0    |


#### Go
- 1.13.15
- 1.14.15
- 1.15.8

#### Node.js
- 10.23.3
- 12.20.2
- 14.15.5

#### PyPy
- 2.7.18 [PyPy 7.3.3]
- 3.6.12 [PyPy 7.3.3]

#### Python
- 2.7.18
- 3.5.10
- 3.6.13
- 3.7.10
- 3.8.7
- 3.9.1

#### Ruby
- 2.4.10
- 2.5.8
- 2.6.6
- 2.7.2
- 3.0.0

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_13_X64 | /opt/hostedtoolcache/go/1.13.15/x64 | x64          |
| GOROOT_1_14_X64 | /opt/hostedtoolcache/go/1.14.15/x64 | x64          |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.8/x64  | x64          |

### PowerShell Tools
- PowerShell 7.1.2

#### PowerShell Modules
| Module     | Version |
| ---------- | ------- |
| MarkdownPS | 1.9     |
| Pester     | 5.1.1   |

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.18  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.10.3  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 3.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3<br>22.0.1<br>21.1.2<br>20.0.0<br>19.1.0                                                                                                                                                                                                           |
| Android SDK Platform-Tools | 31.0.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Android SDK Platforms      | android-S (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)<br>android-22 (rev 2)<br>android-21 (rev 2)<br>android-20 (rev 2)<br>android-19 (rev 4)<br>android-18 (rev 3)<br>android-17 (rev 3)<br>android-16 (rev 5)<br>android-15 (rev 5)<br>android-14 (rev 4)<br>android-13 (rev 1)<br>android-12 (rev 3)<br>android-11 (rev 2)<br>android-10 (rev 2) |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| CMake                      | 3.10.2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                                                                                                                                                                                                                                                        |
| Google Play services       | 49                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Google Repository          | 58                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| NDK                        | 21.4.7075529                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

#### Environment variables
| Name             | Value                                                                                |
| ---------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME     | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_ROOT | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag                                            | Digest                                                                   | Created    |
| --------------------------------------------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.10                                               | sha256:f0e9534a598e501320957059cb2a23774b4d4072e37c7b2cf7e95b241f019e35  | 2020-04-24 |
| alpine:3.7                                                | sha256:8421d9a84432575381bfabd248f1eb56f3aa21d9d7cd2511583c68c9b7511d10  | 2019-03-07 |
| alpine:3.8                                                | sha256:2bb501e6173d9d006e56de5bce2720eb06396803300fe1687b58a7ff32bf4c14  | 2020-01-23 |
| alpine:3.9                                                | sha256:414e0518bb9228d35e4cd5165567fb91d26c6a214e9c95899e1e056fcd349011  | 2020-04-24 |
| buildpack-deps:buster                                     | sha256:b42568b32a4dff4f1f378fd0685aa2a8e6931e744798a481fd6ed6672d7f0c47  | 2021-02-09 |
| buildpack-deps:stretch                                    | sha256:97f102be9829fa96039a6113e0f053ffdadf2b2ccb67e8838294aee8a2dd947f  | 2021-02-09 |
| debian:8                                                  | sha256:40d6faa8c33e8ab03428ad97fc109c369fb510d99f4700df9058940ac9944f09  | 2021-02-09 |
| debian:9                                                  | sha256:d0b7b71db141cedc48e1c2807d12b199ffd7ffe75baf272a34c37480dc2159d1  | 2021-02-09 |
| jekyll/builder:latest                                     | sha256:b918b81939a1076dce89d142c0764c2c3cb93858f56ecf4f04ad0387338e77aa  | 2020-12-21 |
| mcr.microsoft.com/azure-pipelines/node8-typescript:latest | sha256:e52e60b9f71183969830a3664279b5d8c799b4b0ec2c25a0686f7c02f6a9669a  | 2018-10-09 |
| node:10                                                   | sha256:4fafd9b63fdfb15112775847a10b2917760c720c8c28cef5167ff40f36b3cd93  | 2021-02-12 |
| node:10-alpine                                            | sha256:dae0a441e1b5201e074312e44b35571bed4a39b5bc07c26c1bfab9f18017ff54  | 2021-02-12 |
| node:12                                                   | sha256:0140c4e17aa1f3fd78b939e3c7ac45accdd5274d0194046b484029a5e46b9db6  | 2021-02-12 |
| node:12-alpine                                            | sha256:77fe10dbc042121e94db7f43b4b912a52514759b847978588eec4d5d0eb5282c  | 2021-02-12 |
| ubuntu:14.04                                              | sha256:63fce984528cec8714c365919882f8fb64c8a3edf23fdfa0b218a2756125456f  | 2020-09-16 |

### Installed apt packages
- binutils, bison, brotli, build-essential, bzip2, coreutils, curl, dbus, dnsutils, dpkg, fakeroot, file, flex, ftp, gnupg2, haveged, imagemagick, iproute2, iputils-ping, jq, lib32z1, libc++-dev, libc++abi-dev, libcurl3, libgbm-dev, libgconf-2-4, libgsl-dev, libgtk-3-0, libicu55, libmagic-dev, libmagickcore-dev, libmagickwand-dev, libsecret-1-dev, libsqlite3-dev, libunwind8, libxkbfile-dev, libxss1, locales, m4, mediainfo, netcat, openssh-client, p7zip, p7zip-full, p7zip-rar, parallel, pass, patchelf, pkg-config, pollinate, rpm, rsync, shellcheck, sphinxsearch, sqlite3, ssh, subversion, sudo, swig, telnet, texinfo, time, tk, tzdata, unzip, upx, wget, xorriso, xvfb, xz-utils, yamllint, zip, zstd, zsync



