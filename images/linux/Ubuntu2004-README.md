| Announcements |
|-|
| [[Ubuntu] .NET SDK pre-installation policy will be changed on June 14](https://github.com/actions/virtual-environments/issues/3338) |
| [Ubuntu 16.04 environment will be removed on September 20, 2021](https://github.com/actions/virtual-environments/issues/3287) |
***
# Ubuntu 20.04.2 LTS
- Linux kernel version: 5.8.0-1033-azure
- Image Version: 20210606.1

## Installed Software
### Language and Runtime
- Bash 5.0.17(1)-release
- Clang 10.0.0, 11.0.0, 12.0.1
- Clang-format 10.0.0, 11.0.0, 12.0.1
- Erlang 24.0.2 (Eshell 12.0.2)
- Erlang rebar3 3.16.1
- GNU C++ 9.3.0, 10.2.0
- GNU Fortran 9.3.0, 10.2.0
- Julia 1.6.1
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-focal main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 14.17.0
- Perl 5.30.0
- Python 3.8.5
- Python3 3.8.5
- Ruby 2.7.0p0
- Swift 5.4.1

### Package Management
- cpan 1.64
- Helm 3.6.0
- Homebrew 3.1.9
- Miniconda 4.9.2
- Npm 6.14.13
- Pip 20.0.2
- Pip3 20.0.2
- Pipx 0.16.3
- RubyGems 3.1.2
- Vcpkg  (build from master \<b2544fd>)
- Yarn 1.22.10

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.7
- Gradle 7.0.2
- Lerna 4.0.0
- Maven 3.8.1
- Sbt 1.5.3

### Tools
- Ansible 2.10.10
- apt-fast 1.9.11
- AzCopy 10.10.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 4.1.0
- Bazelisk 1.9.0
- Buildah 1.21.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.20.3
- CodeQL Action Bundle 2.5.5
- Docker Compose 1.29.2
- Docker-Buildx 0.5.1
- Docker-Moby Client 20.10.6+azure
- Docker-Moby Server 20.10.6+azure
- Fastlane 2.185.0
- Git 2.31.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 2.13.3 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.6.0
- Haveged 1.9.1
- Heroku 7.54.0
- HHVM (HipHop VM) 4.112.0
- jq 1.6
- Kind 0.11.1
- Kubectl 1.20.1-5-g76a04fc
- Kustomize 4.1.3
- Leiningen 2.9.6
- MediaInfo 19.09
- Mercurial 5.3.1
- Minikube 1.20.0
- Newman 5.2.3
- nvm 0.38.0
- OpenSSL 1.1.1f  31 Mar 2020
- Packer 1.7.2
- PhantomJS 2.1.1
- Podman 3.1.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.4.0
- R 4.1.0
- Skopeo 1.2.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.13.0
- Terraform 0.15.5
- yamllint 1.26.1
- zstd 1.5.0 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.79
- AWS CLI 2.2.9
- AWS CLI Session manager plugin 1.2.54.0
- AWS SAM CLI 1.24.0
- Azure CLI (azure-cli) 2.24.2 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.18.0
- GitHub CLI 1.11.0
- Google Cloud SDK 343.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 3.35.1
- OpenShift CLI 4.7.13
- ORAS CLI 0.12.0
- Vercel CLI 23.0.0

### Java
| Version             | Vendor        | Environment Variable |
| ------------------- | ------------- | -------------------- |
| 8.0.292+1           | Adopt OpenJDK | JAVA_HOME_8_X64      |
| 11.0.11+9 (default) | Adopt OpenJDK | JAVA_HOME_11_X64     |

### GraalVM
| Version   | Environment variables |
| --------- | --------------------- |
| CE 21.1.0 | GRAALVM_11_ROOT       |

### PHP
| Tool     | Version      |
| -------- | ------------ |
| PHP      | 7.4.20 8.0.7 |
| Composer | 2.1.1        |
| PHPUnit  | 8.5.16       |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
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
- Mozilla Firefox 89.0
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
- sqlite3 3.31.1

#### MySQL
- MySQL 8.0.25
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.7.0001.1

### Cached Tools
#### Go
- 1.14.15
- 1.15.13
- 1.16.5

#### Node.js
- 10.24.1
- 12.22.1
- 14.17.0

#### PyPy
- 2.7.18 [PyPy 7.3.5]
- 3.6.12 [PyPy 7.3.3]
- 3.7.10 [PyPy 7.3.5]

#### Python
- 2.7.18
- 3.5.10
- 3.6.13
- 3.7.10
- 3.8.10
- 3.9.5

#### Ruby
- 2.5.9
- 2.6.7
- 2.7.3
- 3.0.1

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_14_X64 | /opt/hostedtoolcache/go/1.14.15/x64 | x64          |
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.13/x64 | x64          |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.5/x64  | x64          |

### PowerShell Tools
- PowerShell 7.1.3

#### PowerShell Modules
| Module           | Version |
| ---------------- | ------- |
| MarkdownPS       | 1.9     |
| Pester           | 5.2.2   |
| PSScriptAnalyzer | 1.19.1  |

#### Az PowerShell Modules
- 5.7.0 3.1.0.zip 4.4.0.zip

### Web Servers
| Name      | Version | ConfigFile                | ServiceStatus | ListenPort |
| --------- | ------- | ------------------------- | ------------- | ---------- |
| apache2   | 2.4.41  | /etc/apache2/apache2.conf | inactive      | 80         |
| mono-xsp4 | 4.7.1   | /etc/default/mono-xsp4    | active        | 8084       |
| nginx     | 1.18.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                  |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| Android Command Line Tools | 4.0                                                                                                                      |
| Android SDK Build-tools    | 30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3 |
| Android SDK Platform-Tools | 31.0.2                                                                                                                   |
| Android SDK Platforms      | android-S (rev 4)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)                |
| Android SDK Tools          | 26.1.1                                                                                                                   |
| Android Support Repository | 47.0.0                                                                                                                   |
| CMake                      | 3.10.2<br>3.18.1                                                                                                         |
| Google Play services       | 49                                                                                                                       |
| Google Repository          | 58                                                                                                                       |
| NDK                        | 21.4.7075529<br>22.1.7171670                                                                                             |
| SDK Patch Applier v4       | 1                                                                                                                        |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/22.1.7171670                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

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
| Name                   | Version                           |
| ---------------------- | --------------------------------- |
| acl                    | 2.2.53-6                          |
| binutils               | 2.34-6ubuntu1.1                   |
| bison                  | 2:3.5.1+dfsg-1                    |
| brotli                 | 1.0.7-6ubuntu0.1                  |
| build-essential        | 12.8ubuntu1.1                     |
| bzip2                  | 1.0.8-2                           |
| coreutils              | 8.30-3ubuntu2                     |
| curl                   | 7.68.0-1ubuntu2.5                 |
| dbus                   | 1.12.16-2ubuntu2.1                |
| dnsutils               | 1:9.16.1-0ubuntu2.8               |
| dpkg                   | 1.19.7ubuntu3                     |
| fakeroot               | 1.24-1                            |
| file                   | 1:5.38-4                          |
| flex                   | 2.6.4-6.2                         |
| fonts-noto-color-emoji | 0~20200916-1~ubuntu20.04.1        |
| ftp                    | 0.17-34.1                         |
| gnupg2                 | 2.2.19-3ubuntu2.1                 |
| haveged                | 1.9.1-6ubuntu1                    |
| imagemagick            | 8:6.9.10.23+dfsg-2.1ubuntu11.2    |
| iproute2               | 5.5.0-1ubuntu1                    |
| iputils-ping           | 3:20190709-3                      |
| jq                     | 1.6-1ubuntu0.20.04.1              |
| lib32z1                | 1:1.2.11.dfsg-2ubuntu1.2          |
| libc++-dev             | 1:10.0-50~exp1                    |
| libc++abi-dev          | 1:10.0-50~exp1                    |
| libcurl4               | 7.68.0-1ubuntu2.5                 |
| libgbm-dev             | 20.2.6-0ubuntu0.20.04.1           |
| libgconf-2-4           | 3.2.6-6ubuntu1                    |
| libgsl-dev             | 2.5+dfsg-6build1                  |
| libgtk-3-0             | 3.24.20-0ubuntu1                  |
| libmagic-dev           | 1:5.38-4                          |
| libmagickcore-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.2    |
| libmagickwand-dev      | 8:6.9.10.23+dfsg-2.1ubuntu11.2    |
| libsecret-1-dev        | 0.20.3-0ubuntu1                   |
| libsqlite3-dev         | 3.31.1-4ubuntu0.2                 |
| libunwind8             | 1.2.1-9build1                     |
| libxkbfile-dev         | 1:1.1.0-1                         |
| libxss1                | 1:1.2.3-1                         |
| locales                | 2.31-0ubuntu9.2                   |
| m4                     | 1.4.18-4                          |
| mediainfo              | 19.09-1build1                     |
| net-tools              | 1.60+git20180626.aebd88e-1ubuntu1 |
| netcat                 | 1.206-1ubuntu1                    |
| openssh-client         | 1:8.2p1-4ubuntu0.2                |
| p7zip-full             | 16.02+dfsg-7build1                |
| p7zip-rar              | 16.02-3build1                     |
| parallel               | 20161222-1.1                      |
| pass                   | 1.7.3-2                           |
| patchelf               | 0.10-2build1                      |
| pkg-config             | 0.29.1-0ubuntu4                   |
| pollinate              | 4.33-3ubuntu1.20.04.1             |
| python-is-python3      | 3.8.2-4                           |
| rpm                    | 4.14.2.1+dfsg1-1build2            |
| rsync                  | 3.1.3-8                           |
| shellcheck             | 0.7.0-2build2                     |
| sphinxsearch           | 2.2.11-2ubuntu2                   |
| sqlite3                | 3.31.1-4ubuntu0.2                 |
| ssh                    | 1:8.2p1-4ubuntu0.2                |
| sshpass                | 1.06-1                            |
| subversion             | 1.13.0-3                          |
| sudo                   | 1.8.31-1ubuntu1.2                 |
| swig                   | 4.0.1-5build1                     |
| telnet                 | 0.17-41.2build1                   |
| texinfo                | 6.7.0.dfsg.2-5                    |
| time                   | 1.7-25.1build1                    |
| tk                     | 8.6.9+1                           |
| tzdata                 | 2021a-0ubuntu0.20.04              |
| unzip                  | 6.0-25ubuntu1                     |
| upx                    | 3.95-2build1                      |
| wget                   | 1.20.3-1ubuntu1                   |
| xorriso                | 1.5.2-1                           |
| xvfb                   | 2:1.20.9-2ubuntu1.2~20.04.2       |
| xz-utils               | 5.2.4-1ubuntu1                    |
| zip                    | 3.0-11build1                      |
| zsync                  | 0.6.2-3ubuntu1                    |


