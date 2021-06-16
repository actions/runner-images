| Announcements |
|-|
| [[ubuntu] GCC and Gfortran 11 will be removed on May, 31](https://github.com/actions/virtual-environments/issues/3467) |
| [[Ubuntu] .NET SDK pre-installation policy will be changed on June 14](https://github.com/actions/virtual-environments/issues/3338) |
| [Ubuntu 16.04 environment will be removed on September 20, 2021](https://github.com/actions/virtual-environments/issues/3287) |
***
# Ubuntu 16.04.7 LTS
- Linux kernel version: 4.15.0-1113-azure
- Image Version: 20210531.0

## Installed Software
### Language and Runtime
- Bash 4.3.48(1)-release
- Clang 9.0.1
- Clang-format 9.0.1
- Erlang 24.0.1 (Eshell 12.0.1)
- GNU C++ 5.5.0, 9.3.0
- GNU Fortran 5.5.0, 9.3.0
- Julia 1.6.1
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-xenial main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 14.17.0
- Perl 5.22.1
- Python 2.7.12
- Python3 3.5.2
- Ruby 2.3.1p112
- Swift 5.4.1

### Package Management
- cpan 1.61
- Helm 3.6.0
- Homebrew 3.1.9
- Miniconda 4.9.2
- Npm 6.14.13
- Pip 8.1.1
- Pip3 8.1.1
- RubyGems 2.5.2
- Vcpkg  (build from master \<7bc5b8c>)
- Yarn 1.22.10

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.9.6
- Gradle 7.0.2
- Maven 3.8.1
- Sbt 1.5.2

### Tools
- Ansible 2.9.22
- apt-fast 1.9.11
- AzCopy 10.10.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.1.0
- Bazelisk 1.9.0
- CMake 3.20.3
- CodeQL Action Bundle 2.5.5
- Docker Compose 1.29.2
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.6+azure
- Docker-Moby Server 20.10.6+azure
- Git 2.31.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 2.13.3 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.0.2
- Haveged 1.9.1
- Heroku 7.54.0
- HHVM (HipHop VM) 4.56.6
- jq 1.5
- Kind 0.11.1
- Kubectl 1.20.1-5-g76a04fc
- Kustomize 4.1.3
- Leiningen 2.9.6
- MediaInfo 0.7.82
- Mercurial 4.4.1
- Minikube 1.20.0
- Newman 5.2.3
- nvm 0.38.0
- OpenSSL 1.0.2g  1 Mar 2016
- Packer 1.7.2
- PhantomJS 2.1.1
- Pulumi 3.3.1
- R 4.1.0
- Sphinx Open Source Search Server 2.2.9
- SVN 1.9.3
- Terraform 0.15.4
- zstd 1.5.0 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.77
- AWS CLI 1.19.84
- AWS CLI Session manager plugin 1.2.54.0
- AWS SAM CLI 1.23.0
- Azure CLI (azure-cli) 2.24.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.10.3
- Google Cloud SDK 342.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 3.32.5
- OpenShift CLI 4.7.12
- ORAS CLI 0.11.1
- Vercel CLI 23.0.0

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.292+1 (default) | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 11.0.11+9           | Adopt OpenJDK | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK | JAVA_HOME_12_X64     |

### PHP
| Tool     | Version                                         |
| -------- | ----------------------------------------------- |
| PHP      | 5.6.40 7.0.33 7.1.33 7.2.34 7.3.28 7.4.18 8.0.5 |
| Composer | 2.0.14                                          |
| PHPUnit  | 8.5.15                                          |

### Haskell
- Cabal 3.4.0.0
- GHC 9.0.1 (apt source repository: ppa:hvr/ghc)
- GHCup 0.1.14.1
- Stack 2.7.1

### Rust Tools
- Cargo 1.52.0
- Rust 1.52.1
- Rustdoc 1.52.1
- Rustup 1.24.2

#### Packages
- Bindgen 0.58.1
- Cargo audit 0.14.1
- Cargo clippy 0.1.52
- Cargo outdated 0.9.15
- Cbindgen 0.19.0
- Rustfmt 1.4.36

### Browsers and Drivers
- Google Chrome 91.0.4472.77
- ChromeDriver 91.0.4472.19
- Mozilla Firefox 88.0
- Geckodriver 0.29.1
- Chromium 91.0.4472.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.521 2.1.522 2.1.523 2.1.524 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 2.1.813 2.1.814 2.1.815 2.1.816 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.112 3.1.113 3.1.114 3.1.115 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 3.1.406 3.1.407 3.1.408 3.1.409 5.0.100 5.0.101 5.0.102 5.0.103 5.0.104 5.0.200 5.0.201 5.0.202 5.0.203 5.0.300

### Databases
- MongoDB 4.4.6 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- Postgre SQL 13.3 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
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
#### Go
- 1.13.15
- 1.14.15
- 1.15.12

#### Node.js
- 10.24.1
- 12.22.1
- 14.17.0

#### PyPy
- 2.7.18 [PyPy 7.3.5]
- 3.6.12 [PyPy 7.3.3]

#### Python
- 2.7.18
- 3.5.10
- 3.6.13
- 3.7.10
- 3.8.10
- 3.9.5

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.7
- 2.7.3
- 3.0.1

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_13_X64 | /opt/hostedtoolcache/go/1.13.15/x64 | x64          |
| GOROOT_1_14_X64 | /opt/hostedtoolcache/go/1.14.15/x64 | x64          |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.12/x64 | x64          |

### PowerShell Tools
- PowerShell 7.1.3

#### PowerShell Modules
| Module     | Version |
| ---------- | ------- |
| MarkdownPS | 1.9     |
| Pester     | 5.2.2   |

#### Az PowerShell Modules
- 5.7.0 3.1.0.zip 4.4.0.zip

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.18  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.10.3  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 31.0.2                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-S (rev 4)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                             |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                        |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                              |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                      |
| Google Play services       | 49                                                                                                                                                                                                                                            |
| Google Repository          | 58                                                                                                                                                                                                                                            |
| NDK                        | 21.4.7075529                                                                                                                                                                                                                                  |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                             |

#### Environment variables
| Name             | Value                                                                                |
| ---------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME     | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_ROOT | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag         | Digest                                                                   | Created    |
| ---------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.11            | sha256:18a918a714d1368847b67173d120ebd110fcfae208305412f3005a61cdc7c20e  | 2021-04-14 |
| alpine:3.12            | sha256:36553b10a4947067b9fbb7d532951066293a68eae893beba1d9235f7d11a20ad  | 2021-04-14 |
| alpine:3.13            | sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f  | 2021-04-14 |
| buildpack-deps:buster  | sha256:b4ba9e547bb2e4f48186b234a816ec0182c86fda31f4de5c1eeb824a5d3330df  | 2021-05-12 |
| buildpack-deps:stretch | sha256:fe5d31963e568ba5c418ad26c7c1391ddeedd801672236f081fc3e1e2950e27b  | 2021-05-12 |
| debian:10              | sha256:acf7795dc91df17e10effee064bd229580a9c34213b4dba578d64768af5d8c51  | 2021-05-12 |
| debian:9               | sha256:4f8deed5755299e2d7ae1f5649656de89a6b7e30c0be37a3a1b4a49f0af51f7e  | 2021-05-12 |
| node:10                | sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911  | 2021-04-10 |
| node:10-alpine         | sha256:dc98dac24efd4254f75976c40bce46944697a110d06ce7fa47e7268470cf2e28  | 2021-04-14 |
| node:12                | sha256:0d6b3522991d04ead0b119feaffafa6a8cd1b374218e9f997a1d4753b7064882  | 2021-05-12 |
| node:12-alpine         | sha256:9a372efac4c436dfb6dbdea42f08d3ea60a0103a1df54a7da247e4bed1b327f7  | 2021-04-14 |
| node:14                | sha256:af9879e7473d347048c5d5919aa9775f27c33d92e4d58058ffdc08247f4bd902  | 2021-05-13 |
| node:14-alpine         | sha256:f07ead757c93bc5e9e79978075217851d45a5d8e5c48eaf823e7f12d9bbc1d3c  | 2021-05-13 |
| ubuntu:16.04           | sha256:9775877f420d453ef790e6832d77630a49b32a92b7bedf330adf4d8669f6600e  | 2021-05-19 |
| ubuntu:18.04           | sha256:67b730ece0d34429b455c08124ffd444f021b81e06fa2d9cd0adaf0d0b875182  | 2021-05-19 |
| ubuntu:20.04           | sha256:adf73ca014822ad8237623d388cedf4d5346aa72c270c5acc01431cc93e18e2d  | 2021-04-23 |

### Installed apt packages
| Name              | Version                      |
| ----------------- | ---------------------------- |
| binutils          | 2.26.1-1ubuntu1~16.04.8      |
| bison             | 2:3.0.4.dfsg-1               |
| brotli            | 1.0.3-1ubuntu1~16.04.2       |
| build-essential   | 12.1ubuntu2                  |
| bzip2             | 1.0.6-8ubuntu0.2             |
| coreutils         | 8.25-2ubuntu3~16.04          |
| curl              | 7.47.0-1ubuntu2.19           |
| dbus              | 1.10.6-1ubuntu3.6            |
| dnsutils          | 1:9.10.3.dfsg.P4-8ubuntu1.19 |
| dpkg              | 1.18.4ubuntu1.7              |
| fakeroot          | 1.20.2-1ubuntu1              |
| file              | 1:5.25-2ubuntu1.4            |
| flex              | 2.6.0-11                     |
| ftp               | 0.17-33                      |
| gnupg2            | 2.1.11-6ubuntu2.1            |
| haveged           | 1.9.1-3                      |
| imagemagick       | 8:6.8.9.9-7ubuntu5.16        |
| iproute2          | 4.3.0-1ubuntu3.16.04.5       |
| iputils-ping      | 3:20121221-5ubuntu2          |
| jq                | 1.5+dfsg-1ubuntu0.1          |
| lib32z1           | 1:1.2.8.dfsg-2ubuntu4.3      |
| libc++-dev        | 3.7.0-1ubuntu0.1             |
| libc++abi-dev     | 3.7.0-1ubuntu0.1             |
| libcurl3          | 7.47.0-1ubuntu2.19           |
| libgbm-dev        | 18.0.5-0ubuntu0~16.04.1      |
| libgconf-2-4      | 3.2.6-3ubuntu6               |
| libgsl-dev        | 2.1+dfsg-2                   |
| libgtk-3-0        | 3.18.9-1ubuntu3.3            |
| libicu55          | 55.1-7ubuntu0.5              |
| libmagic-dev      | 1:5.25-2ubuntu1.4            |
| libmagickcore-dev | 8:6.8.9.9-7ubuntu5.16        |
| libmagickwand-dev | 8:6.8.9.9-7ubuntu5.16        |
| libsecret-1-dev   | 0.18.4-1ubuntu2              |
| libsqlite3-dev    | 3.11.0-1ubuntu1.5            |
| libunwind8        | 1.1-4.1                      |
| libxkbfile-dev    | 1:1.0.9-0ubuntu1             |
| libxss1           | 1:1.2.2-1                    |
| locales           | 2.23-0ubuntu11.3             |
| m4                | 1.4.17-5                     |
| mediainfo         | 0.7.82-1                     |
| net-tools         | 1.60-26ubuntu1               |
| netcat            | 1.10-41                      |
| openssh-client    | 1:7.2p2-4ubuntu2.10          |
| p7zip             | 9.20.1~dfsg.1-4.2ubuntu0.1   |
| p7zip-full        | 9.20.1~dfsg.1-4.2ubuntu0.1   |
| p7zip-rar         | 9.20.1~ds.1-4                |
| parallel          | 20161222-1~ubuntu0.16.04.1   |
| pass              | 1.6.5-3                      |
| patchelf          | 0.9-1~ubuntu16.04.3          |
| pkg-config        | 0.29.1-0ubuntu1              |
| pollinate         | 4.33-0ubuntu1~16.04.1        |
| python-setuptools | 20.7.0-1                     |
| rpm               | 4.12.0.1+dfsg1-3build3       |
| rsync             | 3.1.1-3ubuntu1.3             |
| shellcheck        | 0.3.7-5                      |
| sphinxsearch      | 2.2.9-1build1                |
| sqlite3           | 3.11.0-1ubuntu1.5            |
| ssh               | 1:7.2p2-4ubuntu2.10          |
| sshpass           | 1.05-1                       |
| subversion        | 1.9.3-2ubuntu1.3             |
| sudo              | 1.8.16-0ubuntu1.10           |
| swig              | 3.0.8-0ubuntu3               |
| telnet            | 0.17-40                      |
| texinfo           | 6.1.0.dfsg.1-5               |
| time              | 1.7-25.1                     |
| tk                | 8.6.0+9                      |
| tzdata            | 2021a-0ubuntu0.16.04         |
| unzip             | 6.0-20ubuntu1.1              |
| upx               | 3.91-1                       |
| wget              | 1.17.1-1ubuntu1.5            |
| xorriso           | 1.4.2-4ubuntu1               |
| xvfb              | 2:1.18.4-0ubuntu0.12         |
| xz-utils          | 5.1.1alpha+20120614-2ubuntu2 |
| yamllint          | 1.2.1-1                      |
| zip               | 3.0-11                       |
| zsync             | 0.6.2-1ubuntu1               |


