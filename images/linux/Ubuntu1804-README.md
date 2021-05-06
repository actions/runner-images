| Announcements |
|-|
| [Ubuntu 16.04 environment will be removed on September 20, 2021](https://github.com/actions/virtual-environments/issues/3287) |
| [[ubuntu] Clang 9 will be removed on May, 17th and default will be set to Clang 11](https://github.com/actions/virtual-environments/issues/3235) |
***
# Ubuntu 18.04.5 LTS
- Linux kernel version: 5.4.0-1046-azure
- Image Version: 20210504.1

## Installed Software
### Language and Runtime
- Bash 4.4.20(1)-release
- Clang 9.0.0
- Clang-format 9.0.0
- Erlang 23.3.1 (Eshell 11.2)
- GNU C++ 7.5.0, 9.3.0, 10.3.0
- GNU Fortran 7.5.0, 9.3.0, 10.3.0
- Julia 1.6.1
- Mono 6.12.0.122
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 14.16.1
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.4

### Package Management
- cpan 1.64
- Helm 3.5.4
- Homebrew 3.1.5
- Miniconda 4.9.2
- Npm 6.14.12
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 0.16.2.1
- RubyGems 2.7.6
- Vcpkg  (build from master \<95836f4>)
- Yarn 1.22.10

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.5
- Gradle 7.0
- Maven 3.8.1
- Sbt 1.5.1

### Tools
- Ansible 2.10.9
- apt-fast 1.9.11
- AzCopy 10.10.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.0.0
- Bazelisk 1.8.0
- Buildah 1.19.6 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.20.2
- CodeQL Action Bundle 2.5.4
- Docker Compose 1.29.1
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.6+azure
- Docker-Moby Server 20.10.6+azure
- Git 2.31.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 2.13.3 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.53.0
- HHVM (HipHop VM) 4.107.0
- jq 1.5
- Kind 0.10.0
- Kubectl 1.20.1-5-g76a04fc
- Kustomize 4.1.2
- Leiningen 2.9.6
- MediaInfo 17.12
- Mercurial 4.5.3
- Minikube 1.19.0
- Newman 5.2.3
- nvm 0.38.0
- OpenSSL 1.1.1  11 Sep 2018
- Packer 1.7.2
- PhantomJS 2.1.1
- Podman 3.0.1 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.1.0
- R 4.0.5
- Skopeo 1.2.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 0.15.1
- yamllint 1.26.1
- zstd 1.4.9 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.74
- AWS CLI 1.19.64
- AWS CLI Session manager plugin 1.2.54.0
- AWS SAM CLI 1.23.0
- Azure CLI (azure-cli) 2.22.1
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.9.2
- Google Cloud SDK 338.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 3.25.0
- OpenShift CLI 4.7.8
- ORAS CLI 0.11.1
- Vercel CLI 22.0.1

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.292+1 (default) | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 11.0.11+9           | Adopt OpenJDK | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK | JAVA_HOME_12_X64     |

### PHP
| Tool     | Version                                                                   |
| -------- | ------------------------------------------------------------------------- |
| PHP      | 7.1.33 7.2.34 7.3.28 7.4.18 8.0.5 (apt source repository: ppa:ondrej/php) |
| Composer | 2.0.13                                                                    |
| PHPUnit  | 8.5.15                                                                    |

### Haskell
- Cabal 3.4.0.0
- GHC 9.0.1 (apt source repository: ppa:hvr/ghc)
- GHCup 0.1.14.1
- Stack 2.5.1

### Rust Tools
- Cargo 1.51.0
- Rust 1.51.0
- Rustdoc 1.51.0
- Rustup 1.24.1

#### Packages
- Bindgen 0.58.1
- Cargo audit 0.14.1
- Cargo clippy 0.1.51
- Cargo outdated 0.9.15
- Cbindgen 0.19.0
- Rustfmt 1.4.36

### Browsers and Drivers
- Google Chrome 90.0.4430.93
- ChromeDriver 90.0.4430.24
- Mozilla Firefox 88.0
- Geckodriver 0.29.1
- Chromium 90.0.4430.0

#### Environment variables
| Name            | Value                          |
| --------------- | ------------------------------ |
| CHROMEWEBDRIVER | /usr/local/share/chrome_driver |
| GECKOWEBDRIVER  | /usr/local/share/gecko_driver  |

### .NET Core SDK
- 2.1.300 2.1.301 2.1.302 2.1.401 2.1.402 2.1.403 2.1.500 2.1.502 2.1.503 2.1.504 2.1.505 2.1.506 2.1.507 2.1.508 2.1.509 2.1.510 2.1.511 2.1.512 2.1.513 2.1.514 2.1.515 2.1.516 2.1.517 2.1.518 2.1.519 2.1.520 2.1.521 2.1.522 2.1.523 2.1.602 2.1.603 2.1.604 2.1.605 2.1.606 2.1.607 2.1.608 2.1.609 2.1.610 2.1.611 2.1.612 2.1.613 2.1.614 2.1.615 2.1.616 2.1.617 2.1.700 2.1.701 2.1.801 2.1.802 2.1.803 2.1.804 2.1.805 2.1.806 2.1.807 2.1.808 2.1.809 2.1.810 2.1.811 2.1.812 2.1.813 2.1.814 2.1.815 3.1.100 3.1.101 3.1.102 3.1.103 3.1.104 3.1.105 3.1.106 3.1.107 3.1.108 3.1.109 3.1.110 3.1.111 3.1.112 3.1.113 3.1.114 3.1.200 3.1.201 3.1.202 3.1.300 3.1.301 3.1.302 3.1.401 3.1.402 3.1.403 3.1.404 3.1.405 3.1.406 3.1.407 3.1.408 5.0.100 5.0.101 5.0.102 5.0.103 5.0.104 5.0.200 5.0.201 5.0.202

### Databases
- MongoDB 4.4.5 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- Postgre SQL 13.2 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- sqlite3 3.22.0

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
- 1.15.11

#### Node.js
- 10.24.1
- 12.22.1
- 14.16.1

#### PyPy
- 2.7.18 [PyPy 7.3.4]
- 3.6.12 [PyPy 7.3.3]

#### Python
- 2.7.18
- 3.5.10
- 3.6.13
- 3.7.10
- 3.8.9
- 3.9.4

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
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.11/x64 | x64          |

### PowerShell Tools
- PowerShell 7.1.3

#### PowerShell Modules
| Module     | Version |
| ---------- | ------- |
| MarkdownPS | 1.9     |
| Pester     | 5.1.1   |

#### Az PowerShell Modules
- 5.7.0 3.1.0.zip 4.4.0.zip

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.29  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.14.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                       |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 31.0.2                                                                                                                                                                                                                                        |
| Android SDK Platforms      | android-S (rev 3)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                             |
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
| alpine:3.11            | sha256:18a918a714d1368847b67173d120ebd110fcfae208305412f3005a61cdc7c20e  | 2021-04-14 |
| alpine:3.12            | sha256:36553b10a4947067b9fbb7d532951066293a68eae893beba1d9235f7d11a20ad  | 2021-04-14 |
| alpine:3.13            | sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f  | 2021-04-14 |
| buildpack-deps:buster  | sha256:da41958eb012d10ac2e9764885e02612dd515df1b455900f3eda81d81a574ca3  | 2021-04-10 |
| buildpack-deps:stretch | sha256:ea0e73d4d5c3341e1328b58a69f513067c79fd6effd9776fc2d2f8d46e2f6e78  | 2021-04-10 |
| debian:10              | sha256:ba4a437377a0c450ac9bb634c3754a17b1f814ce6fa3157c0dc9eef431b29d1f  | 2021-04-10 |
| debian:9               | sha256:c0daa8e312c326ac15721712b8a1e68a5039d725ff47bc25c781921089de0a66  | 2021-04-10 |
| node:10                | sha256:59531d2835edd5161c8f9512f9e095b1836f7a1fcb0ab73e005ec46047384911  | 2021-04-10 |
| node:10-alpine         | sha256:dc98dac24efd4254f75976c40bce46944697a110d06ce7fa47e7268470cf2e28  | 2021-04-14 |
| node:12                | sha256:609103746810535f5a3a987a26ba4ce95d96225d28e9d6228faa5aa331980f37  | 2021-04-10 |
| node:12-alpine         | sha256:9923c9efb13cf7535f67e49b03010f0977a800068e4c8e0e2c93433a6bfa1e77  | 2021-04-14 |
| node:14                | sha256:8eb45f4677c813ad08cef8522254640aa6a1800e75a9c213a0a651f6f3564189  | 2021-04-10 |
| node:14-alpine         | sha256:ed51af876dd7932ce5c1e3b16c2e83a3f58419d824e366de1f7b00f40c848c40  | 2021-04-14 |
| ubuntu:16.04           | sha256:eed7e1076bbc1f342c4474c718e5438af4784f59a4e88ad687dbb98483b59ee4  | 2021-04-23 |
| ubuntu:18.04           | sha256:538529c9d229fb55f50e6746b119e899775205d62c0fc1b7e679b30d02ecb6e8  | 2021-04-23 |
| ubuntu:20.04           | sha256:cf31af331f38d1d7158470e095b132acd126a7180a54f263d386da88eb681d93  | 2021-04-23 |

### Installed apt packages
| Name              | Version                           |
| ----------------- | --------------------------------- |
| binutils          | 2.30-21ubuntu1~18.04.5            |
| bison             | 2:3.0.4.dfsg-1build1              |
| brotli            | 1.0.3-1ubuntu1.3                  |
| build-essential   | 12.4ubuntu1                       |
| bzip2             | 1.0.6-8.1ubuntu0.2                |
| coreutils         | 8.28-1ubuntu1                     |
| curl              | 7.58.0-2ubuntu3.13                |
| dbus              | 1.12.2-1ubuntu1.2                 |
| dnsutils          | 1:9.11.3+dfsg-1ubuntu1.15         |
| dpkg              | 1.19.0.5ubuntu2.3                 |
| fakeroot          | 1.22-2ubuntu1                     |
| file              | 1:5.32-2ubuntu0.4                 |
| flex              | 2.6.4-6                           |
| ftp               | 0.17-34                           |
| gnupg2            | 2.2.4-1ubuntu1.4                  |
| haveged           | 1.9.1-6                           |
| imagemagick       | 8:6.9.7.4+dfsg-16ubuntu6.9        |
| iproute2          | 4.15.0-2ubuntu1.3                 |
| iputils-ping      | 3:20161105-1ubuntu3               |
| jq                | 1.5+dfsg-2                        |
| lib32z1           | 1:1.2.11.dfsg-0ubuntu2            |
| libc++-dev        | 6.0-2                             |
| libc++abi-dev     | 6.0-2                             |
| libcurl3          | 7.58.0-2ubuntu3.13                |
| libgbm-dev        | 20.0.8-0ubuntu1~18.04.1           |
| libgconf-2-4      | 3.2.6-4ubuntu1                    |
| libgsl-dev        | 2.4+dfsg-6                        |
| libgtk-3-0        | 3.22.30-1ubuntu4                  |
| libmagic-dev      | 1:5.32-2ubuntu0.4                 |
| libmagickcore-dev | 8:6.9.7.4+dfsg-16ubuntu6.9        |
| libmagickwand-dev | 8:6.9.7.4+dfsg-16ubuntu6.9        |
| libsecret-1-dev   | 0.18.6-1                          |
| libsqlite3-dev    | 3.22.0-1ubuntu0.4                 |
| libunwind8        | 1.2.1-8                           |
| libxkbfile-dev    | 1:1.0.9-2                         |
| libxss1           | 1:1.2.2-1                         |
| locales           | 2.27-3ubuntu1.4                   |
| m4                | 1.4.18-1                          |
| mediainfo         | 17.12-1                           |
| net-tools         | 1.60+git20161116.90da8a0-1ubuntu1 |
| netcat            | 1.10-41.1                         |
| openssh-client    | 1:7.6p1-4ubuntu0.3                |
| p7zip-full        | 16.02+dfsg-6                      |
| p7zip-rar         | 16.02-2                           |
| parallel          | 20161222-1                        |
| pass              | 1.7.1-3                           |
| patchelf          | 0.9-1                             |
| pkg-config        | 0.29.1-0ubuntu2                   |
| pollinate         | 4.33-0ubuntu1~18.04.2             |
| python-setuptools | 39.0.1-2                          |
| rpm               | 4.14.1+dfsg1-2                    |
| rsync             | 3.1.2-2.1ubuntu1.1                |
| shellcheck        | 0.4.6-1                           |
| sphinxsearch      | 2.2.11-2                          |
| sqlite3           | 3.22.0-1ubuntu0.4                 |
| ssh               | 1:7.6p1-4ubuntu0.3                |
| sshpass           | 1.06-1                            |
| subversion        | 1.9.7-4ubuntu1                    |
| sudo              | 1.8.21p2-3ubuntu1.4               |
| swig              | 3.0.12-1                          |
| telnet            | 0.17-41                           |
| texinfo           | 6.5.0.dfsg.1-2                    |
| time              | 1.7-25.1build1                    |
| tk                | 8.6.0+9                           |
| tzdata            | 2021a-0ubuntu0.18.04              |
| unzip             | 6.0-21ubuntu1.1                   |
| upx               | 3.94-4                            |
| wget              | 1.19.4-1ubuntu2.2                 |
| xorriso           | 1.4.8-3                           |
| xvfb              | 2:1.19.6-1ubuntu4.9               |
| xz-utils          | 5.2.2-1.3                         |
| zip               | 3.0-11build1                      |
| zsync             | 0.6.2-3ubuntu1                    |


