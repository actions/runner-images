| Announcements |
|-|
| [[All OSs] Go versions less than 1.16 will be removed on April, 11](https://github.com/actions/virtual-environments/issues/5280) |
| [[Ubuntu] Issue with libstdc++ cannot allocate memory in static TLS block](https://github.com/actions/virtual-environments/issues/4799) |
***
# Ubuntu 18.04.6 LTS
- Linux kernel version: 5.4.0-1073-azure
- Image Version: 20220330.0

## Installed Software
### Language and Runtime
- Bash 4.4.20(1)-release
- Clang 9.0.0
- Clang-format 9.0.0
- Erlang 24.3.2 (Eshell 12.3)
- Erlang rebar3 3.18.0
- GNU C++ 7.5.0, 9.4.0, 10.3.0
- GNU Fortran 7.5.0, 9.4.0, 10.3.0
- Julia 1.7.2
- Kotlin 1.6.10-release-923
- Mono 6.12.0.122 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-bionic main)
- MSBuild 16.6.0.15201 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.14.2
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.6

### Package Management
- cpan 1.64
- Helm 3.8.1
- Homebrew 3.4.4
- Miniconda 4.11.0
- Npm 8.5.0
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 1.0.0
- RubyGems 2.7.6
- Vcpkg  (build from master \<4f778cf09>)
- Yarn 1.22.18

#### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| CONDA                   | /usr/share/miniconda   |
| VCPKG_INSTALLATION_ROOT | /usr/local/share/vcpkg |

### Project Management
- Ant 1.10.5
- Gradle 7.4.1
- Maven 3.8.5
- Sbt 1.6.2

### Tools
- Ansible 2.11.10
- apt-fast 1.9.12
- AzCopy 10.14.1 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.1.0
- Bazelisk 1.11.0
- Bicep 0.4.1318
- Buildah 1.19.6 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.23.0
- CodeQL Action Bundle 2.8.3
- Docker Compose v1 1.29.2
- Docker Compose v2 2.2.3+azure-1
- Docker-Buildx 0.8.1
- Docker-Moby Client 20.10.14+azure-1
- Docker-Moby Server 20.10.14+azure-1
- Git 2.35.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.1.2 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.59.4
- HHVM (HipHop VM) 4.154.1
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
- Parcel 2.4.0
- PhantomJS 2.1.1
- Podman 3.0.1 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.27.0
- R 4.1.3
- Skopeo 1.2.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 1.1.7
- yamllint 1.26.3
- yq 4.24.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.114
- AWS CLI 1.22.84
- AWS CLI Session manager plugin 1.2.295.0
- AWS SAM CLI 1.43.0
- Azure CLI (azure-cli) 2.34.1 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.6.0
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 9.13.6
- OpenShift CLI 4.10.6
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
| PHP      | 7.1.33 7.2.34 7.3.33 7.4.28 8.0.17 8.1.3 |
| Composer | 2.2.10                                   |
| PHPUnit  | 8.5.25                                   |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.2
- GHCup 0.1.17.6
- Stack 2.7.5

### Rust Tools
- Cargo 1.59.0
- Rust 1.59.0
- Rustdoc 1.59.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo audit 0.16.0
- Cargo clippy 0.1.59
- Cargo outdated 
- Cbindgen 0.21.0
- Rustfmt 1.4.38

### Browsers and Drivers
- Google Chrome 100.0.4896.60
- ChromeDriver 100.0.4896.60
- Mozilla Firefox 98.0.2
- Geckodriver 0.30.0
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
- MongoDB 5.0.6 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
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
- 1.15.15
- 1.16.15
- 1.17.8
- 1.18.0

#### Node.js
- 12.22.11
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
| GOROOT_1_15_X64 | /opt/hostedtoolcache/go/1.15.15/x64 | x64          |
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
| alpine:3.12             | sha256:e42c1b8e03bdaa471deb198d981b52ac421441975195a20004aea624890f8b1c  | 2022-03-29 |
| alpine:3.13             | sha256:6b6249407a7901591e094262327b79de21f2bfb9f597866f0a2bbb3b3d98e00c  | 2022-03-29 |
| alpine:3.14             | sha256:85c63ff404e9b4daf18f264447161b50ffa70047cc4c03381478cf2c6edfa9da  | 2022-03-29 |
| buildpack-deps:bullseye | sha256:95d2b7161b408f8b6941489d1000fc6348d6d358eb71c31fdf835575a5c120e9  | 2022-03-29 |
| buildpack-deps:buster   | sha256:985480f24616ea7e388136cc5f1412c2ffba5e6cf38bd647859ad63f3d8ac16a  | 2022-03-29 |
| buildpack-deps:stretch  | sha256:b4087d6c971248c3eb86ee7f06b71b3cd20c7b721807dc1ebe83ba7dce76c500  | 2022-03-29 |
| debian:10               | sha256:1b236b48c1ef66fa08535a5153266f4959bf58f948db3e68f7d678b651d8e33a  | 2022-03-29 |
| debian:11               | sha256:87eefc7c15610cca61db5c0fd280911c6a737c0680d807432c0bd80cd0cca39b  | 2022-03-29 |
| debian:9                | sha256:a8cc1744bbdd5266678e3e8b3e6387e45c053218438897e86876f2eb104e5534  | 2022-03-29 |
| moby/buildkit:latest    | sha256:c2aeafaed434edfde90706b5cf9a56935c389192858d1090e17a1440a6e96482  | 2022-03-09 |
| node:12                 | sha256:e88281f7b3947019c8b5fe750a06122ac3c2612fe00719a133ea5bf8bfedafbb  | 2022-03-18 |
| node:12-alpine          | sha256:41a1b6dd829a9a1b3da8817809c3ddf5e97c8bc66cbc84363f697e31c0adab4b  | 2022-03-29 |
| node:14                 | sha256:7d38b5ed42b2ac006c3a79ef8ad9f1e912bde6cb4cb4243c188689d5aa1aa437  | 2022-03-18 |
| node:14-alpine          | sha256:d9e58586730f7eb7c885f515f703f4a88e4a3ad8bf982aa5bb4ab6a1111aed79  | 2022-03-29 |
| node:16                 | sha256:68e34cfcd8276ad531b12b3454af5c24cd028752dfccacce4e19efef6f7cdbe0  | 2022-03-18 |
| node:16-alpine          | sha256:51542061b77f105c2db658035ac6070229f9ea1d3270ab78775df9a825d9a759  | 2022-03-29 |
| ubuntu:16.04            | sha256:0f71fa8d4d2d4292c3c617fda2b36f6dabe5c8b6e34c3dc5b0d17d4e704bd39c  | 2021-08-31 |
| ubuntu:18.04            | sha256:d8ac28b7bec51664c6b71a9dd1d8f788127ff310b8af30820560973bcfc605a0  | 2022-03-18 |
| ubuntu:20.04            | sha256:bea6d19168bbfd6af8d77c2cc3c572114eb5d113e6f422573c93cb605a0e2ffb  | 2022-03-18 |

### Installed apt packages
| Name              | Version                           |
| ----------------- | --------------------------------- |
| aria2             | 1.33.1-1                          |
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
| lib32z1           | 1:1.2.11.dfsg-0ubuntu2            |
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
| rsync             | 3.1.2-2.1ubuntu1.3                |
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


