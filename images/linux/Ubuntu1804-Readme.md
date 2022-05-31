| Announcements |
|-|
| [[all OSs] Android NDK 22 will be replaced in favor of 24, version 23 will be set as the default one on June, 6](https://github.com/actions/virtual-environments/issues/5595) |
| [(Public Beta) Ubuntu 22.04 is now available](https://github.com/actions/virtual-environments/issues/5490) |
***
# Ubuntu 18.04.6 LTS
- Linux kernel version: 5.4.0-1080-azure
- Image Version: 20220529.1

## Installed Software
### Language and Runtime
- Bash 4.4.20(1)-release
- Clang 9.0.0
- Clang-format 9.0.0
- Clang-tidy 9.0.0
- Erlang 25.0 (Eshell 13.0)
- Erlang rebar3 3.18.0
- GNU C++ 7.5.0, 9.4.0, 10.3.0
- GNU Fortran 7.5.0, 9.4.0, 10.3.0
- Julia 1.7.3
- Kotlin 1.6.21-release-334
- Mono 6.12.0.179 (apt source repository: https://download.mono-project.com/repo/ubuntu stable-bionic main)
- MSBuild 16.10.1.31701 (from /usr/lib/mono/msbuild/15.0/bin/MSBuild.dll)
- Node 16.15.0
- Perl 5.26.1
- Python 2.7.17
- Python3 3.6.9
- Ruby 2.5.1p57
- Swift 5.6.1

### Package Management
- cpan 1.64
- Helm 3.9.0
- Homebrew 3.4.11
- Miniconda 4.12.0
- Npm 8.5.5
- Pip 9.0.1
- Pip3 9.0.1
- Pipx 1.0.0
- RubyGems 2.7.6
- Vcpkg  (build from master \<d953973cf>)
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
- Ansible 2.11.12
- apt-fast 1.9.12
- AzCopy 10.15.0 (available by `azcopy` and `azcopy10` aliases)
- Bazel 5.1.1
- Bazelisk 1.11.0
- Bicep 0.6.18
- Buildah 1.22.3 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- CMake 3.23.2
- CodeQL Action Bundle 2.9.2
- Docker Amazon ECR Credential Helper 0.6.0
- Docker Compose v1 1.29.2
- Docker Compose v2 2.4.1+azure-1
- Docker-Buildx 0.8.2
- Docker-Moby Client 20.10.16+azure-3
- Docker-Moby Server 20.10.16+azure-2
- Git 2.36.1 (apt source repository: ppa:git-core/ppa)
- Git LFS 3.2.0 (apt source repository: https://packagecloud.io/install/repositories/github/git-lfs)
- Git-ftp 1.3.1
- Haveged 1.9.1
- Heroku 7.60.2
- HHVM (HipHop VM) 4.160.0
- jq 1.5
- Kind 0.14.0
- Kubectl 1.24.1
- Kustomize 4.5.5
- Leiningen 2.9.8
- MediaInfo 17.12
- Mercurial 4.5.3
- Minikube 1.25.2
- n 8.2.0
- Newman 5.3.2
- nvm 0.39.1
- OpenSSL 1.1.1-1ubuntu2.1~18.04.17
- Packer 1.8.1
- Parcel 2.6.0
- PhantomJS 2.1.1
- Podman 3.4.2 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Pulumi 3.33.2
- R 4.2.0
- Skopeo 1.5.0 (apt source repository: https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable)
- Sphinx Open Source Search Server 2.2.11
- SVN 1.9.7
- Terraform 1.2.1
- yamllint 1.26.3
- yq 4.25.2
- zstd 1.5.2 (homebrew)

### CLI Tools
- Alibaba Cloud CLI 3.0.121
- AWS CLI 1.24.10
- AWS CLI Session manager plugin 1.2.331.0
- AWS SAM CLI 1.50.0
- Azure CLI (azure-cli) 2.37.0 (installation method: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt)
- Azure CLI (azure-devops) 0.25.0
- GitHub CLI 2.11.3
- Google Cloud SDK 369.0.0 (apt source repository: https://packages.cloud.google.com/apt)
- Hub CLI 2.14.2
- Netlify CLI 10.3.3
- OpenShift CLI 4.10.15
- ORAS CLI 0.12.0
- Vercel CLI 24.2.4

### Java
| Version             | Vendor          | Environment Variable |
| ------------------- | --------------- | -------------------- |
| 8.0.332+9 (default) | Eclipse Temurin | JAVA_HOME_8_X64      |
| 11.0.15+10          | Eclipse Temurin | JAVA_HOME_11_X64     |
| 12.0.2+10           | Adopt OpenJDK   | JAVA_HOME_12_X64     |
| 17.0.3+7            | Eclipse Temurin | JAVA_HOME_17_X64     |

### PHP
| Tool     | Version                     |
| -------- | --------------------------- |
| PHP      | 7.2.34 7.3.33 7.4.29 8.0.19 8.1.6 |
| Composer | 2.3.5                       |
| PHPUnit  | 8.5.26                      |
```
    Both Xdebug and PCOV extensions are installed, but only Xdebug is enabled.
```
### Haskell
- Cabal 3.6.2.0
- GHC 9.2.3
- GHCup 0.1.17.8
- Stack 2.7.5

### Rust Tools
- Cargo 1.61.0
- Rust 1.61.0
- Rustdoc 1.61.0
- Rustup 1.24.3

#### Packages
- Bindgen 0.59.2
- Cargo audit 0.17.0
- Cargo clippy 0.1.61
- Cargo outdated 0.11.1
- Cbindgen 0.23.0
- Rustfmt 1.4.38

### Browsers and Drivers
- Google Chrome 102.0.5005.61
- ChromeDriver 102.0.5005.61
- Chromium 102.0.5005.0
- Selenium server 4.2.0
- Mozilla Firefox 100.0.2
- Geckodriver 0.31.0

#### Environment variables
| Name              | Value                               |
| ----------------- | ----------------------------------- |
| CHROMEWEBDRIVER   | /usr/local/share/chrome_driver      |
| GECKOWEBDRIVER    | /usr/local/share/gecko_driver       |
| SELENIUM_JAR_PATH | /usr/share/java/selenium-server.jar |

### .NET Core SDK
- 3.1.120 3.1.202 3.1.302 3.1.419 5.0.104 5.0.214 5.0.303 5.0.408 6.0.300

### .NET tools
- nbgv 3.5.107+6463ef6068

### Databases
- MongoDB 5.0.8 (apt source repository: https://repo.mongodb.org/apt/ubuntu)
- sqlite3 3.22.0

#### PostgreSQL
- PostgreSQL 14.3 (apt source repository: https://apt.postgresql.org/pub/repos/apt/)
- PostgreSQL Server (user:postgres)

```
    PostgreSQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start postgresql.service'
```
#### MySQL
- MySQL 5.7.38
- MySQL Server (user:root password:root)

```
    MySQL service is disabled by default. Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
#### MS SQL Server Client Tools
- sqlcmd 17.9.0001.1
- SqlPackage 16.0.6161.0

### Cached Tools
#### Go
- 1.16.15
- 1.17.10
- 1.18.2

#### Node.js
- 12.22.12
- 14.19.3
- 16.15.0

#### PyPy
- 2.7.18 [PyPy 7.3.9]
- 3.6.12 [PyPy 7.3.3]
- 3.9.12 [PyPy 7.3.9]

#### Python
- 2.7.18
- 3.6.15
- 3.7.13
- 3.8.12
- 3.9.13
- 3.10.4

#### Ruby
- 2.4.10
- 2.5.9
- 2.6.10
- 2.7.6
- 3.0.4
- 3.1.2

#### Environment variables
| Name            | Value                               | Architecture |
| --------------- | ----------------------------------- | ------------ |
| GOROOT_1_16_X64 | /opt/hostedtoolcache/go/1.16.15/x64 | x64          |
| GOROOT_1_17_X64 | /opt/hostedtoolcache/go/1.17.10/x64 | x64          |
| GOROOT_1_18_X64 | /opt/hostedtoolcache/go/1.18.2/x64  | x64          |

### PowerShell Tools
- PowerShell 7.2.4

#### PowerShell Modules
| Module          | Version |
| --------------- | ------- |
| MarkdownPS      | 1.9     |
| Microsoft.Graph | 1.9.6   |
| Pester          | 5.3.3   |

#### Az PowerShell Modules
- 7.3.2 3.1.0.zip 4.4.0.zip 5.9.0.zip 6.6.0.zip

### Web Servers
| Name    | Version | ConfigFile                | ServiceStatus | ListenPort |
| ------- | ------- | ------------------------- | ------------- | ---------- |
| apache2 | 2.4.29  | /etc/apache2/apache2.conf | inactive      | 80         |
| nginx   | 1.14.0  | /etc/nginx/nginx.conf     | inactive      | 80         |

### Android
| Package Name               | Version                                                                                                                                                                                                                                                           |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Android Command Line Tools | 4.0                                                                                                                                                                                                                                                               |
| Android Emulator           | 31.2.10                                                                                                                                                                                                                                                           |
| Android SDK Build-tools    | 32.0.0<br>31.0.0<br>30.0.0 30.0.1 30.0.2 30.0.3<br>29.0.0 29.0.1 29.0.2 29.0.3<br>28.0.0 28.0.1 28.0.2 28.0.3<br>27.0.0 27.0.1 27.0.2 27.0.3<br>26.0.0 26.0.1 26.0.2 26.0.3<br>25.0.0 25.0.1 25.0.2 25.0.3<br>24.0.0 24.0.1 24.0.2 24.0.3<br>23.0.1 23.0.2 23.0.3 |
| Android SDK Platform-Tools | 33.0.2                                                                                                                                                                                                                                                            |
| Android SDK Platforms      | android-32 (rev 1)<br>android-31 (rev 1)<br>android-30 (rev 3)<br>android-29 (rev 5)<br>android-28 (rev 6)<br>android-27 (rev 3)<br>android-26 (rev 2)<br>android-25 (rev 3)<br>android-24 (rev 2)<br>android-23 (rev 3)                                          |
| Android SDK Tools          | 26.1.1                                                                                                                                                                                                                                                            |
| Android Support Repository | 47.0.0                                                                                                                                                                                                                                                            |
| CMake                      | 3.10.2<br>3.18.1                                                                                                                                                                                                                                                  |
| Google APIs                | addon-google_apis-google-21<br>addon-google_apis-google-22<br>addon-google_apis-google-23<br>addon-google_apis-google-24                                                                                                                                          |
| Google Play services       | 49                                                                                                                                                                                                                                                                |
| Google Repository          | 58                                                                                                                                                                                                                                                                |
| NDK                        | 21.4.7075529 (default)<br>23.2.8568313                                                                                                                                                                                                                            |
| SDK Patch Applier v4       | 1                                                                                                                                                                                                                                                                 |

#### Environment variables
| Name                    | Value                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------ |
| ANDROID_HOME            | /usr/local/lib/android/sdk                                                           |
| ANDROID_NDK_HOME        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_NDK_LATEST_HOME | /usr/local/lib/android/sdk/ndk/23.2.8568313                                          |
| ANDROID_NDK_ROOT        | /usr/local/lib/android/sdk/ndk-bundle -> /usr/local/lib/android/sdk/ndk/21.4.7075529 |
| ANDROID_SDK_ROOT        | /usr/local/lib/android/sdk                                                           |

### Cached Docker images
| Repository:Tag          | Digest                                                                   | Created    |
| ----------------------- | ------------------------------------------------------------------------ | ---------- |
| alpine:3.12             | sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69  | 2022-04-05 |
| alpine:3.13             | sha256:ccf92aa53bc6c3b25be2ad0cce80baec1778f007f7e076b0ffbd1b225d0b3a9b  | 2022-04-05 |
| alpine:3.14             | sha256:06b5d462c92fc39303e6363c65e074559f8d6b1363250027ed5053557e3398c5  | 2022-04-05 |
| buildpack-deps:bullseye | sha256:898c2264db514062f89391a9ae58e25bfcaa94d9fed04abf789a4abb53ee2fd6  | 2022-05-28 |
| buildpack-deps:buster   | sha256:3a56627334c11ff56aa16fa7c8922cfc17d506fe41f9155e350b1e02edb0e77d  | 2022-05-28 |
| buildpack-deps:stretch  | sha256:a87bd91f037696862c341a73f6607cfb5d462ffcec16de34f59bab0f21b61868  | 2022-05-28 |
| debian:10               | sha256:e5b41ae2b4cf0d04b80cd2f89724e9cfc09e334ac64f188b9808929c748af526  | 2022-05-28 |
| debian:11               | sha256:3f1d6c17773a45c97bd8f158d665c9709d7b29ed7917ac934086ad96f92e4510  | 2022-05-28 |
| debian:9                | sha256:22cb208880101b9a665332a9360ba4c5c021e3ed2f791638369e9a9418dac981  | 2022-05-28 |
| moby/buildkit:latest    | sha256:0dc312b04eac1b44cd2cad566deb1e886c753109208affbbec8384f381ff7f38  | 2022-05-06 |
| node:12                 | sha256:01627afeb110b3054ba4a1405541ca095c8bfca1cb6f2be9479c767a2711879e  | 2022-04-20 |
| node:12-alpine          | sha256:d4b15b3d48f42059a15bd659be60afe21762aae9d6cbea6f124440895c27db68  | 2022-04-11 |
| node:14                 | sha256:3324c688c0e98888f8938509f35356acf69a3e1f9f385d85f7e6086b137c17e3  | 2022-05-28 |
| node:14-alpine          | sha256:c9b8829068199346e2a9ae46f870bbb82ce44de6580321300bf3945d00dee0f1  | 2022-05-18 |
| node:16                 | sha256:59eb4e9d6a344ae1161e7d6d8af831cb50713cc631889a5a8c2d438d6ec6aa0f  | 2022-05-28 |
| node:16-alpine          | sha256:1a9a71ea86aad332aa7740316d4111ee1bd4e890df47d3b5eff3e5bded3b3d10  | 2022-04-27 |
| ubuntu:16.04            | sha256:20858ebbc96215d6c3c574f781133ebffdc7c18d98af4f294cc4c04871a6fe61  | 2021-08-31 |
| ubuntu:18.04            | sha256:d21b6ba9e19feffa328cb3864316e6918e30acfd55e285b5d3df1d8ca3c7fd3f  | 2022-04-29 |
| ubuntu:20.04            | sha256:47f14534bda344d9fe6ffd6effb95eefe579f4be0d508b7445cf77f61a0e5724  | 2022-04-29 |

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
| curl              | 7.58.0-2ubuntu3.18                |
| dbus              | 1.12.2-1ubuntu1.3                 |
| dnsutils          | 1:9.11.3+dfsg-1ubuntu1.17         |
| dpkg              | 1.19.0.5ubuntu2.4                 |
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
| libcurl3          | 7.58.0-2ubuntu3.18                |
| libgbm-dev        | 20.0.8-0ubuntu1\~18.04.1          |
| libgconf-2-4      | 3.2.6-4ubuntu1                    |
| libgsl-dev        | 2.4+dfsg-6                        |
| libgtk-3-0        | 3.22.30-1ubuntu4                  |
| libmagic-dev      | 1:5.32-2ubuntu0.4                 |
| libmagickcore-dev | 8:6.9.7.4+dfsg-16ubuntu6.12       |
| libmagickwand-dev | 8:6.9.7.4+dfsg-16ubuntu6.12       |
| libsecret-1-dev   | 0.18.6-1                          |
| libsqlite3-dev    | 3.22.0-1ubuntu0.5                 |
| libtool           | 2.4.6-2                           |
| libunwind8        | 1.2.1-8                           |
| libxkbfile-dev    | 1:1.0.9-2                         |
| libxss1           | 1:1.2.2-1                         |
| locales           | 2.27-3ubuntu1.6                   |
| m4                | 1.4.18-1                          |
| mediainfo         | 17.12-1                           |
| mercurial         | 4.5.3-1ubuntu2.2                  |
| net-tools         | 1.60+git20161116.90da8a0-1ubuntu1 |
| netcat            | 1.10-41.1                         |
| openssh-client    | 1:7.6p1-4ubuntu0.7                |
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
| sqlite3           | 3.22.0-1ubuntu0.5                 |
| ssh               | 1:7.6p1-4ubuntu0.7                |
| sshpass           | 1.06-1                            |
| subversion        | 1.9.7-4ubuntu1.1                  |
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
| xz-utils          | 5.2.2-1.3ubuntu0.1                |
| zip               | 3.0-11build1                      |
| zsync             | 0.6.2-3ubuntu1                    |


