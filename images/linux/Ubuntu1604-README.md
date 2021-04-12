| Announcements |
|-|
| [[Ubuntu] Clang, GCC and Gfortran versions less than 9.x will be removed from images on March, 29](https://github.com/actions/virtual-environments/issues/2950) |
| [[windows, ubuntu] Az, Azure and AzureRM module preinstallation policy will be changed on March, 29th](https://github.com/actions/virtual-environments/issues/2916) |
***
# Ubuntu 16.04.7 LTS
- Linux kernel version: 4.15.0-1111-azure
- Image Version: 20210327.1

## Installed Software
### Language and Runtime
- Bash 4.3.48(1)-release
- Clang 9.0.1
- Erlang 11.1.7
- GNU C++ 5.5.0, 9.3.0
- GNU Fortran 5.5.0, 9.3.0
- Julia 1.6.0
- Mono 6.12.0.122
- Node 14.16.0
- Perl 5.22.1
- Python 2.7.12
- Python3 3.5.2
- Ruby 2.3.1p112
- Swift 5.3.3

### Package Management
- cpan 1.61
- Helm 3.5.3
- Homebrew 3.0.9
- Miniconda 4.9.2
- Npm 6.14.11
- Pip 8.1.1
- Pip3 8.1.1
- RubyGems 2.5.2
- Vcpkg  (build from master \<9f6157a>)
- Yarn 1.22.5

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.9.6
- Gradle 6.8.3
- Maven 3.6.3
- Sbt 1.4.9

### Tools
- 7-Zip 9.20
- Ansible 2.9.19
- apt-fast 1.9.10
- AzCopy 10.9.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.0.0
- Bazelisk 1.7.5
- binutils 2.26.1
- CMake 3.20.0
- CodeQL Action Bundle 2.5.0
- coreutils 8.25
- curl 7.47.0
- Docker Compose 1.28.6
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.5+azure
- Docker-Moby Server 20.10.5+azure
- Git 2.31.1
- Git LFS 2.13.3
- Git-ftp 1.0.2
- Haveged 1.9.1
- Heroku 7.51.0
- HHVM (HipHop VM) 4.56.4
- jq 1.5
- Kind 0.10.0
- Kubectl 1.20.1-5-g76a04fc
- Kustomize 4.0.5
- Leiningen 2.9.5
- m4 1.4.17
- MediaInfo 0.7.82
- Mercurial 4.4.1
- Minikube 1.18.1
- net-tools 1.60
- Newman 5.2.2
- nvm 0.37.2
- OpenSSL 1.0.2g  1 Mar 2016
- Packer 1.7.0
- pass 1.6.5
- PhantomJS 2.1.1
- Pulumi 2.23.2
- R 4.0.4
- Sphinx Open Source Search Server 2.2.9
- SVN 1.9.3
- Swig 3.0.8
- Terraform 0.14.9
- unzip 6.00
- wget 1.17.1
- yamllint 1.2.1
- zip 3.0
- zstd 1.3.1

### CLI Tools
- Alibaba Cloud CLI 3.0.73
- AWS CLI 1.19.39
- AWS CLI Session manager plugin 1.2.54.0
- AWS SAM CLI 1.21.1
- Azure CLI (azure-cli) 2.21.0
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.7.0
- Google Cloud SDK 333.0.0
- Hub CLI 2.14.2
- Netlify CLI 3.13.7
- OpenShift CLI 4.7.3
- ORAS CLI 0.11.1
- Vercel CLI 21.3.3

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.282+8 (default) | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 12.0.2+10           | Adopt OpenJDK | JAVA_HOME_12_X64     |
| 11.0.10+9           | Adopt OpenJDK | JAVA_HOME_11_X64     |

### PHP
| Tool     | Version                                         |
| -------- | ----------------------------------------------- |
| PHP      | 5.6.40 7.0.33 7.1.33 7.2.34 7.3.27 7.4.16 8.0.3 |
| Composer | 2.0.11                                          |
| PHPUnit  | 8.5.15                                          |

### Haskell
- Cabal 3.4.0.0
- GHC 9.0.1
- GHCup 0.1.14
- Stack 2.5.1

### Rust Tools
- Cargo 1.51.0
- Rust 1.51.0
- Rustdoc 1.51.0
- Rustup 1.23.1

#### Packages
- Bindgen 0.57.0
- Cargo audit 0.14.0
- Cargo clippy 0.1.51
- Cargo outdated 0.9.14
- Cbindgen 0.18.0
- Rustfmt 1.4.36

### Browsers and Drivers
- Google Chrome 89.0.4389.90
- ChromeDriver 89.0.4389.23
- Mozilla Firefox 87.0
- Geckodriver 0.29.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.521 2.1.522 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 2.1.813 2.1.814 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.112 3.1.113 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 3.1.406 3.1.407 5.0.100 5.0.101 5.0.102 5.0.103 5.0.104 5.0.200 5.0.201

### Az Module
- 5.5.0 3.1.0.zip 4.4.0.zip

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
#### Go
- 1.13.15
- 1.14.15
- 1.15.10

#### Node.js
- 10.24.0
- 12.21.0
- 14.16.0

#### PyPy
- 2.7.18 [PyPy 7.3.3]
- 3.6.12 [PyPy 7.3.3]

#### Python
- 2.7.18
- 3.5.10
- 3.6.13
- 3.7.10
- 3.8.8
- 3.9.2

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
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.10/x64 | x64          |

### PowerShell Tools
- PowerShell 7.1.3

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
| Package Name               | Version                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 3.0                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 31.0.1                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-S (rev 2)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                             |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                        |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                        |
| CMake                      | 3.10.2                                                                                                                                                                                                                                        |
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
| alpine:3.10            | sha256:f2fa517acf6123318bc893c411f34570cea193367b33bd3be1d90c7fbefe72a5  | 2021-03-25 |
| alpine:3.7             | sha256:8421d9a84432575381bfabd248f1eb56f3aa21d9d7cd2511583c68c9b7511d10  | 2019-03-07 |
| alpine:3.8             | sha256:2bb501e6173d9d006e56de5bce2720eb06396803300fe1687b58a7ff32bf4c14  | 2020-01-23 |
| alpine:3.9             | sha256:414e0518bb9228d35e4cd5165567fb91d26c6a214e9c95899e1e056fcd349011  | 2020-04-24 |
| buildpack-deps:buster  | sha256:ff6c309ddf5b2021da0f1bbdde5020be3840113058c50863fc05ba840c4db4b3  | 2021-03-27 |
| buildpack-deps:stretch | sha256:74e5ae35428c523829353a156f34e44e3d9047d97eeb44cff883d7a654214064  | 2021-03-27 |
| debian:8               | sha256:32ad5050caffb2c7e969dac873bce2c370015c2256ff984b70c1c08b3a2816a0  | 2021-03-26 |
| debian:9               | sha256:20fb077345a1c2447b5746ffa3c9623a8eb87c15e8543e2e48387a7224366d88  | 2021-03-26 |
| node:10                | sha256:c102472f61dc2ced4fa974ac7a4ef43ba801dd7221c612c69db086265489803f  | 2021-03-12 |
| node:10-alpine         | sha256:999c6a67a36b8a682491124ddd49ff6585bd61d7c1d150ff2ce088d668250d4f  | 2021-03-25 |
| node:12                | sha256:a6b801a76c4bcbce39cf94bf2005d54ebdab4984ffdda335a46679c80fa6f54e  | 2021-03-12 |
| node:12-alpine         | sha256:b1b260826bea495c02f35228b37e7b63e50dffc9fca4f9c9a532787a5de978ea  | 2021-03-25 |
| ubuntu:14.04           | sha256:4a8a6fa8810a3e01352981b35165b0b28403fe2a4e2535e315b23b4a69cd130a  | 2021-03-25 |

### Installed apt packages
| Name              | Version                      |
| ----------------- | ---------------------------- |
| binutils          | 2.26.1-1ubuntu1~16.04.8      |
| bison             | 2:3.0.4.dfsg-1               |
| brotli            | 1.0.3-1ubuntu1~16.04.2       |
| build-essential   | 12.1ubuntu2                  |
| bzip2             | 1.0.6-8ubuntu0.2             |
| coreutils         | 8.25-2ubuntu3~16.04          |
| curl              | 7.47.0-1ubuntu2.18           |
| dbus              | 1.10.6-1ubuntu3.6            |
| dnsutils          | 1:9.10.3.dfsg.P4-8ubuntu1.18 |
| dpkg              | 1.18.4ubuntu1.6              |
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
| libcurl3          | 7.47.0-1ubuntu2.18           |
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
| locales           | 2.23-0ubuntu11.2             |
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
| rpm               | 4.12.0.1+dfsg1-3build3       |
| rsync             | 3.1.1-3ubuntu1.3             |
| shellcheck        | 0.3.7-5                      |
| sphinxsearch      | 2.2.9-1build1                |
| sqlite3           | 3.11.0-1ubuntu1.5            |
| ssh               | 1:7.2p2-4ubuntu2.10          |
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
| xvfb              | 2:1.18.4-0ubuntu0.11         |
| xz-utils          | 5.1.1alpha+20120614-2ubuntu2 |
| yamllint          | 1.2.1-1                      |
| zip               | 3.0-11                       |
| zstd              | 1.3.1+dfsg-1~ubuntu0.16.04.1 |
| zsync             | 0.6.2-1ubuntu1               |


