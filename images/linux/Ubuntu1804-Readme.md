| Announcements |
|-|
| [[Ubuntu] PHP 7.1 will be removed from Ubuntu 18 on April, 18](https://github.com/actions/virtual-environments/issues/5326) |
| [[All OSs] Go versions less than 1.16 will be removed and the default will be set to 1.17 on April, 11](https://github.com/actions/virtual-environments/issues/5280) |
***
# Ubuntu 18.04.6 LTS
- Linux kernel version: 5.4.0-1074-azure
- Image Version: 20220410.2

## Installed Software
### Language and Runtime
- Bash 4.4.20(1)-release
- Clang 9.0.0
- Clang-format 9.0.0
- Erlang 24.3.3 (Eshell 12.3.1)
- Erlang rebar3 3.18.0
- GNU C++ 7.5.0, 9.4.0, 10.3.0
- GNU Fortran 7.5.0, 9.4.0, 10.3.0
- Julia 1.7.2
- Kotlin 1.6.20-release-275
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-bionic main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.14.2
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.6.1

### Package Management
- cpan 1.64
- Helm 3.8.1
- Homebrew 3.4.6
- Miniconda 4.11.0
- Npm 8.5.0
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 1.0.0
- RubyGems 2.7.6
- Vcpkg  (build from master \<f6af75acc>)
- Yarn 1.22.18

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.5
- Gradle 7.4.2
- Maven 3.8.5
- Sbt 1.6.2

### Tools
- Ansible 2.11.10
- apt-fast 1.9.12
- AzCopy 10.14.1 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.1.1
- Bazelisk 1.11.0
- Bicep 0.5.6
- Buildah 1.19.6 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.23.0
- CodeQL Action Bundle 2.8.5
- Docker Compose v1 1.29.2
- Docker Compose v2 2.4.1+azure-1
- Docker-Buildx 0.8.2
- Docker-Moby Client 20.10.14+azure-1
- Docker-Moby Server 20.10.14+azure-1
- Git 2.35.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.1.2 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.60.1
- HHVM (HipHop VM) 4.156.0
- jq 1.5
- Kind 0.12.0
- Kubectl 1.23.5
- Kustomize 4.5.4
- Leiningen 2.9.8
- MediaInfo 17.12
- Mercurial 4.5.3
- Minikube 1.25.2
- n 8.1.0
- Newman 5.3.2
- nvm 0.39.1
- OpenSSL 1.1.1  11 Sep 2018
- Packer 1.8.0
- Parcel 2.4.1
- PhantomJS 2.1.1
- Podman 3.0.1 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.28.0
- R 4.1.3
- Skopeo 1.2.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 1.1.8
- yamllint 1.26.3
- yq 4.24.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.116
- AWS CLI 1.22.92
- AWS CLI Session manager plugin 1.2.312.0
- AWS SAM CLI 1.46.0
- Azure CLI (azure-cli) 2.35.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.7.0
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 9.16.4
- OpenShift CLI 4.10.8
- ORAS CLI 0.12.0
- Vercel CLI 24.0.1

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.322+6 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.14+1           | Eclipse Temurin | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK   | JAVA_HOME_12_X64     |
| 17.0.2+8            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP
| Tool     | Version                                  |
| -------- | ---------------------------------------- |
| PHP      | 7.1.33 7.2.34 7.3.33 7.4.28 8.0.17 8.1.4 |
| Composer | 2.2.9                                    |
| PHPUnit  | 8.5.26                                   |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.2
- GHCup 0.1.17.6
- Stack 2.7.5

### Rust Tools
- Cargo 1.60.0
- Rust 1.60.0
- Rustdoc 1.60.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo audit 0.16.0
- Cargo clippy 0.1.60
- Cargo outdated 
- Cbindgen 0.21.0
- Rustfmt 1.4.38

### Browsers and Drivers
- Google Chrome 100.0.4896.75
- ChromeDriver 100.0.4896.60
- Mozilla Firefox 99.0
- Geckodriver 0.31.0
- Chromium 100.0.4896.0
- Selenium server 4.1.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 3.1.120 3.1.202 3.1.302 3.1.417 5.0.104 5.0.212 5.0.303 5.0.406 6.0.201

### .NET tools
- nbgv 3.4.255+06fb9182bf

### Databases
- MongoDB 5.0.7 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- sqlite3 3.22.0

#### PostgreSQL
- PostgreSQL 14.2 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 5.7.37
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.9.0001.1
- SqlPackage 16.0.5400.1

### Cached Tools
#### Go
- 1.16.15
- 1.17.8
- 1.18.0

#### Node.js
- 12.22.12
- 14.19.1
- 16.14.2

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.6.12 [PyPy 7.3.3]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 2.7.18
- 3.6.15
- 3.7.12
- 3.8.12
- 3.9.12
- 3.10.4

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.9
- 2.7.5
- 3.0.3

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.15/x64 | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.8/x64  | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.0/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.2

#### PowerShell Modules
| Module          | Version |
| --------------- | ------- |
| MarkdownPS      | 1.9     |
| Microsoft.Graph | 1.9.3   |
| Pester          | 5.3.1   |

#### Az PowerShell Modules
- 7.1.0 3.1.0.zip 4.4.0.zip 5.9.0.zip 6.6.0.zip

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.29  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.14.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                           |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                                               |
| Android Emulator           | 31.2.9                                                                                                                                                                                                                                                            |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 33.0.1                                                                                                                                                                                                                                                            |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                          |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                            |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                            |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                                  |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                          |
| Google Play services       | 49                                                                                                                                                                                                                                                                |
| Google Repository          | 58                                                                                                                                                                                                                                                                |
| NDK                        | 21.4.7075529 (default)<br>23.1.7779620                                                                                                                                                                                                                            |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                 |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/23.1.7779620                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.12             | sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69  | 2022-04-05 |
| alpine:3.13             | sha256:ccf92aa53bc6c3b25be2ad0cce80baec1778f007f7e076b0ffbd1b225d0b3a9b  | 2022-04-05 |
| alpine:3.14             | sha256:06b5d462c92fc39303e6363c65e074559f8d6b1363250027ed5053557e3398c5  | 2022-04-05 |
| buildpack-deps:bullseye | sha256:b22e1a6daf16ea7e682e1d813aac528bb027f0772dc819716b4f41fbb06a3ffc  | 2022-03-29 |
| buildpack-deps:buster   | sha256:2c7b57f137d4ec1346ab226acd3eeac4f143ae2adc65a8abbd64489233065773  | 2022-03-29 |
| buildpack-deps:stretch  | sha256:9cee83a572cc5f844548ee5f29eb0284772a162f312d7f049ad178207a0bae6d  | 2022-03-29 |
| debian:10               | sha256:1b236b48c1ef66fa08535a5153266f4959bf58f948db3e68f7d678b651d8e33a  | 2022-03-29 |
| debian:11               | sha256:87eefc7c15610cca61db5c0fd280911c6a737c0680d807432c0bd80cd0cca39b  | 2022-03-29 |
| debian:9                | sha256:a8cc1744bbdd5266678e3e8b3e6387e45c053218438897e86876f2eb104e5534  | 2022-03-29 |
| moby/buildkit:latest    | sha256:bd37f0b5567084cd6f4b1c73b7fed9e12258441d064cc2add29a7dd32243ff86  | 2022-04-07 |
| node:12                 | sha256:461c7f8b5e042fa7f47620cbee7772e76ce3fa0891edaab29bf7ebf0e84b9a1a  | 2022-03-31 |
| node:12-alpine          | sha256:bbc10cf532971046b490806de40f5959fa3bdd0acb82955847bdb0ffd1ab4854  | 2022-04-05 |
| node:14                 | sha256:b2d1c5df5e001b694115f64f4532c7eec2e5dbd73db6e0caacf0049bd0aed7d2  | 2022-03-31 |
| node:14-alpine          | sha256:8845b4f88f64f8c56a39236648ba22946e806a6153c10911f77b70e5a2edb4ca  | 2022-04-05 |
| node:16                 | sha256:ffe804d6fcced29bcfc3477de079d03a9c2b0e4917e44bfeafb1a6b0f875e383  | 2022-03-31 |
| node:16-alpine          | sha256:28bed508446db2ee028d08e76fb47b935defa26a84986ca050d2596ea67fd506  | 2022-04-05 |
| ubuntu:16.04            | sha256:20858ebbc96215d6c3c574f781133ebffdc7c18d98af4f294cc4c04871a6fe61  | 2021-08-31 |
| ubuntu:18.04            | sha256:982d72c16416b09ffd2f71aa381f761422085eda1379dc66b668653607969e38  | 2022-04-05 |
| ubuntu:20.04            | sha256:9101220a875cee98b016668342c489ff0674f247f6ca20dfc91b91c0f28581ae  | 2022-04-05 |

### Installed apt packages
| Name              | Version                           |
| ----------------- | --------------------------------- |
| aria2             | 1.33.1-1                          |
| autoconf          | 2.69-11                           |
| automake          | 1:1.15.1-3ubuntu2                 |
| binutils          | 2.30-21ubuntu1\~18.04.7           |
| bison             | 2:3.0.4.dfsg-1build1              |
| brotli            | 1.0.3-1ubuntu1.3                  |
| build-essential   | 12.4ubuntu1                       |
| bzip2             | 1.0.6-8.1ubuntu0.2                |
| coreutils         | 8.28-1ubuntu1                     |
| curl              | 7.58.0-2ubuntu3.16                |
| dbus              | 1.12.2-1ubuntu1.2                 |
| dnsutils          | 1:9.11.3+dfsg-1ubuntu1.17         |
| dpkg              | 1.19.0.5ubuntu2.3                 |
| fakeroot          | 1.22-2ubuntu1                     |
| file              | 1:5.32-2ubuntu0.4                 |
| flex              | 2.6.4-6                           |
| ftp               | 0.17-34                           |
| gnupg2            | 2.2.4-1ubuntu1.4                  |
| haveged           | 1.9.1-6                           |
| imagemagick       | 8:6.9.7.4+dfsg-16ubuntu6.12       |
| iproute2          | 4.15.0-2ubuntu1.3                 |
| iputils-ping      | 3:20161105-1ubuntu3               |
| jq                | 1.5+dfsg-2                        |
| lib32z1           | 1:1.2.11.dfsg-0ubuntu2.1          |
| libc++-dev        | 6.0-2                             |
| libc++abi-dev     | 6.0-2                             |
| libcurl3          | 7.58.0-2ubuntu3.16                |
| libgbm-dev        | 20.0.8-0ubuntu1\~18.04.1          |
| libgconf-2-4      | 3.2.6-4ubuntu1                    |
| libgsl-dev        | 2.4+dfsg-6                        |
| libgtk-3-0        | 3.22.30-1ubuntu4                  |
| libmagic-dev      | 1:5.32-2ubuntu0.4                 |
| libmagickcore-dev | 8:6.9.7.4+dfsg-16ubuntu6.12       |
| libmagickwand-dev | 8:6.9.7.4+dfsg-16ubuntu6.12       |
| libsecret-1-dev   | 0.18.6-1                          |
| libsqlite3-dev    | 3.22.0-1ubuntu0.4                 |
| libtool           | 2.4.6-2                           |
| libunwind8        | 1.2.1-8                           |
| libxkbfile-dev    | 1:1.0.9-2                         |
| libxss1           | 1:1.2.2-1                         |
| locales           | 2.27-3ubuntu1.5                   |
| m4                | 1.4.18-1                          |
| mediainfo         | 17.12-1                           |
| mercurial         | 4.5.3-1ubuntu2.2                  |
| net-tools         | 1.60+git20161116.90da8a0-1ubuntu1 |
| netcat            | 1.10-41.1                         |
| openssh-client    | 1:7.6p1-4ubuntu0.6                |
| p7zip-full        | 16.02+dfsg-6                      |
| p7zip-rar         | 16.02-2                           |
| parallel          | 20161222-1                        |
| pass              | 1.7.1-3                           |
| patchelf          | 0.9-1                             |
| pkg-config        | 0.29.1-0ubuntu2                   |
| pollinate         | 4.33-0ubuntu1\~18.04.2            |
| python-setuptools | 39.0.1-2                          |
| rpm               | 4.14.1+dfsg1-2                    |
| rsync             | 3.1.2-2.1ubuntu1.4                |
| shellcheck        | 0.4.6-1                           |
| sphinxsearch      | 2.2.11-2                          |
| sqlite3           | 3.22.0-1ubuntu0.4                 |
| ssh               | 1:7.6p1-4ubuntu0.6                |
| sshpass           | 1.06-1                            |
| subversion        | 1.9.7-4ubuntu1                    |
| sudo              | 1.8.21p2-3ubuntu1.4               |
| swig              | 3.0.12-1                          |
| telnet            | 0.17-41                           |
| texinfo           | 6.5.0.dfsg.1-2                    |
| time              | 1.7-25.1build1                    |
| tk                | 8.6.0+9                           |
| tzdata            | 2022a-0ubuntu0.18.04              |
| unzip             | 6.0-21ubuntu1.1                   |
| upx               | 3.94-4                            |
| wget              | 1.19.4-1ubuntu2.2                 |
| xorriso           | 1.4.8-3                           |
| xvfb              | 2:1.19.6-1ubuntu4.10              |
| xz-utils          | 5.2.2-1.3                         |
| zip               | 3.0-11build1                      |
| zsync             | 0.6.2-3ubuntu1                    |


